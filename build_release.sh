#!/usr/bin/env bash
set -euo pipefail

VERSION=$1
CHANGELOG="CHANGELOG.md"
RELEASE_NOTES=".release_notes.tmp"
GITHUB_NOTES=".github_notes.tmp"
HEAD_BRANCH=$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)

last_tag=$(git describe --tags --abbrev=0)
echo "Generating changes since $last_tag"

repo_url="https://github.com/ieaster1/test-make-release"

if ! git log "$last_tag"..HEAD --oneline | grep .; then
    echo "No commits found since $last_tag. Aborting release."
    exit 1
fi

declare -A categories=(
    ["breaking"]="🚨 Breaking Changes"
    ["feat"]="✨ Features"
    ["fix"]="🐛 Bug Fixes"
    ["perf"]="🚀 Performance Improvements"
    ["security"]="🔒 Security"
    ["chore"]="🏗️ Chores"
    ["refactor"]="♻️ Refactoring"
    ["test"]="🧪 Tests"
    ["build"]="👷 Build System"
    ["ci"]="🔄 Continuous Integration"
    ["style"]="💄 Styling"
    ["revert"]="⏪️ Reverts"
    ["utils"]="🛠️ Utilities"
    ["deps"]="⬆️ Dependencies"
    ["docs"]="📝 Documentation"
)

# define the order we want categories to appear
# this is slightly redundant, but it ensures the order
# of categories in the release notes
category_order=(
    "breaking"
    "feat"
    "fix"
    "perf"
    "security"
    "chore"
    "refactor"
    "test"
    "build"
    "ci"
    "style"
    "revert"
    "utils"
    "deps"
    "docs"
)

cat > "$RELEASE_NOTES" << EOF
## [$VERSION] - $(date +%Y-%m-%d)

EOF

for prefix in "${category_order[@]}"; do
    commits=$(git log --pretty=format:" - %s (%h)" "$last_tag"..HEAD | grep "$prefix:" | sed "s/$prefix: //" || echo "")
    if [ -n "$commits" ]; then
        cat >> "$RELEASE_NOTES" << EOF
### ${categories[$prefix]}
$commits

EOF
    fi
done

category_pattern=$(printf '%s|' "${!categories[@]}" | sed 's/|$//')
other=$(git log --pretty=format:" - %s (%h)" "$last_tag"..HEAD | grep -v -E "($category_pattern):" || echo "")

if [ -n "$other" ]; then
    cat >> "$RELEASE_NOTES" << EOF
### 🥔 Other Changes
$other

EOF
fi

# create github release notes (includes url at bottom)
cp "$RELEASE_NOTES" "$GITHUB_NOTES"
echo -e "[$VERSION]: $repo_url/compare/$last_tag...$VERSION" >> "$GITHUB_NOTES"

# update CHANGELOG.md
if [ -f "$CHANGELOG" ]; then
    # extract changelog contents, no urls
    grep -v '^\[[0-9]\+\.[0-9]\+\.[0-9]\+\]:' "$CHANGELOG" > .changelog_content.tmp

    # extract existing urls
    grep '^\[[0-9]\+\.[0-9]\+\.[0-9]\+\]:' "$CHANGELOG" > .urls.tmp || true

    # create new changelog
    cat "$RELEASE_NOTES" > .new_changelog.tmp
    cat .changelog_content.tmp >> .new_changelog.tmp
    echo "[$VERSION]: $repo_url/compare/$last_tag...$VERSION" > .all_urls.tmp
    cat .urls.tmp >> .all_urls.tmp
    cat .all_urls.tmp >> .new_changelog.tmp

    mv .new_changelog.tmp "$CHANGELOG"
else
    cat "$RELEASE_NOTES" > "$CHANGELOG"
    echo "" >> "$CHANGELOG"
    echo "[$VERSION]: $repo_url/compare/$last_tag...$VERSION" >> "$CHANGELOG"
fi

git add "$CHANGELOG"
git commit -m "docs: update changelog for version $VERSION"
git push origin "$HEAD_BRANCH"
git tag "$VERSION"
git push origin "$VERSION"

# gh release with $GITHUB_NOTES
gh release create "$VERSION" \
    --latest \
    --title "Release $VERSION" \
    --notes "$(cat $GITHUB_NOTES)"

# cleanup
rm -f "$RELEASE_NOTES" "$GITHUB_NOTES" .changelog_content.tmp .urls.tmp .all_urls.tmp

echo "Release $VERSION created successfully!"