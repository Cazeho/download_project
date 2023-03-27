$ImagePath = "C:\Users\vagrant\Pictures\original.png"
$RegKey = "HKCU:\Control Panel\Desktop"
$RegValue = "Wallpaper"

# Set the wallpaper style
Set-ItemProperty -Path $RegKey -Name WallpaperStyle -Value 2

# Set the wallpaper to stretch to fit the screen
Set-ItemProperty -Path $RegKey -Name WallpaperTile -Value 0

# Set the wallpaper image
Set-ItemProperty -Path $RegKey -Name $RegValue -Value $ImagePath


$RegKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$RegValue = "LockScreenImage"

# Set the lock screen image
Set-ItemProperty -Path $RegKey -Name $RegValue -Value $ImagePath

gpupdate /force


# Refresh the desktop
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
