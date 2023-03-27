$user = $env:USERNAME

$url = "https://media.cdn.teamtailor.com/images/s3/teamtailor-production/user_picture_1200-v5/image_uploads/1bca5182-3f71-490e-b17d-a314e947ed1d/original.png"
$outputDir = "C:\Users\$user\Pictures"
$outputPath = Join-Path $outputDir "original.png"

# Download the image using wget
wget $url -OutFile $outputPath




$ImagePath = "C:\Users\$user\Pictures\original.png"
$RegKey = "HKCU:\Control Panel\Desktop"
$RegValue = "Wallpaper"

# Set the wallpaper style
Set-ItemProperty -Path $RegKey -Name WallpaperStyle -Value 1

# Set the wallpaper to stretch to fit the screen
Set-ItemProperty -Path $RegKey -Name WallpaperTile -Value 0

# Set the wallpaper image
Set-ItemProperty -Path $RegKey -Name $RegValue -Value $ImagePath



$regKey = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'
# create the key if it doesn't already exist
if (!(Test-Path -Path $regKey)) {
   $null = New-Item -Path $regKey
}

Set-ItemProperty -Path $regKey -Name LockScreenImage -value $ImagePath


# Refresh the desktop
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
