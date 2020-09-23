VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "PanosDll"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private Declare Function RegSetValueEx Lib "advapi32" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, ByVal szData As String, ByVal cbData As Long) As Long
Private Declare Function RegCloseKey Lib "advapi32" (ByVal hKey As Long) As Long
Private Declare Function RegCreateKeyEx Lib "advapi32" Alias "RegCreateKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal Reserved As Long, ByVal lpClass As String, ByVal dwOptions As Long, ByVal samDesired As Long, lpSecurityAttributes As SECURITY_ATTRIBUTES, phkResult As Long, lpdwDisposition As Long) As Long
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Private Declare Sub SetWindowPos Lib "user32" (ByVal hwnd As Integer, ByVal hWndInsertAfter As Integer, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal wFlags As Integer)
Private Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Integer, ByVal hwndCallback As Integer) As Long
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Integer, ByVal lParam As Long) As Long
Private Declare Function sndPlaySound Lib "winmm.dll" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long
Private Declare Function GetComputerNameA Lib "kernel32" (ByVal lpBuffer As String, nSize As Long) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Function ChangeDisplaySettings Lib "user32" Alias "ChangeDisplaySettingsA" (lpInitData As DEVMODE, ByVal dwFlags As Long) As Long
Private Declare Function EnumDisplaySettings Lib "user32" Alias "EnumDisplaySettingsA" (ByVal lpszDeviceName As Long, ByVal iModeNum As Long, lpDevMode As DEVMODE) As Long
Private Declare Function ExitWindowsEx Lib "user32" (ByVal uFlags As Long, ByVal dwReserved As Long) As Long
Private Declare Function GetUserNameA Lib "advapi32.dll" (ByVal lpBuffer As String, nSize As Long) As Long
Private Declare Function GetSystemDirectoryA Lib "kernel32" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
Private Declare Function GetWindowsDirectoryA Lib "kernel32" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
Private Declare Function ShowCursor Lib "user32" (ByVal bShow As Long) As Long
Private Declare Function GetSystemMenu Lib "user32" (ByVal hwnd As Long, ByVal bRevert As Long) As Long
Private Declare Function GetMenuItemCount Lib "user32" (ByVal hMenu As Long) As Long
Private Declare Function DrawMenuBar Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function RemoveMenu Lib "user32" (ByVal hMenu As Long, ByVal nPosition As Long, ByVal wFlags As Long) As Long
Private Declare Function SystemParametersInfo Lib "user32" Alias "SystemParametersInfoA" (ByVal uAuction As Long, ByVal uParam As Long, ByVal lpvParam As Any, ByVal fuWinIni As Long) As Long
Private Declare Function GetCurrentProcessId Lib "kernel32" () As Long
Private Declare Function RegisterServiceProcess Lib "kernel32" (ByVal dwProcessID As Long, ByVal dwType As Long) As Long
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function RasEnumConnections Lib "RasApi32.DLL" Alias "RasEnumConnectionsA" (lprasconn As Any, lpcb As Long, lpcConnections As Long) As Long
Private Declare Function RasEnumEntries Lib "RasApi32.DLL" Alias "RasEnumEntriesA" (ByVal Reserved As String, ByVal lpszPhonebook As String, lprasentryname As Any, lpcb As Long, lpcEntries As Long) As Long
Private Declare Function fCreateShellLink Lib "VB5STKIT.DLL" (ByVal lpstrFolderName As String, ByVal lpstrLinkName As String, ByVal lpstrLinkPath As String, ByVal lpstrLinkArgs As String) As Long
Private Declare Function GetDiskFreeSpace Lib "kernel32" Alias "GetDiskFreeSpaceA" (ByVal lpRootPathName As String, lpSectorsPerCluster As Long, lpBytesPerSector As Long, lpNumberOfFreeClusters As Long, lpTotalNumberOfClusters As Long) As Long
Private Declare Function BitBlt Lib "GDI32" (ByVal hDestDC As Integer, ByVal x As Integer, ByVal y As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal hSrcDC As Integer, ByVal XSrc As Integer, ByVal YSrc As Integer, ByVal dwRop As Long) As Integer
Private Declare Function waveOutGetNumDevs Lib "winmm.dll" () As Long
Private Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hwnd As Long, lpdwProcessId As Long) As Long
Private Declare Function Shell_NotifyIconA Lib "SHELL32" (ByVal dwMessage As Long, lpData As NOTIFYICONDATA) As Integer
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function ShowWindow Lib "user32" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long

Private Const CCHDEVICENAME = 32
Private Const CCHFORMNAME = 32
Private Const KEY_CREATE_SUB_KEY = &H4
Private Const SYNCHRONIZE = &H100000
Private Const KEY_NOTIFY = &H10
Private Const ERROR_SUCCESS = 0&
Private Const KEY_CREATE_LINK = &H20
Private Const KEY_ENUMERATE_SUB_KEYS = &H8
Private Const KEY_QUERY_VALUE = &H1
Private Const KEY_SET_VALUE = &H2
Private Const STANDARD_RIGHTS_ALL = &H1F0000
Private Const KEY_ALL_ACCESS = ((STANDARD_RIGHTS_ALL Or KEY_QUERY_VALUE Or KEY_SET_VALUE Or KEY_CREATE_SUB_KEY Or KEY_ENUMERATE_SUB_KEYS Or KEY_NOTIFY Or KEY_CREATE_LINK) And (Not SYNCHRONIZE))
Private Const REG_OPTION_NON_VOLATILE = 0
Private Const WM_DESTROY = &H2
Private Const WM_MOUSEMOVE = &H200
Private Const SWP_NOSIZE = &H1
Private Const SWP_NOMOVE = &H2
Private Const SWP_NOZORDER = &H4
Private Const SWP_NOREDRAW = &H8
Private Const SWP_NOACTIVATE = &H10
Private Const SWP_FRAMECHANGED = &H20
Private Const CDS_UPDATEREGISTRY = &H1
Private Const CDS_TEST = &H2
Private Const CDS_FULLSCREEN = &H4
Private Const CDS_GLOBAL = &H8
Private Const CDS_SET_PRIMARY = &H10
Private Const CDS_RESET = &H40000000
Private Const CDS_SETRECT = &H20000000
Private Const CDS_NORESET = &H10000000
Private Const DISP_CHANGE_SUCCESSFUL = 0
Private Const DISP_CHANGE_RESTART = 1
Private Const DISP_CHANGE_FAILED = -1
Private Const DISP_CHANGE_BADMODE = -2
Private Const DISP_CHANGE_NOTUPDATED = -3
Private Const DISP_CHANGE_BADFLAGS = -4
Private Const DISP_CHANGE_BADPARAM = -5
Private Const SWP_SHOWWINDOW = &H40
Private Const SWP_HIDEWINDOW = &H80
Private Const SWP_NOCOPYBITS = &H100
Private Const SWP_NOOWNERZORDER = &H200
Private Const SWP_DRAWFRAME = SWP_FRAMECHANGED
Private Const SWP_NOREPOSITION = SWP_NOOWNERZORDER
Private Const HWND_TOP = 0
Private Const HWND_BOTTOM = 1
Private Const HWND_TOPMOST = -1
Private Const HWND_NOTOPMOST = -2
Private Const RAS_MaxDeviceType = 16
Private Const RAS95_MaxDeviceName = 128
Private Const RAS95_MaxEntryName = 256
Private Const SPI_SCREENSAVERRUNNING = 97
Private Const WS_EX_TRANSPARENT = &H20&
Private Const GWL_EXSTYLE = (-20)
Private Const RSP_SIMPLE_SERVICE = 1
Private Const RSP_UNREGISTER_SERVICE = 0
Private Const EWX_LOGOFF = 0
Private Const EWX_SHUTDOWN = 1
Private Const EWX_REBOOT = 2
Private Const EWX_FORCE = 4
Private Const MF_BYPOSITION = &H400&
Private Const MF_REMOVE = &H1000&
Private Const SPI_SETDESKWALLPAPER = 20
Private Const SPIF_UPDATEINIFILE = &H1
Private Const DM_BITSPERPEL = &H40000
Private Const DM_PELSWIDTH = &H80000
Private Const DM_PELSHEIGHT = &H100000
Private Const SPIF_SENDWININICHANGE = &H2
Private Const NIM_ADD = 0
Private Const NIM_MODIFY = 1
Private Const NIM_DELETE = 2
Private Const NIF_MESSAGE = 1
Private Const NIF_ICON = 2
Private Const NIF_TIP = 4

