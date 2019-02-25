#SingleInstance ignore
FileInstall, E:\loader\loader.exe, E:\loader.exe, 1
if not A_IsAdmin
    Run *RunAs "%A_ScriptFullPath%"
clientv = 0.2
;/////Авто-обновление \\\\\
oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
oWhr.Open("GET", "http://blast.hk/threads/30742/", false)
oWhr.Send()
html := oWhr.ResponseText
RegExMatch(html, "Актуальная версия - (.*)v<br />", version)
RegExMatch(html, "id файла - (.*)n<br />", load)
if version1 = % clientv
{
}
else
{
MsgBox, 262212, Вышло обновление, 	Версия вашего клиента - %clientv%`nПоследняя версия - %version1%`n`nЖелаете загрузить актуальную версию прямо сейчас?
IfMsgBox Yes
{
FileGetSize, OutputVar, %A_WorkingDir%\loader.exe
if OutputVar =
{
MsgBox,,Обновление, Файл [Loader.exe] отсутствует
}
else
{
UrlDownloadToFile, http://blast.hk/attachments/%load1%, %A_WorkingDir%\SoundMixerUpdate.exe
TrayTip, Обновление, В процессе
run, %A_WorkingDir%\loader.exe
ExitApp
}
}
IfMsgBox No
{
}
}
;/////Авто-обновление \\\\\
var = 0
    Gui, Margin, 10, 10
    Gui, Add, ListView, w500 h600 vList +AltSubmit, PID|Process Name|Command Line
    for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
LV_Add("", process.ProcessID, process.Name, process.CommandLine)
LV_ModifyCol() 
LV_Add("", "228", "[BASSN.O] DEDeCD", "Specially for BlastHack")
    Gui, Add, Hotkey, x26 y620 w50 h20 vHot1 gHot1 +disabled,
    Gui, Add, Hotkey, x86 y620 w50 h20 vHot2 gHot2 +disabled,
    Gui, Add, Hotkey, x146 y620 w50 h20 vHot3 gHot3 +disabled,
    Gui, Add, Hotkey, x206 y620 w50 h20 vHot4 gHot4 +disabled,
    Gui, Add, Radio, x356 y650 w75 h20 vAP gAllProcess +Checked, All process
    Gui, Add, Radio, x430 y650 w80 h20 vOM gOnlyMedia, Only media
    Gui, Add, Slider, x256 y620 w90 h20 vSlider Range0-100 ToolTip  +disabled, 0
    Gui, Add, Button, x356 y620 w70 h20 vSave gSave +disabled, Save
    Gui, Add, Button, x430 y620 w70 h20 vCancel gCancel +disabled, Cancel
    Gui, Show,w510 h680, Sound Mixer | v0.1
LV_Add("", "228", "[BASSN.O] DEDeCD", "Specially for BlastHack")
return

AllProcess:
LV_Delete()
    for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
LV_Add("", process.ProcessID, process.Name, process.CommandLine)
LV_Add("", "228", "[BASSN.O] DEDeCD", "Specially for BlastHack")
LV_ModifyCol() 
return
OnlyMedia:
LV_Delete()
Loop, Parse, % GetActive_Media(), `, 
{ 
PATH := GetModuleFileNameEx(A_LoopField) 
Loop, % PATH 
Name := A_LoopFileName 
LV_Add("", A_LoopField, Name, Path) 
}

LV_Add("", "228", "[BASSN.O] DEDeCD", "Specially for BlastHack")
LV_ModifyCol() 
return
cancel:
    GuiControl,, Hot1,
    GuiControl,, Hot2,
    GuiControl,, Hot3,
    GuiControl,, Hot4,
    GuiControl, disable, Slider
    GuiControl, disable, Save
    GuiControl, disable, Cancel
    GuiControl, Enable, List
    GuiControl, Enable, AP
    GuiControl, Enable, OM
var = 0
return

save:
    gui, submit, nohide
    A%usinghotkey% := slider
    hotkey, %Hot1%, 1hot1, on, UseErrorLevel
    hotkey, %Hot2%, 2hot2, on, UseErrorLevel
    hotkey, %Hot3%, 3hot3, on, UseErrorLevel
    hotkey, %Hot4%, 4hot4, on, UseErrorLevel
var = 0
    GuiControl, enable, AP
    GuiControl, enable, OM
    GuiControl,enable,list
    GuiControl,Disable,save
    GuiControl,Disable,cancel
    GuiControl,Disable,slider
    if errorlevel
    {
    }
return

GuiContextMenu:
selectedis = %A_EventInfo%
if A_EventInfo = 0
{
}
else
{
if var = 1
{
}
else
{
var = 1
    GuiControl, disable, AP
    GuiControl, disable, OM
    GuiControl, enable, Hot1
    GuiControl, enable, Hot2
    GuiControl, enable, Hot3
    GuiControl, enable, Hot4
    GuiControl, disable, List
}
}
return
hot1:
usinghotkey = 1
goto hot
hot2:
usinghotkey = 2
goto hot
hot3:
usinghotkey = 3
goto hot
hot4:
usinghotkey = 4
goto hot
hot:
    GuiControl, disable, AP
    GuiControl, disable, OM
    GuiControl, disable, Hot1
    GuiControl, disable, Hot2
    GuiControl, disable, Hot3
    GuiControl, disable, Hot4
    GuiControl, enable, Slider
    GuiControl, enable, Save
    GuiControl, enable, Cancel
return

1hot1:
    LV_GetText(ProcessId1, selectedis, 1)
    SetAppVolume(ProcessId1, A1)
return
2hot2:
    LV_GetText(ProcessId2, selectedis, 1)
    SetAppVolume(ProcessId2, A2)
return
3hot3:
    LV_GetText(ProcessId3, selectedis, 1)
    SetAppVolume(ProcessId3, A3)
return
4hot4:
    LV_GetText(ProcessId4, selectedis, 1)
    SetAppVolume(ProcessId4, A4)
return

SetAppVolume(pid, MasterVolume)  
{
    IMMDeviceEnumerator := ComObjCreate("{BCDE0395-E52F-467C-8E3D-C4579291692E}", "{A95664D2-9614-4F35-A746-DE8DB63617E6}")
    DllCall(NumGet(NumGet(IMMDeviceEnumerator+0)+4*A_PtrSize), "UPtr", IMMDeviceEnumerator, "UInt", 0, "UInt", 1, "UPtrP", IMMDevice, "UInt")
    ObjRelease(IMMDeviceEnumerator)

    VarSetCapacity(GUID, 16)
    DllCall("Ole32.dll\CLSIDFromString", "Str", "{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}", "UPtr", &GUID)
    DllCall(NumGet(NumGet(IMMDevice+0)+3*A_PtrSize), "UPtr", IMMDevice, "UPtr", &GUID, "UInt", 23, "UPtr", 0, "UPtrP", IAudioSessionManager2, "UInt")
    ObjRelease(IMMDevice)

    DllCall(NumGet(NumGet(IAudioSessionManager2+0)+5*A_PtrSize), "UPtr", IAudioSessionManager2, "UPtrP", IAudioSessionEnumerator, "UInt")
    ObjRelease(IAudioSessionManager2)

    DllCall(NumGet(NumGet(IAudioSessionEnumerator+0)+3*A_PtrSize), "UPtr", IAudioSessionEnumerator, "UIntP", SessionCount, "UInt")
    Loop % SessionCount
    {
        DllCall(NumGet(NumGet(IAudioSessionEnumerator+0)+4*A_PtrSize), "UPtr", IAudioSessionEnumerator, "Int", A_Index-1, "UPtrP", IAudioSessionControl, "UInt")
        IAudioSessionControl2 := ComObjQuery(IAudioSessionControl, "{BFB7FF88-7239-4FC9-8FA2-07C950BE9C6D}")
        ObjRelease(IAudioSessionControl)

        DllCall(NumGet(NumGet(IAudioSessionControl2+0)+14*A_PtrSize), "UPtr", IAudioSessionControl2, "UIntP", ProcessId, "UInt")
        If (pid == ProcessId)
        {
            ISimpleAudioVolume := ComObjQuery(IAudioSessionControl2, "{87CE5498-68D6-44E5-9215-6DA47EF883D8}")
            DllCall(NumGet(NumGet(ISimpleAudioVolume+0)+3*A_PtrSize), "UPtr", ISimpleAudioVolume, "Float", MasterVolume/100.0, "UPtr", 0, "UInt")
            ObjRelease(ISimpleAudioVolume)
        }
        ObjRelease(IAudioSessionControl2)
    }
    ObjRelease(IAudioSessionEnumerator)
}

GetModuleFileNameEx(p_pid) 
{ 
if A_OSVersion in WIN_95,WIN_98,WIN_ME 
{ 
MsgBox, This Windows version (%A_OSVersion%) is not supported. 
return 
} 

h_process := DllCall( "OpenProcess", "uint", 0x10|0x400, "int", false, "uint", p_pid ) 
if ( ErrorLevel or h_process = 0 ) 
return 

name_size = 255 
VarSetCapacity( name, name_size ) 

result := DllCall( "psapi.dll\GetModuleFileNameEx" ( A_IsUnicode ? "W" : "A" ), "uint", h_process, "uint", 0, "str", name, "uint", name_size ) 

DllCall( "CloseHandle", h_process ) 

return, name 
}

GetActive_Media() 
{ 
IMMDeviceEnumerator := ComObjCreate("{BCDE0395-E52F-467C-8E3D-C4579291692E}", "{A95664D2-9614-4F35-A746-DE8DB63617E6}") 
DllCall(NumGet(NumGet(IMMDeviceEnumerator+0)+4*A_PtrSize), "UPtr", IMMDeviceEnumerator, "UInt", 0, "UInt", 1, "UPtrP", IMMDevice, "UInt") 
ObjRelease(IMMDeviceEnumerator) 

VarSetCapacity(GUID, 16) 
DllCall("Ole32.dll\CLSIDFromString", "Str", "{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}", "UPtr", &GUID) 
DllCall(NumGet(NumGet(IMMDevice+0)+3*A_PtrSize), "UPtr", IMMDevice, "UPtr", &GUID, "UInt", 23, "UPtr", 0, "UPtrP", IAudioSessionManager2, "UInt") 
ObjRelease(IMMDevice) 

DllCall(NumGet(NumGet(IAudioSessionManager2+0)+5*A_PtrSize), "UPtr", IAudioSessionManager2, "UPtrP", IAudioSessionEnumerator, "UInt") 
ObjRelease(IAudioSessionManager2) 

DllCall(NumGet(NumGet(IAudioSessionEnumerator+0)+3*A_PtrSize), "UPtr", IAudioSessionEnumerator, "UIntP", SessionCount, "UInt") 
Loop % SessionCount 
{ 
DllCall(NumGet(NumGet(IAudioSessionEnumerator+0)+4*A_PtrSize), "UPtr", IAudioSessionEnumerator, "Int", A_Index-1, "UPtrP", IAudioSessionControl, "UInt") 
IAudioSessionControl2 := ComObjQuery(IAudioSessionControl, "{BFB7FF88-7239-4FC9-8FA2-07C950BE9C6D}") 
ObjRelease(IAudioSessionControl) 

DllCall(NumGet(NumGet(IAudioSessionControl2+0)+14*A_PtrSize), "UPtr", IAudioSessionControl2, "UIntP", ProcessId, "UInt") 
if (ProcessId) 
PID .= ProcessId "," 
ObjRelease(IAudioSessionControl2) 
} 
ObjRelease(IAudioSessionEnumerator) 
StringTrimRight, PID, PID, 1 
return PID 
}

end::reload
!end::ExitApp