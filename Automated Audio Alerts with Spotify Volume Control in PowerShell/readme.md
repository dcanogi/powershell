# PowerShell Script: Audio Notification with Spotify Volume Control

## Overview

This PowerShell script is designed for gyms to automatically announce the gym rules every hour. It lowers the volume of Spotify during the announcement and restores it afterward. The script leverages **NirSoft's SoundVolumeView** utility to control the volume of specific applications.

## Features

- **Automated Announcements**: Plays a pre-recorded `.wav` file that announces the gym rules every hour.
- **Spotify Volume Control**: Temporarily lowers Spotify volume to ensure the announcement is clearly audible.
- **Error Handling**: Alerts gym staff if the audio file or SoundVolumeView utility is missing.

## Requirements

- **PowerShell**: Make sure you are running PowerShell 5.0 or later.
- **SoundVolumeView by NirSoft**: Required for adjusting application volumes.
  - [Download SoundVolumeView](https://www.nirsoft.net/utils/sound_volume_view.html)
- A `.wav` audio file containing the gym rules.

## Installation

1. Download **SoundVolumeView** from the [official NirSoft website](https://www.nirsoft.net/utils/sound_volume_view.html).
2. Place the `SoundVolumeView.exe` file in a directory (e.g., `C:\gym\sound`).
3. Record the gym rules in a `.wav` file and save it (e.g., `C:\gym\audio.wav`).

## Script Usage

Copy the following PowerShell script to a file named `gym-announcement.ps1`:

```powershell
# Path to the SoundVolumeView executable
$soundVolumeViewPath = "C:\gym\sound\SoundVolumeView.exe"

# Check if SoundVolumeView exists
if (Test-Path $soundVolumeViewPath) {

    # Lower Spotify volume to 10%
    Start-Process $soundVolumeViewPath -ArgumentList "/SetVolume", "Spotify", "10"

    # Path to the audio file
    $audioFilePath = "C:\gym\audio.wav"

    # Check if the audio file exists
    if (Test-Path $audioFilePath) {
        Write-Host "Playing gym rules announcement..."
        (New-Object Media.SoundPlayer $audioFilePath).PlaySync()
    } else {
        # Show alert if the audio file is not found
        Add-Type -AssemblyName PresentationFramework
        [System.Windows.MessageBox]::Show("Audio file not found. Please contact gym management for assistance.", "Alert", 'OK', 'Warning')
    }

    # Restore Spotify volume to 100%
    Start-Process $soundVolumeViewPath -ArgumentList "/SetVolume", "Spotify", "100"

} else {
    # Show alert if SoundVolumeView is not found
    Add-Type -AssemblyName PresentationFramework
    [System.Windows.MessageBox]::Show("SoundVolumeView not found. Please contact gym management for assistance.", "Alert", 'OK', 'Warning')
}