Private Type DEVMODE
    dmDeviceName As String * CCHDEVICENAME
    dmSpecVersion As Integer
    dmDriverVersion As Integer
    dmSize As Integer
    dmDriverExtra As Integer
    dmFields As Long
    dmOrientation As Integer
    dmPaperSize As Integer
    dmPaperLength As Integer
    dmPaperWidth As Integer
    dmScale As Integer
    dmCopies As Integer
    dmDefaultSource As Integer
    dmPrintQuality As Integer
    dmColor As Integer
    dmDuplex As Integer
    dmYResolution As Integer
    dmTTOption As Integer
    dmCollate As Integer
    dmFormName As String * CCHFORMNAME
    dmUnusedPadding As Integer
    dmBitsPerPel As Integer
    dmPelsWidth As Long
    dmPelsHeight As Long
    dmDisplayFlags As Long
    dmDisplayFrequency As Long
End Type

Private Type SECURITY_ATTRIBUTES
    nLength As Long
    lpSecurityDescriptor As Long
    bInheritHandle As Boolean
End Type
Private Type RASCONN95
    dwSize As Long
    hRasConn As Long
    szEntryName(RAS95_MaxEntryName) As Byte
    szDeviceType(RAS_MaxDeviceType) As Byte
    szDeviceName(RAS95_MaxDeviceName) As Byte
End Type
Private Type RASENTRYNAME95
    dwSize As Long
    szEntryName(RAS95_MaxEntryName) As Byte
End Type
Private Type NOTIFYICONDATA
    cbSize As Long
    hwnd As Long
    uID As Long
    uFlags As Long
    uCallbackMessage As Long
    hIcon As Long
    szTip As String * 64
End Type
Dim D() As DEVMODE

Public Function GetWinDir()
   Dim s As String
   Dim i As Integer
   i = GetWindowsDirectoryA("", 0)
   s = Space(i)
   Call GetWindowsDirectoryA(s, i)
   GetWinDir = Left$(s, i - 1) & "\"

End Function

Public Function GetSystemDir()
   Dim s As String
   Dim i As Integer
   i = GetSystemDirectoryA("", 0)
   s = Space(i)
   Call GetSystemDirectoryA(s, i)
   GetSystemDir = Left$(s, i - 1) & "\"
End Function

Public Sub WholeScreenForm(f As Object)
f.Top = 0
f.Left = 0
f.Width = Screen.Width
f.Height = Screen.Height
End Sub

Sub Gradient(TheObject As Object, Redval&, Greenval&, Blueval&, TopToBottom As Boolean)
    Dim Step%, Reps%, FillTop%, FillLeft%, FillRight%, FillBottom%, HColor$
    Step = (TheObject.Height / 63)
    If TopToBottom = True Then FillTop = 0 Else FillTop = TheObject.Height - Step
    FillLeft = 0
    FillRight = TheObject.Width
    FillBottom = FillTop + Step
    For Reps = 1 To 63
        TheObject.Line (FillLeft, FillTop)-(FillRight, FillBottom), RGB(Redval, Greenval, Blueval), BF
        Redval = Redval - 4
        Greenval = Greenval - 4
        Blueval = Blueval - 4
        If Redval <= 0 Then Redval = 0
        If Greenval <= 0 Then Greenval = 0
        If Blueval <= 0 Then Blueval = 0
        If TopToBottom = True Then FillTop = FillBottom Else FillTop = FillTop - Step
        FillBottom = FillTop + Step
    Next
End Sub

Public Sub MakeIt3D(Ctrl As Object, nBevel%, nSpace%, bInset%)
Dim pixx%, pixy%, ctop%, clft%, crgt%, cbtm%, i%, addx%, addy%
        
       '     'Makes the passed control appear 3D.
       pixx% = Screen.TwipsPerPixelX
       pixy% = Screen.TwipsPerPixelY
       ctop% = Ctrl.Top - pixx%
       clft% = Ctrl.Left - pixy%
       crgt% = Ctrl.Left + Ctrl.Width
       cbtm% = Ctrl.Top + Ctrl.Height
       '     ' Color used below:
       '     ' dark gray = &H808080
       '     ' white = &HFFFFFF

              If bInset% Then 'recessed border

                            For i% = nSpace% To (nBevel% + nSpace% - 1)
                                   addx% = i% * pixx%
                                   addy% = i% * pixy%
                                   Ctrl.Parent.Line (clft% - addx%, ctop% - addy%)-(crgt% + addx%, ctop% - addy%), &H808080
                                   Ctrl.Parent.Line (clft% - addx%, ctop% - addy%)-(clft% - addx%, cbtm% + addy%), &H808080
                                   Ctrl.Parent.Line (clft% - addx%, cbtm% + addy%)-(crgt% + addx% + pixx%, cbtm% + addy%), &HFFFFFF
                                   Ctrl.Parent.Line (crgt% + addx%, ctop% - addy%)-(crgt% + addx%, cbtm% + addy%), &HFFFFFF
                            Next

              Else 'raised border

                            For i% = nSpace% To (nBevel% + nSpace% - 1)
                                   addx% = i% * pixx%
                                   addy% = i% * pixy%
                                   Ctrl.Parent.Line (crgt% + addx%, cbtm% + addy%)-(crgt% + addx%, ctop% - addy%), &H808080
                                   Ctrl.Parent.Line (crgt% + addx%, cbtm% + addy%)-(clft% - addx%, cbtm% + addy%), &H808080
                                   Ctrl.Parent.Line (crgt% + addx%, ctop% - addy%)-(clft% - addx% - pixx%, ctop% - addy%), &HFFFFFF
                                   Ctrl.Parent.Line (clft% - addx%, cbtm% + addy%)-(clft% - addx%, ctop% - addy%), &HFFFFFF
                            Next

              End If

End Sub

Public Sub SetOnTopForm(f As Object, Top As Boolean)
   If Top Then
    SetWindowPos f.hwnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE
    Else
     SetWindowPos f.hwnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE
   End If
End Sub


