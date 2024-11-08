# Ruta del ejecutable SoundVolumeView
$soundVolumeViewPath = "C:\dani\sound\SoundVolumeView.exe"

# Verifica si el archivo SoundVolumeView existe
if (Test-Path $soundVolumeViewPath) {

    # Bajar el volumen de Spotify al 10%
    Start-Process $soundVolumeViewPath -ArgumentList "/SetVolume", "Spotify", "0"

    # Reproducir locución
    $audioFilePath = "C:\dani\audio.wav"

    if (Test-Path $audioFilePath) {
        Write-Host "Reproduciendo audio..."
        (New-Object Media.SoundPlayer $audioFilePath).PlaySync()
    } else {
        Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show("El audio no se ha encontrado, contacta con Dani para solventar este problema", "Aviso", 'OK', 'Information')
    }

    # Subir el volumen de Spotify al 100%
    Start-Process $soundVolumeViewPath -ArgumentList "/SetVolume", "Spotify", "100"

} else {
    Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show("SoundVolumeView no encontrado, contacta con Dani para solventar este problema", "Aviso", 'OK', 'Information')
}
