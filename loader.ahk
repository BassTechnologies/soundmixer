TrayTip, Обновление, В процессе
Process, WaitClose, SoundMixer.exe
FileDelete, %A_WorkingDir%\SoundMixer.exe
FileMove, %A_WorkingDir%\SoundMixerUpdate.exe, %A_WorkingDir%\SoundMixer.exe, 1
FileGetSize, OutputVar, %A_WorkingDir%\SoundMixerUpdate.exe
if OutputVar = 
{
TrayTip, Обновление, Завершаю
run, %A_WorkingDir%\SoundMixer.exe
TrayTip, Обновление, Успешно завершено
ExitApp
}
else
{
MsgBox,,Обновление, При обновлении клиента возникла ошибка, необходим ручной запуск файла [SoundMixerUpdate.exe].
ExitApp
}