Public Sub PlayMid(sFilename As String)
Dim returnstring As String * 128, i%, CommandString, a&
returnstring = Space(128)
For i% = 1 To 3
 Select Case i%
  Case 1
   CommandString = "close mymid"
  Case 2
   CommandString = "open " & sFilename & _
   " type sequencer alias mymid"
  Case 3
   CommandString = "play mymid from 1"
 End Select
 a& = mciSendString _
 (CommandString, returnstring, Len(returnstring), 0)
Next i%
End Sub


Public Sub StopMid()

Dim returnstring As String * 128, CommandString, a&
returnstring = Space(128)

CommandString = "close mymid"

a& = mciSendString _
(CommandString, returnstring, Len(returnstring), 0)


End Sub


Public Sub PlayWav(sFilename As String)
Dim x&
x& = sndPlaySound(sFilename, 1)

End Sub

Public Function GetComputerName() As String
   Dim UserName As String * 255

   Call GetComputerNameA(UserName, 255)
   GetComputerName = Left$(UserName, InStr(UserName, Chr$(0)) - 1)
End Function

Public Sub HideTaskBar()
Dim TaskBarhWnd
    TaskBarhWnd = FindWindow("Shell_traywnd", "")
    If TaskBarhWnd <> 0 Then
       Call SetWindowPos(TaskBarhWnd, 0, 0, 0, 0, 0, SWP_HIDEWINDOW)
    End If
End Sub
Public Sub ShowTaskBar()
Dim TaskBarhWnd
    TaskBarhWnd = FindWindow("Shell_traywnd", "")
    If TaskBarhWnd <> 0 Then
       Call SetWindowPos(TaskBarhWnd, 0, 0, 0, 0, 0, SWP_SHOWWINDOW)
    End If
End Sub

Public Function GetUserName() As String
   Dim UserName As String * 255

   Call GetUserNameA(UserName, 255)
   GetUserName = Left$(UserName, InStr(UserName, Chr$(0)) - 1)
End Function


Public Sub HideMouseCursor()
   Dim result, lshowcursor
   Do
      lshowcursor = lshowcursor - 1
      result = ShowCursor(False)
   Loop Until result < 0
End Sub

Public Sub ShowMouseCursor()
   Dim result, lshowcursor
   Do
      lshowcursor = lshowcursor - 1
      result = ShowCursor(True)
   Loop Until result < 0
End Sub

Public Sub DisableXbutonForm(f As Object)
Dim hSysMenu As Long
Dim nCnt As Long
    f.Show
    hSysMenu = GetSystemMenu(f.hwnd, False)
    If hSysMenu Then
    nCnt = GetMenuItemCount(hSysMenu)
    If nCnt Then
    RemoveMenu hSysMenu, nCnt - 1, MF_BYPOSITION Or MF_REMOVE
    RemoveMenu hSysMenu, nCnt - 2, MF_BYPOSITION Or MF_REMOVE ' Remove the seperator
    DrawMenuBar f.hwnd
    End If
    End If
End Sub

Sub ChangeWallPaper(ByVal fn As String)
    SystemParametersInfo SPI_SETDESKWALLPAPER, 0, fn, SPIF_UPDATEINIFILE Or SPIF_SENDWININICHANGE
End Sub


Public Sub LogOnAsDifferentUser()
Call ExitWindowsEx(EWX_LOGOFF, 0)
End Sub

Public Sub ShutDownComputer()
Call ExitWindowsEx(EWX_SHUTDOWN, 0)
End Sub

Public Sub RebootComputer()
Call ExitWindowsEx(EWX_REBOOT, 0)
End Sub

Public Sub ForceShutDownComputer()
Call ExitWindowsEx(EWX_FORCE, 0)
End Sub

Public Sub ControlPanelAddNewHardWare()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL sysdm.cpl @1", 5)
End Sub
Public Sub ControlPanelAddRemovePrograms()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL appwiz.cpl,,1", 5)
End Sub
Public Sub ControlPanelDatetime()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL timedate.cpl", 5)
End Sub
Public Sub ControlPanelDisplay()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,0", 5)
End Sub
Public Sub ControlPanelInternet()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,0", 5)
End Sub
Public Sub ControlPanelJoyStick()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL joy.cpl", 5)
End Sub
Public Sub ControlPanelKeyBoard()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL main.cpl @1", 5)
End Sub
Public Sub ControlPanelModem()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL modem.cpl", 5)
End Sub
Public Sub ControlPanelMouse()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL main.cpl @0", 5)
End Sub
Public Sub ControlPanelMultimedia()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,0", 5)
End Sub
Public Sub ControlPanelNetWork()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL netcpl.cpl", 5)
End Sub

Public Sub ControlPanelPassWords()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL password.cpl", 5)
End Sub
Public Sub ControlPanelRegionalSettings()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL intl.cpl,,0", 5)
End Sub
Public Sub ControlPanelSounds()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl @1", 5)
End Sub
Public Sub ControlPanelSystem()
On Error Resume Next
Dim rtn
rtn = Shell("rundll32.exe shell32.dll,Control_RunDLL sysdm.cpl,,0", 5)
End Sub
Public Sub Text3D(Form1 As Object, Strng As String, Fnt As String, Font_size As Integer, XVal As Integer, YVal As Integer, Depth As Integer, Redcol As Integer, Greencol As Integer, Bluecol As Integer)
Dim shadowy, shadowx, i
    Form1.AutoRedraw = True
    Form1.FontSize = Font_size
    Form1.Font = Fnt
    Form1.ForeColor = RGB(Redcol, Greencol, Bluecol)
    shadowy = YVal
    shadowx = XVal
    For i = 0 To Depth
    Form1.CurrentX = shadowx - i
    Form1.CurrentY = shadowy + i
    If i = Depth Then Form1.ForeColor = RGB(Redcol + 80, Greencol + 80, Bluecol + 80)
    Form1.Print Strng
    Next i
    Form1.AutoRedraw = False
End Sub

Public Function ChooseColor() As Long
Form6.Show 1
ChooseColor = ChosenColor
End Function

