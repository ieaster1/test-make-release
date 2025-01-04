## InfoVue Changelog

## [2.9.1]
 * feat: InfovueEncoderMonitor monitors player services state and restarts where necessary
 * feat: during updates from CMS, autonomy halts the monitor to prevent interruption
 * fix: updated infovue KB links
 * chore: updated InfovueEncoderMonitor to use 'net.exe' for service management
 * feat(util): disable_taskbar.exe: to hide the Windows Task Bar in the desktop environment
 * feat(util): added script to InfoVue/bin to remove shortcuts from infovue user and Public paths
 * refactor(util): Disable_Keyboard_Shortcuts.exe: updated to disable a more comprehensive list of keyboard combinations and shortcuts

## [2.2.2]
 * capture card support: DeckLink Mini Recorder, DeckLink Mini Recorder HD, DeckLink Mini Recorder 4K, Intensity Pro
 * bug fix: encoder command builder properly check capture cards
 * audio loopback udp stream updated to encode source to an mp3 stream for Player compatibility
 * added System Model to Config>About page

## [2.2.1]
 * fixed incorrect variable for capture_card_type
 * IV UEFI Build commits
 * lock screen network icon, power icon. config lockdown ie and edge
 * W10 ug
 * add lock screen image to 32 bit reg view

## [2.2.0]
 * windows 10 support
 * Blackmagic Mini Recorder support
 * AC3 audio enabled.
 * purging temporary internet files is more robust.
 * git inited repo on unit.

## [2.1.2]
 * update support for new version of USB dongle.
 * hide encoder on infovue standard
 * fix issue with caching on dashboard
 * fix bug where time on web ui wouldn't update after changing time zone until you navigated to a new page.
 * new version of blackmagic drivers and ffmpeg, in preparation for mini recorder.

## [2.1.1]
 * Fix support for USB audio device plugged into all USB ports. (previously only top right worked)
 * Fix UI showing USB options when no device was present.
 * Improved Compatibility with flash.
 * Expose windows aero theme under, 'double buffering' line in output settings.

## [2.1.0]
 * USB audio

## [2.0.2]
 * added editing hostfile to the UI

## [2.0.1]
 * fixed an issue where the encoder would not properly restart if a hiccup in an audio stream caused ffmpeg to hang.

## [2.0.0]
 * added support for Capture card

## [1.1.5]
 * Added Support for 59.94 and 60 fps for all resolutions except 1080i

## [1.1.4]
 * Improved InfoVue Stick's handling of high DPI displays
 * Improved Wireless performance of InfoVue Stick

## [1.1.3]
 * Fixed a bug that would cause a stream to degrade over time when an external audio source was used.
 * Seneca Build Process streamlined.

## [1.1.2]
 * Fixed a bug causing GEFEN status to cause the UI to error.
 * Fixed display of disk space on dashboard.
 * Made a bug where the UI would fail to set the screen resolution less likely.
 * Fixed a bug in backwards compatibility with encoder config files from older versions.
 * Improved tolerance to widely variable bitrate streams in the h264 encoder.
 * Upgraded the InfoVue Stick to Windows 10

## [1.1.1]
 * InfoVue Stick updated to handle errors more gracefully
 * Handle a bug causing temporary internet files to consume all disk space sometimes when streaming using IE.

## [1.1.0]
 * Added InfoVue UI. Most non-content related configuration is handled here.
 * Improved metadata for the outgoing transport stream.
 * Added support for Audio Channels (mono and stereo)
 * Allow older versions of RDP
 * Built install and upgrade executables.
 * Improved logic for GOP size
 * Improved error handling to prevent blocking playout.
 * Prevented some stray windows background processes.
 * Added Gefen Status to UI Dashboard
 * Set GW metric to prioritize eth1
 * Cleaned up Log file of extraneous chatter

## [1.0.2]
 * Allowed ICMP traffic (ping)
 * Prevent Windows UI scaling regardless of attached monitor.
 * upgraded graphics drivers

## [1.0.1] -- 
 * Installed TigerVNC
 * Sped up shutdown process
 * Added log rotation for infovue encoder logs
 * Added support for profile, level, x264opts, muxrate, and input_frame_rate into config file
 * Prevented a case where WMplayer would pop up in front of signage
 * Created the InfoVue Stick for Previewing material.
 * Set Default Nic settings for eth 1 to 192.168.0.242/24
 * Updated firewall settings to allow ffmeg and IV engine full network access
 * Added more information to wallpaper system information printout

## [1.0.0] -- Initial release





