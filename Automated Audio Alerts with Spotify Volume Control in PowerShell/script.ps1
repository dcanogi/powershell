# Path to the SoundVolumeView executable
$soundVolumeViewPath = "C:\dani\sound\SoundVolumeView.exe"

# Check if SoundVolumeView exists
if (Test-Path $soundVolumeViewPath) {

    # Lower Spotify volume to 10%
    Start-Process $soundVolumeViewPath -ArgumentList "/SetVolume", "Spotify", "10"

    # Path to the audio file
    $audioFilePath = "C:\dani\audio.wav"

    # Check if the audio file exists
    if (Test-Path $audioFilePath) {
        Write-Host "Playing audio..."
        (New-Object Media.SoundPlayer $audioFilePath).PlaySync()
    } else {
        # Show alert if the audio file is not found
        Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show("Audio file not found. Please contact Dani for assistance.", "Notice", 'OK', 'Information')
    }

    # Restore Spotify volume to 100%
    Start-Process $soundVolumeViewPath -ArgumentList "/SetVolume", "Spotify", "100"

} else {
    # Show alert if SoundVolumeView is not found
    Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show("SoundVolumeView not found. Please contact Dani for assistance.", "Notice", 'OK', 'Information')
}