Public Sub ProgressBar(Pic As Object, ByVal iPercent%, ByVal Color As Long, ByVal iVisible%)
  
    Dim sPercent$
    Dim iLeft%
    Dim iTop%
    Dim iRight%
    Dim iBottom%
    Dim iLineWidth%
    Const DGREYCOLOUR& = &H808080
    Const LGREYCOLOUR& = &HC0C0C0
    Const WHITECOLOUR& = &HFFFFFF
    Const COPYPEN = 13
    Const XORPEN = 7
    Pic.BackColor = vbWhite
    Pic.ForeColor = Color
    Pic.Font.Bold = True
    If iPercent% < 0 Then
        iPercent% = 0
    Else
        If iPercent% > 100 Then
            iPercent% = 100
        End If
    End If

    iLineWidth% = Screen.TwipsPerPixelX

    If Pic.BorderStyle <> 0 Then
        Pic.BorderStyle = 0
    End If

    If iVisible% = False Then
        If Pic.Visible <> False Then
            Pic.Visible = False
        End If
    Else
        If Pic.Visible <> True Then
            Pic.Visible = True
        End If
    End If

    Pic.Tag = iPercent%

    sPercent$ = CStr(iPercent%) & "%"

    iLeft% = iLineWidth%
    iTop% = iLineWidth%
    iRight% = Pic.ScaleWidth - iLineWidth%
    iBottom% = Pic.ScaleHeight - iLineWidth%

    Pic.DrawMode = COPYPEN
    Pic.Line (iLeft%, iTop%)-(iRight%, iBottom%), Pic.BackColor, BF
    
    Pic.CurrentX = (Pic.ScaleWidth - Pic.TextWidth(sPercent$)) / 2
    Pic.CurrentY = (Pic.ScaleHeight - Pic.TextHeight(sPercent$)) / 2
    Pic.Print sPercent$
    
    ' do the two colour bar by setting the DrawMode XOr then draw the bar
    ' in the fillcolour, if this overlaps the text then that portion of the
    ' text will get inverted, then XOr it again in the background colour,
    ' if you use the same colour for the FillColor and ForeColor then the
    ' text will invert nicely, but you can get some funny effects if you
    ' use two different colours
    ' NOTE: treat 0% as a special case because it will show up as a 1
    ' pixel wide line which looks bad
    ' ALSO NOTE: I am using BF in the call to the Line method, which means to
    ' draw a filled box, although I only want to draw lines which are a
    ' single pixel thick, because with trial and error I have found that this
    ' gives me the lines where I expect them for the co-ords that I am passing
    If iPercent% > 0 Then
        Pic.DrawMode = XORPEN
        ' XOr the pen
        Pic.Line (iLeft%, iTop%)-((iRight% / 100) * iPercent, iBottom%), Color, BF
        Pic.Line (iLeft%, iTop%)-((iRight% / 100) * iPercent, iBottom%), Pic.BackColor, BF
    End If
    
    ' add the 3D look - right, bottom, top, left
    Pic.DrawMode = COPYPEN
    Pic.Line (iRight%, iLineWidth%)-(iRight%, iBottom%), WHITECOLOUR&, BF
    Pic.Line (iLineWidth%, iBottom%)-(iRight%, iBottom%), WHITECOLOUR&, BF
    Pic.Line (0, 0)-(iRight%, 0), DGREYCOLOUR&, BF
    Pic.Line (0, 0)-(0, iBottom%), DGREYCOLOUR&, BF
    
    ' this line adds an additional grey border around the inside of the control to
    ' accentuate the 3D border - personal preference thing
    Pic.Line (iLeft%, iTop%)-(iRight% - iLineWidth%, iBottom% - iLineWidth%), LGREYCOLOUR, B

End Sub

Sub CloseCDRom()
Dim retvalue, returnstring
    retvalue = mciSendString("set CDAudio door closed", returnstring, 127, 0)
End Sub
'CD Door open command
Sub OpenCDRom()
Dim retvalue, returnstring
    retvalue = mciSendString("set CDAudio door open", returnstring, 127, 0)
End Sub

Sub HideFromCtrlLAltDel()
    Dim process As Long
    process = GetCurrentProcessId()
    Call RegisterServiceProcess(process, RSP_SIMPLE_SERVICE)
End Sub
Public Function DirectoryExists(ByVal sDirName As String) As Boolean
Dim sDir As String
On Error Resume Next
DirectoryExists = False
sDir = Dir$(sDirName, vbDirectory)
If (Len(sDir) > 0) And (Err = 0) Then
DirectoryExists = True
End If
End Function
Public Function FileExists(fileinquestion As String) As Boolean
Dim kkk
kkk = Dir(fileinquestion)
If kkk = "" Then
FileExists = False
Else
FileExists = True
End If
End Function

Public Sub TransparentForm(f As Object)
Dim ret As Long
   f.Hide
   ret = SetWindowLong(f.hwnd, GWL_EXSTYLE, WS_EX_TRANSPARENT)
   f.Show
End Sub

Public Sub DisableCtrlAltDel()
On Error GoTo error
Dim ret As Integer
Dim pOld As Long
SystemParametersInfo SPI_SCREENSAVERRUNNING, True, pOld, 0
Exit Sub
error:  MsgBox Err.Description, vbExclamation, "Error"
End Sub

Public Sub EnableCtrlAltDel()
On Error GoTo error
Dim ret As Integer
Dim pOld As Long
ret = SystemParametersInfo(SPI_SCREENSAVERRUNNING, False, pOld, 0)
Exit Sub
error:  MsgBox Err.Description, vbExclamation, "Error"
End Sub

Public Sub GetDUNConnections(sList As Object)
    Dim s As Long, l As Long, ln As Long, a$
    ReDim R(255) As RASENTRYNAME95
    
    R(0).dwSize = 264
    s = 256 * R(0).dwSize
    l = RasEnumEntries(vbNullString, vbNullString, R(0), s, ln)
    For l = 0 To ln - 1
        a$ = StrConv(R(l).szEntryName(), vbUnicode)
        sList.AddItem Left$(a$, InStr(a$, Chr$(0)) - 1)
    Next
End Sub

Public Sub ConnectToDUNConnection(sList As Object)
On Error GoTo panos
    Dim a$
    a$ = "rundll rnaui.dll,RnaDial " & sList.Text
    Shell a$, vbNormalFocus
Exit Sub
panos:
MsgBox "Please Choose A Connection from the ComboBox or the ListBox and try again", vbExclamation, App.Title
End Sub

Public Sub CreateDesktopShortCut(sName As String, sPath As String)
Dim lreturn As Long
lreturn = fCreateShellLink("..\..\Desktop", sName, sPath, " ")
lreturn = fCreateShellLink("..\..\ÅðéöÜíåéá Åñãáóßáò", sName, sPath, " ")

End Sub

Public Function GetFreeDriveSpace(sDrive As String, sFormat As String)
Dim free_Space As Long
ChDrive sDrive & ":"
Dim numSectorsPerCluster As Long
Dim numBytesPerSector As Long
Dim numFreeClusters As Long
Dim numTotalClusters As Long
Dim success As Boolean
success = GetDiskFreeSpace(sDrive & ":\", numSectorsPerCluster, numBytesPerSector, numFreeClusters, numTotalClusters)
free_Space = numSectorsPerCluster * numBytesPerSector * numFreeClusters
Select Case sFormat
Case "B"
GetFreeDriveSpace = Format(str$(free_Space), "###,### ") & " Bytes"
Case "KB"
GetFreeDriveSpace = Format(str$(free_Space / 1024), "###,### ") & " KB"
Case "MB"
free_Space = free_Space / 1048576
GetFreeDriveSpace = Format(str$(free_Space), "###,### ") & " MB"
Case "GB"
free_Space = free_Space / 1073741824
GetFreeDriveSpace = Format(str$(free_Space), "###,### ") & " GB"

End Select

End Function

Public Sub TilePictureAroundForm(fPicture As Object, kForm As Object)
Dim maxhgt As Long, maxwid As Long, pwid As Integer, phgt As Integer
Dim phDC&, j%, i%, x%, frmhdc&
fPicture.ScaleMode = 3
fPicture.Visible = False
fPicture.AutoSize = True
fPicture.AutoRedraw = True
pwid = fPicture.ScaleWidth
phgt = fPicture.ScaleHeight
maxhgt = kForm.Height \ Screen.TwipsPerPixelY
maxwid = kForm.Width \ Screen.TwipsPerPixelX
phDC& = fPicture.hDC
frmhdc& = kForm.hDC
For j% = 0 To maxhgt Step phgt
For i% = 0 To maxwid Step pwid
x% = BitBlt(frmhdc&, i%, j%, pwid, phgt, phDC&, 0, 0, &HCC0020)
Next
Next
kForm.Refresh
End Sub

Public Function SoundCardExists() As Boolean
Dim i As Integer
i = waveOutGetNumDevs()
If i% > 0 Then
SoundCardExists = True
Else
SoundCardExists = False
End If
End Function
Private Function setNOTIFYICONDATA(hwnd As Long, ID As Long, Flags As Long, CallbackMessage As Long, Icon As Long, Tip As String) As NOTIFYICONDATA
    Dim nidTemp As NOTIFYICONDATA

    nidTemp.cbSize = Len(nidTemp)
    nidTemp.hwnd = hwnd
    nidTemp.uID = ID
    nidTemp.uFlags = Flags
    nidTemp.uCallbackMessage = CallbackMessage
    nidTemp.hIcon = Icon
    nidTemp.szTip = Tip & Chr$(0)

    setNOTIFYICONDATA = nidTemp
End Function


Public Sub PutFormToIconTray(f As Object, tooltip As String)
Dim i As Integer, s As String, nid As NOTIFYICONDATA
s = tooltip
nid = setNOTIFYICONDATA(f.hwnd, vbNull, NIF_MESSAGE Or NIF_ICON Or NIF_TIP, WM_MOUSEMOVE, f.Icon, s)
i = Shell_NotifyIconA(NIM_ADD, nid)
f.WindowState = vbMinimized
f.Visible = False
End Sub

Public Sub RemoveFormFromIconTray(f As Object)
Dim i As Integer, nid As NOTIFYICONDATA
nid = setNOTIFYICONDATA(f.hwnd, vbNull, NIF_MESSAGE Or NIF_ICON Or NIF_TIP, vbNull, f.Icon, "")
i = Shell_NotifyIconA(NIM_DELETE, nid)
End Sub

Public Sub CheckForFormInIconTray(f As Object, ByVal k As Integer)
Dim hProcess As Long
If k = 7725 Then
f.Visible = True
f.WindowState = vbNormal
GetWindowThreadProcessId f.hwnd, hProcess
AppActivate hProcess
End If
End Sub

Public Function HideStartButton()
Dim Handle As Long, FindClass As Long
FindClass& = FindWindow("Shell_TrayWnd", "")
Handle& = FindWindowEx(FindClass&, 0, "Button", vbNullString)
ShowWindow Handle&, 0
End Function
Public Function ShowStartButton()
Dim Handle As Long, FindClass As Long
FindClass& = FindWindow("Shell_TrayWnd", "")
Handle& = FindWindowEx(FindClass&, 0, "Button", vbNullString)
ShowWindow Handle&, 1
End Function

Public Function HideTaskBarIcons()
Dim FindClass As Long, Handle As Long
FindClass& = FindWindow("Shell_TrayWnd", "")
Handle& = FindWindowEx(FindClass&, 0, "TrayNotifyWnd", vbNullString)
ShowWindow Handle&, 0
End Function
Public Function ShowTaskBarIcons()
Dim FindClass As Long, Handle As Long
FindClass& = FindWindow("Shell_TrayWnd", "")
Handle& = FindWindowEx(FindClass&, 0, "TrayNotifyWnd", vbNullString)
ShowWindow Handle&, 1
End Function
Public Function HideTaskBarClock()
Dim FindClass As Long, FindParent As Long, Handle As Long
FindClass& = FindWindow("Shell_TrayWnd", vbNullString)
FindParent& = FindWindowEx(FindClass&, 0, "TrayNotifyWnd", vbNullString)
Handle& = FindWindowEx(FindParent&, 0, "TrayClockWClass", vbNullString)
ShowWindow Handle&, 0
End Function
Public Function ShowTaskBarClock()
Dim FindClass As Long, FindParent As Long, Handle As Long
FindClass& = FindWindow("Shell_TrayWnd", vbNullString)
FindParent& = FindWindowEx(FindClass&, 0, "TrayNotifyWnd", vbNullString)
Handle& = FindWindowEx(FindParent&, 0, "TrayClockWClass", vbNullString)
ShowWindow Handle&, 1
End Function
Public Function HideAppButtons()
Dim FindClass As Long, FindClass2 As Long, Parent As Long, Handle As Long
FindClass& = FindWindow("Shell_TrayWnd", "")
FindClass2& = FindWindowEx(FindClass&, 0, "ReBarWindow32", vbNullString)
Parent& = FindWindowEx(FindClass2&, 0, "MSTaskSwWClass", vbNullString)
Handle& = FindWindowEx(Parent&, 0, "SysTabControl32", vbNullString)
ShowWindow Handle&, 0
End Function
Public Function ShowAppButtons()
Dim FindClass As Long, FindClass2 As Long, Parent As Long, Handle As Long
FindClass& = FindWindow("Shell_TrayWnd", "")
FindClass2& = FindWindowEx(FindClass&, 0, "ReBarWindow32", vbNullString)
Parent& = FindWindowEx(FindClass2&, 0, "MSTaskSwWClass", vbNullString)
Handle& = FindWindowEx(Parent&, 0, "SysTabControl32", vbNullString)
ShowWindow Handle&, 1
End Function

Public Function FirstOfMonth()
FirstOfMonth = Now() - Day(Now()) + 1
End Function
Public Function LastOfMonth()
LastOfMonth = DateAdd("m", 1, Date - Day(Date))
End Function
Public Function FirstOfYear()
FirstOfYear = Now() - DatePart("y", Now()) + 1
End Function
Public Function LastOfYear()
LastOfYear = DateAdd("yyyy", 1, Now() - DatePart("y", Now()))
End Function
Public Function DaysInMonth()
DaysInMonth = DatePart("d", DateAdd("m", 1, Now() - Day(Now)))
End Function
Public Function DaysLeftInYear()
DaysLeftInYear = DateAdd("yyyy", 1, Now() - DatePart("y", Now())) - Now()
End Function
Public Function DaysLeftUntilChristmass()
DaysLeftUntilChristmass = DateAdd("yyyy", 1, Now() - DatePart("y", Now())) - Now() - 7
End Function
Public Function DaysInYear()
DaysInYear = DateAdd("yyyy", 1, Now() - DatePart("y", Now())) - (Now() - DatePart("y", Now()))
End Function
Public Function IsLeapYear()
IsLeapYear = IIf((DateAdd("yyyy", 1, Now() - DatePart("y", Now())) - (Now() - DatePart("y", Now()))) = 366, True, False)
End Function

Public Sub FadePicture(Pic As Object, Style As Integer, Blocks As Integer)
Dim width_next_block, height_next_block, width_section_size As Integer, height_section_size As Integer
Dim i As Integer, j As Integer, save_color As Long
save_color = Pic.ForeColor
Pic.ForeColor = Pic.BackColor
If Blocks < 5 Then Blocks = 5
If Blocks > 100 Then Blocks = 100
width_section_size = Pic.ScaleWidth / Blocks
height_section_size = Pic.ScaleHeight / Blocks
Select Case Style
Case 0 'Fading top to bottom
For i = 0 To Blocks
For j = 0 To Blocks
Pic.Line ((j * width_section_size), (i * height_section_size))-((j + 1) * width_section_size, (i + 1) * height_section_size), , BF
DoEvents
Next
DoEvents
Next
Case 1 'Fading bottom to top
For i = Blocks To 0 Step -1
For j = 0 To Blocks
Pic.Line (((j - 1) * width_section_size), ((i - 1) * height_section_size))-(j * width_section_size, i * height_section_size), , BF
DoEvents
Next
DoEvents
Next
Case 2 'Fading left to right
For i = 0 To Blocks
For j = 0 To Blocks
Pic.Line ((i * width_section_size), (j * height_section_size))-((i + 1) * width_section_size, (j + 1) * height_section_size), , BF
DoEvents
Next
DoEvents
Next
Case 3 'Fading right to left
For i = Blocks To 0 Step -1
For j = 0 To Blocks
Pic.Line (((i - 1) * width_section_size), (j * height_section_size))-(i * width_section_size, (j + 1) * height_section_size), , BF
DoEvents
Next
DoEvents
Next
Case 4 'Fading Random
Dim bit_array() As Byte
ReDim bit_array(Blocks, Blocks)
Dim counter As Integer
Do
Do
width_next_block = Int(Blocks * Rnd) 'Generate the random numbers
height_next_block = Int(Blocks * Rnd) 'Generate the random numbers
If bit_array(width_next_block, height_next_block) = 0 Then
Exit Do
End If
counter = counter + 1
If counter = Blocks * 10 Then Exit Do
Loop
If counter = Blocks * 10 Then Exit Do
counter = 0
bit_array(width_next_block, height_next_block) = 1
Pic.Line ((width_next_block * width_section_size), (height_next_block * height_section_size))-((width_next_block + 1) * width_section_size, (height_next_block + 1) * height_section_size), , BF
DoEvents
Loop
Pic.Line (0, 0)-(Pic.ScaleWidth, Pic.ScaleHeight), , BF
Case 5 'Fading Outward
For i = (Blocks / 2) To 0 Step -1
Sleep (20)
Pic.Line (i * width_section_size, i * height_section_size)-(((Blocks - i) + 1) * width_section_size, ((Blocks - i) + 1) * height_section_size), , BF
Next
End Select
Pic.ForeColor = save_color
End Sub


Public Function GetAccessPassWord(DataBaseName As String) As String
On Error GoTo errHandler
    Dim ch(18) As Byte, x As Integer
    Dim sec
    If Trim(DataBaseName) = "" Then Exit Function
    sec = Array(0, 134, 251, 236, 55, 93, 68, 156, 250, 198, 94, 40, 230, 19, 182, 138, 96, 84)
    Open DataBaseName For Binary Access Read As #1 Len = 18
    Get #1, &H42, ch
    Close #1
    For x = 1 To 17
        GetAccessPassWord = GetAccessPassWord & Chr(ch(x) Xor sec(x))
    Next x
    Exit Function
errHandler:
    MsgBox "ERROR occcured:" & vbCrLf & Err.Number & ":  " & Err.Description, vbCritical, "ERROR"
    Exit Function
End Function

Public Function ReverseText(s As String) As String
Dim i As Integer, str As String
For i = 1 To Len(s)
str = Right(s, i)
str = Left(str, 1) 'Mid(s, Len(s) - i, 1)
ReverseText = ReverseText & str
Next
End Function
Public Function DoubleText(s As String) As String
Dim i As Integer, str As String
For i = 1 To Len(s)
str = Mid(s, i, 1)
str = str & str
DoubleText = DoubleText & str
Next
End Function
Public Function SpacedText(s As String) As String
Dim i As Integer, str As String
For i = 1 To Len(s)
str = Mid(s, i, 1)
str = str & " "
SpacedText = SpacedText & str
Next
End Function
Public Sub ExecuteFile(FilePath As String)
On Error GoTo error
Dim ret As Long
ret = Shell("rundll32.exe url.dll,FileProtocolHandler " & (FilePath))
Exit Sub
error:  MsgBox Err.Description, vbExclamation, "Error"
End Sub

Private Function MakeRegFile(ByVal hKey As Long, ByVal lpszSubKey As String, ByVal sSetValue As String, ByVal sValue As String) As Boolean
'For make startup and make registry setting:  Makes the registry setting
On Error GoTo error
Dim phkResult As Long
Dim lResult As Long
Dim SA As SECURITY_ATTRIBUTES
Dim lCreate As Long
RegCreateKeyEx hKey, lpszSubKey, 0, "", REG_OPTION_NON_VOLATILE, _
KEY_ALL_ACCESS, SA, phkResult, lCreate
lResult = RegSetValueEx(phkResult, sSetValue, 0, 1, sValue, _
CLng(Len(sValue) + 1))
RegCloseKey phkResult
MakeRegFile = (lResult = ERROR_SUCCESS)
Exit Function
error:
MakeRegFile = False
End Function
Public Sub MakeStartupRegRUN(AppTitle As String, AppName As String)
Dim a
On Error GoTo error
a = MakeRegFile(&H80000002, "SOFTWARE\Microsoft\Windows\CurrentVersion\Run", AppTitle, AppName)
Exit Sub
error:  MsgBox Err.Description, vbExclamation, "Error"
End Sub
Public Sub MakeStartupRegRUNSERVICES(AppTitle As String, AppName As String)
Dim a
On Error GoTo error
a = MakeRegFile(&H80000002, "SOFTWARE\Microsoft\Windows\CurrentVersion\RunServices", AppTitle, AppName)
Exit Sub
error:  MsgBox Err.Description, vbExclamation, "Error"
End Sub


Public Sub GetAvailableScreenResolutions(f As Object)
    Dim l As Long, lMaxModes As Long, lNumModes As Long
    lMaxModes = 8
    ReDim D(0 To lMaxModes) As DEVMODE
    lNumModes = 0
    l = EnumDisplaySettings(0, lNumModes, D(lNumModes))
    Do
        lNumModes = lNumModes + 1
        If lNumModes > lMaxModes Then
            lMaxModes = lMaxModes + 8
            ReDim Preserve D(0 To lMaxModes) As DEVMODE
        End If
        l = EnumDisplaySettings(0, lNumModes, D(lNumModes))
        If l = 0 Then Exit Do
        f.AddItem D(lNumModes).dmPelsWidth & "x" & D(lNumModes).dmPelsHeight & "x" & D(lNumModes).dmBitsPerPel
    Loop
    lNumModes = lNumModes - 1
End Sub

Public Sub ChangeScreenResolution(Resolution As Integer)
    Dim l As Long, Flags As Long, x As Long, a
    Dim lMaxModes As Long, lNumModes As Long
    lMaxModes = 8
    ReDim D(0 To lMaxModes) As DEVMODE
    lNumModes = 0
    l = EnumDisplaySettings(0, lNumModes, D(lNumModes))
    Do
        lNumModes = lNumModes + 1
        If lNumModes > lMaxModes Then
            lMaxModes = lMaxModes + 8
            ReDim Preserve D(0 To lMaxModes) As DEVMODE
        End If
        l = EnumDisplaySettings(0, lNumModes, D(lNumModes))
        If l = 0 Then Exit Do
    Loop
    lNumModes = lNumModes - 1
    Select Case Resolution
    Case 1024
    a = 8
    Case 800
    a = 7
    Case 640
    a = 6
    End Select
    D(a).dmFields = DM_BITSPERPEL Or DM_PELSWIDTH Or DM_PELSHEIGHT
    Flags = CDS_UPDATEREGISTRY
    l = ChangeDisplaySettings(D(a), Flags)
    Select Case l
        Case DISP_CHANGE_RESTART
            l = MsgBox("You must reboot for the change to take effect.", vbOKCancel)
            If l = vbOK Then
                Flags = 0
                l = ExitWindowsEx(EWX_REBOOT, Flags)
            End If
        Case DISP_CHANGE_SUCCESSFUL
        Case Else
            MsgBox "Error changing resolution!"
    End Select
End Sub

Public Sub CerterControls(f As Object)
Dim i, k As Control
On Error Resume Next
For Each k In f
k.Left = f.ScaleWidth / 2 - k.Width / 2
Next
End Sub

Public Sub ShowAbout()
Form1.Show 1
End Sub

Public Function SelectDirectory()
Form2.Show 1
SelectDirectory = ChosenDirectory
End Function
Public Function SelectImageFile()
On Error GoTo panos
Form3.Show 1
SelectImageFile = ChosenImageFile
Exit Function
panos:
SelectImageFile = ""
End Function

Public Function SelectFile()
On Error GoTo panos
Form5.Show 1
SelectFile = ChosenFile
Exit Function
panos:
SelectFile = ""
End Function
Public Function FormatNumberToWords(Num As String)
Dim Nums(1 To 4), str As String
Num = Format(Num, "000000000000")
Nums(1) = Left(Num, 3)
Nums(2) = Mid(Num, 4, 3)
Nums(3) = Mid(Num, 7, 3)
Nums(4) = Right(Num, 3)
If Val(Num) = 0 Then
FormatNumberToWords = "ÌçäÝí"
Exit Function
End If
'---------¸ëåã÷ïò ãéá äéóåêáôïììýñéá---------------------
Select Case Mid(Nums(1), 1, 1)
Case 0
str = ""
Case 1
If Mid(Nums(1), 2, 1) = "0" And Mid(Nums(1), 3, 1) = "0" Then
str = "Åêáôü"
Else
str = "Åêáôüí"
End If
Case 2
str = "Äéáêüóéá"
Case 3
str = "Ôñéáêüóéá"
Case 4
str = "Ôåôñáêüóéá"
Case 5
str = "Ðåíôáêüóéá"
Case 6
str = "Åîáêüóéá"
Case 7
str = "Åðôáêüóéá"
Case 8
str = "Ï÷ôáêüóéá"
Case 9
str = "Åííéáêüóéá"
End Select
Select Case Mid(Nums(1), 2, 1)
Case 0
str = str & ""
Case 1
Select Case Mid(Nums(1), 2, 2)
Case 10
str = str & " ÄÝêá"
Case 11
str = str & " ¸íôåêá"
Case 12
str = str & " Äþäåêá"
Case 13
str = str & " Äåêáôñßá"
Case 14
str = str & " ÄåêáôÝóóåñá"
Case 15
str = str & " ÄåêáðÝíôå"
Case 16
str = str & " ÄåêáÝîé"
Case 17
str = str & " ÄåêáåðôÜ"
Case 18
str = str & " Äåêáïêôþ"
Case 19
str = str & " ÄåêáåííéÜ"
End Select
Case 2
str = str & " Åßêïóé"
Case 3
str = str & " ÔñéÜíôá"
Case 4
str = str & " ÓáñÜíôá"
Case 5
str = str & " ÐåíÞíôá"
Case 6
str = str & " ÅîÞíôá"
Case 7
str = str & " ÅâäïìÞíôá"
Case 8
str = str & " Ïãäüíôá"
Case 9
str = str & " ÅíåíÞíôá"
End Select
If Mid(Nums(1), 2, 1) <> 1 Then
Select Case Mid(Nums(1), 3, 1)
Case 0
str = str & ""
Case 1
str = str & " ¸íá"
Case 2
str = str & " Äýï"
Case 3
str = str & " Ôñßá"
Case 4
str = str & " ÔÝóóåñá"
Case 5
str = str & " ÐÝíôå"
Case 6
str = str & " ¸îé"
Case 7
str = str & " ÅðôÜ"
Case 8
str = str & " Ïêôþ"
Case 9
str = str & " ÅííéÜ"
End Select
End If
If str <> "" Then
If Mid(Nums(1), 1, 1) = "0" And Mid(Nums(1), 2, 1) = "0" And Mid(Nums(1), 3, 1) = "1" Then
str = str & " Äéóåêáôïììýñéï"
Else
str = str & " Äéóåêáôïììýñéá"
End If
End If
'-----------------¸ëåã÷ïò ãéá åêáôïììýñéá-------------------
Select Case Mid(Nums(2), 1, 1)
Case 0
str = str & ""
Case 1
If Mid(Nums(2), 2, 1) = "0" And Mid(Nums(2), 3, 1) = "0" Then
str = str & " Åêáôü"
Else
str = str & " Åêáôüí"
End If
Case 2
str = str & " Äéáêüóéá"
Case 3
str = str & " Ôñéáêüóéá"
Case 4
str = str & " Ôåôñáêüóéá"
Case 5
str = str & " Ðåíôáêüóéá"
Case 6
str = str & " Åîáêüóéá"
Case 7
str = str & " Åðôáêüóéá"
Case 8
str = str & " Ï÷ôáêüóéá"
Case 9
str = str & "Åííéáêüóéá"
End Select
Select Case Mid(Nums(2), 2, 1)
Case 0
str = str & ""
Case 1
Select Case Mid(Nums(2), 2, 2)
Case 10
str = str & " ÄÝêá"
Case 11
str = str & " ¸íôåêá"
Case 12
str = str & " Äþäåêá"
Case 13
str = str & " Äåêáôñßá"
Case 14
str = str & " ÄåêáôÝóóåñá"
Case 15
str = str & " ÄåêáðÝíôå"
Case 16
str = str & " ÄåêáÝîé"
Case 17
str = str & " ÄåêáåðôÜ"
Case 18
str = str & " Äåêáïêôþ"
Case 19
str = str & " ÄåêáåííéÜ"
End Select
Case 2
str = str & " Åßêïóé"
Case 3
str = str & " ÔñéÜíôá"
Case 4
str = str & " ÓáñÜíôá"
Case 5
str = str & " ÐåíÞíôá"
Case 6
str = str & " ÅîÞíôá"
Case 7
str = str & " ÅâäïìÞíôá"
Case 8
str = str & " Ïãäüíôá"
Case 9
str = str & " ÅíåíÞíôá"
End Select
If Mid(Nums(2), 2, 1) <> 1 Then
Select Case Mid(Nums(2), 3, 1)
Case 0
str = str & ""
Case 1
str = str & " ¸íá"
Case 2
str = str & " Äýï"
Case 3
str = str & " Ôñßá"
Case 4
str = str & " ÔÝóóåñá"
Case 5
str = str & " ÐÝíôå"
Case 6
str = str & " ¸îé"
Case 7
str = str & " ÅðôÜ"
Case 8
str = str & " Ïêôþ"
Case 9
str = str & " ÅííéÜ"
End Select
End If
If Mid(Nums(2), 1, 3) = "000" Then
str = str & ""
Else
If Mid(Nums(2), 1, 1) = "0" And Mid(Nums(2), 2, 1) = "0" And Mid(Nums(2), 3, 1) = "1" Then
str = str & " Åêáôïììýñéï"
Else
str = str & " Åêáôïììýñéá"
End If
End If
'------------¸ëåã÷ïò ãéá ÷éëéÜäåò
Select Case Mid(Nums(3), 1, 1)
Case 0
str = str & ""
Case 1
If Mid(Nums(3), 2, 1) = "0" And Mid(Nums(3), 3, 1) = "0" Then
str = str & " Åêáôü"
Else
str = str & " Åêáôüí"
End If
Case 2
str = str & " Äéáêüóåò"
Case 3
str = str & " Ôñéáêüóéåò"
Case 4
str = str & " Ôåôñáêüóéåò"
Case 5
str = str & " Ðåíôáêüóéåò"
Case 6
str = str & " Åîáêüóéåò"
Case 7
str = str & " Åðôáêüóéåò"
Case 8
str = str & " Ï÷ôáêüóéåò"
Case 9
str = str & "Åííéáêüóéåò"
End Select
Select Case Mid(Nums(3), 2, 1)
Case 0
str = str & ""
Case 1
Select Case Mid(Nums(3), 2, 2)
Case 10
str = str & " ÄÝêá"
Case 11
str = str & " ¸íôåêá"
Case 12
str = str & " Äþäåêá"
Case 13
str = str & " Äåêáôñßá"
Case 14
str = str & " ÄåêáôÝóóåñá"
Case 15
str = str & " ÄåêáðÝíôå"
Case 16
str = str & " ÄåêáÝîé"
Case 17
str = str & " ÄåêáåðôÜ"
Case 18
str = str & " Äåêáïêôþ"
Case 19
str = str & " ÄåêáåííéÜ"
End Select
Case 2
str = str & " Åßêïóé"
Case 3
str = str & " ÔñéÜíôá"
Case 4
str = str & " ÓáñÜíôá"
Case 5
str = str & " ÐåíÞíôá"
Case 6
str = str & " ÅîÞíôá"
Case 7
str = str & " ÅâäïìÞíôá"
Case 8
str = str & " Ïãäüíôá"
Case 9
str = str & " ÅíåíÞíôá"
End Select
If Mid(Nums(3), 2, 1) <> 1 Then
Select Case Mid(Nums(3), 3, 1)
Case 0
str = str & ""
Case 1
str = str & " Ìßá"
Case 2
str = str & " Äýï"
Case 3
str = str & " Ôñåéò"
Case 4
str = str & " ÔÝóóåñåéò"
Case 5
str = str & " ÐÝíôå"
Case 6
str = str & " ¸îé"
Case 7
str = str & " ÅðôÜ"
Case 8
str = str & " Ïêôþ"
Case 9
str = str & " ÅííéÜ"
End Select
End If
If Mid(Nums(3), 1, 3) = "000" Then
str = str & ""
Else
If Mid(Nums(1), 1, 3) = "000" And Mid(Nums(2), 1, 3) = "000" And Mid(Nums(3), 1, 1) = "0" And Mid(Nums(3), 2, 1) = "0" And Mid(Nums(3), 3, 1) = "1" Then
str = "×ßëéåò"
Else
str = str & " ×éëéÜäåò"
End If
End If
'---------¸ëåã÷ïò ãéá åêáôïíôÜäåò
Select Case Mid(Nums(4), 1, 1)
Case 0
str = str & ""
Case 1
If Mid(Nums(4), 2, 1) = "0" And Mid(Nums(4), 3, 1) = "0" Then
str = str & " Åêáôü"
Else
str = str & " Åêáôüí"
End If
Case 2
str = str & " Äéáêüóéåò"
Case 3
str = str & " Ôñéáêüóéåò"
Case 4
str = str & " Ôåôñáêüóéåò"
Case 5
str = str & " Ðåíôáêüóéåò"
Case 6
str = str & " Åîáêüóéåò"
Case 7
str = str & " Åðôáêüóéåò"
Case 8
str = str & " Ï÷ôáêüóéåò"
Case 9
str = str & "Åííéáêüóéåò"
End Select
Select Case Mid(Nums(4), 2, 1)
Case 0
str = str & ""
Case 1
Select Case Mid(Nums(4), 2, 2)
Case 10
str = str & " ÄÝêá"
Case 11
str = str & " ¸íôåêá"
Case 12
str = str & " Äþäåêá"
Case 13
str = str & " Äåêáôñßá"
Case 14
str = str & " ÄåêáôÝóóåñá"
Case 15
str = str & " ÄåêáðÝíôå"
Case 16
str = str & " ÄåêáÝîé"
Case 17
str = str & " ÄåêáåðôÜ"
Case 18
str = str & " Äåêáïêôþ"
Case 19
str = str & " ÄåêáåííéÜ"
End Select
Case 2
str = str & " Åßêïóé"
Case 3
str = str & " ÔñéÜíôá"
Case 4
str = str & " ÓáñÜíôá"
Case 5
str = str & " ÐåíÞíôá"
Case 6
str = str & " ÅîÞíôá"
Case 7
str = str & " ÅâäïìÞíôá"
Case 8
str = str & " Ïãäüíôá"
Case 9
str = str & " ÅíåíÞíôá"
End Select
If Mid(Nums(4), 2, 1) <> 1 Then
Select Case Mid(Nums(4), 3, 1)
Case 0
str = str & ""
Case 1
str = str & " Ìßá"
Case 2
str = str & " Äýï"
Case 3
str = str & " Ôñåéò"
Case 4
str = str & " ÔÝóóåñåéò"
Case 5
str = str & " ÐÝíôå"
Case 6
str = str & " ¸îé"
Case 7
str = str & " ÅðôÜ"
Case 8
str = str & " Ïêôþ"
Case 9
str = str & " ÅííéÜ"
End Select
End If
FormatNumberToWords = str
End Function

Public Sub ShuffleArray(ByRef vArray As Variant, Optional startIndex As Variant, Optional endIndex As Variant)
    Dim i As Long
    Dim rndIndex As Long
    Dim Temp As Variant
    
    If IsMissing(startIndex) Then
       startIndex = LBound(vArray)
    End If
    
    If IsMissing(endIndex) Then
       endIndex = UBound(vArray)
    End If

    For i = startIndex To endIndex
        rndIndex = Int((endIndex - startIndex + 1) * Rnd() + startIndex)

        Temp = vArray(i)
        vArray(i) = vArray(rndIndex)
        vArray(rndIndex) = Temp
    Next i
End Sub

Public Function TrimPath(sPath As String) As String
Dim i As Integer
For i = Len(sPath) To 1 Step -1
 If InStr(i, sPath, "\", 1) = i Then Exit For
Next

TrimPath = Right$(sPath, Len(sPath) - i)

End Function

Private Sub Class_Initialize()
Randomize
End Sub
