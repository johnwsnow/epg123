; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "EPG123"
#define SourcePath "..\..\bin\Release"
#define MyAppExeName "epg123_gui.exe"
#define MyClientName "EPG123 Client"
#define MyClientExeName "epg123Client.exe"

#dim Version[4]
#expr ParseVersion(AddBackslash(SourcePath) + MyClientExeName, Version[0], Version[1], Version[2], Version[3])
#define MyAppVersion Str(Version[0]) + "." + Str(Version[1]) + "." + Str(Version[2]) + "." + Str(Version[3])

#define MyAppPublisher "GaRyan2"
#define MyAppURL "https://garyan2.github.io/"

#define MySetupBaseFilename "epg123Setup_v"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
#ifdef SIGN_INSTALLER
  SignTool=SSL.com /d "EPG123" /du "https://garyan2.github.io/" $f
  ;SignedUninstaller=no
#endif
AppId={{A592C107-8384-4DFF-902E-30F5133EA626}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
AppendDefaultDirName=no
CloseApplications=no
DefaultDirName={pf32}\epg123
DisableWelcomePage=no
LicenseFile=docs\license.rtf
AlwaysShowDirOnReadyPage=yes
OutputDir=..\..\bin\output\setup
OutputBaseFilename={#MySetupBaseFilename + MyAppVersion}
SetupIconFile=imgs\EPG123.ico
Compression=lzma
SolidCompression=yes
ShowComponentSizes=yes
UninstallDisplayName={#MyAppName} {#MyAppVersion}
UninstallDisplayIcon={uninstallexe}
WizardImageFile=imgs\EPG123_164x319.bmp
WizardSmallImageFile=imgs\EPG123_55x55.bmp
AllowRootDirectory=True
AppCopyright=2016
VersionInfoVersion={#MyAppVersion}
VersionInfoCompany={#MyAppPublisher}
VersionInfoDescription=Media Center Electronic Program Guide in 1-2-3
VersionInfoCopyright=2023
VersionInfoProductName={#MyAppName}
VersionInfoProductVersion={#MyAppVersion}
VersionInfoProductTextVersion={#MyAppVersion}
DisableProgramGroupPage=yes
AppMutex=Global\{{BAEC0A11-437B-4D39-A2FA-DB56F8C977E3},Global\{{CD7E6857-7D92-4A2F-B3AB-ED8CB42C6F65}

[Types]
Name: "full"; Description: "Full Install"; MinVersion: 6.1
Name: "server"; Description: "Server Only Install"
Name: "client"; Description: "Client Only Install"; MinVersion: 6.1
Name: "custom"; Description: "Custom Install"; Flags: IsCustom

[Components]
Name: "main1"; Description: "Server Files"; Types: full server; Flags: disablenouninstallwarning
Name: "main1\epg123"; Description: "EPG123 for Schedules Direct"; Types: full server; Flags: disablenouninstallwarning
Name: "main1\hdhr"; Description: "HDHR2MXF for SiliconDust DVR Service"; Types: full server; Flags: disablenouninstallwarning;
Name: "main2"; Description: "Client Files"; Types: full client; MinVersion: 6.1; Flags: disablenouninstallwarning; Check: FileExists(ExpandConstant('{win}\ehome\ehshell.exe'))
Name: "main2\tray"; Description: "Notification Tray Tool"; Types: full client; Flags: disablenouninstallwarning

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create desktop shortcut(s)"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "startmenu"; Description: "Create start menu icons"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "misc\ndp462-kb3151802-web.exe"; DestDir: "{tmp}"; Flags: dontcopy
Source: "{#SourcePath}\epg123.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: main1\epg123
Source: "{#SourcePath}\epg123.exe.config"; DestDir: "{app}"; Flags: ignoreversion; Attribs: hidden; Components: main1\epg123
Source: "{#SourcePath}\epg123_gui.exe"; DestDir: "{app}"; BeforeInstall: TaskKill('epg123_gui.exe'); Flags: ignoreversion; Components: main1\epg123 main2 and not main1
Source: "{#SourcePath}\epg123_gui.exe.config"; DestDir: "{app}"; Flags: ignoreversion; Attribs: hidden; Components: main1\epg123 main2 and not main1
Source: "{#SourcePath}\epg123Server.exe"; DestDir: "{app}"; BeforeInstall: TaskKill('epg123Server.exe'); Flags: ignoreversion; Components: main1\epg123 main1\hdhr
Source: "{#SourcePath}\hdhr2mxf.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: main1\hdhr
Source: "{#SourcePath}\Newtonsoft.Json.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: main1\epg123 main1\hdhr main2
Source: "{#SourcePath}\epg123Client.exe"; DestDir: "{app}"; BeforeInstall: TaskKill('epg123Client.exe'); Flags: ignoreversion; Components: main2
Source: "{#SourcePath}\epg123Client.exe.config"; DestDir: "{app}"; Flags: ignoreversion; Attribs: hidden; MinVersion: 6.1; OnlyBelowVersion: 6.2; Components: main2
Source: "{#SourcePath}\epg123Transfer.exe"; DestDir: "{app}"; BeforeInstall: TaskKill('epg123Transfer.exe'); Flags: ignoreversion; Components: main2
Source: "{#SourcePath}\epg123Transfer.exe.config"; DestDir: "{app}"; Flags: ignoreversion; Attribs: hidden; MinVersion: 6.1; OnlyBelowVersion: 6.2; Components: main2
Source: "{#SourcePath}\epgTray.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: main2\tray
Source: "{#SourcePath}\epgTray.exe.config"; DestDir: "{app}"; Flags: ignoreversion; Attribs: hidden; Components: main2\tray
Source: "{#SourcePath}\logViewer.exe"; DestDir: "{app}"; BeforeInstall: TaskKill('logViewer.exe'); Flags: ignoreversion;
Source: "{#SourcePath}\logViewer.exe.config"; DestDir: "{app}"; Flags: ignoreversion; Attribs: hidden;
Source: "{#SourcePath}\GaRyan2.Github.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: main1\epg123 main2
Source: "{#SourcePath}\GaRyan2.MxfXmltvTools.dll"; DestDir: "{app}"; Flags: ignoreversion;
Source: "{#SourcePath}\GaRyan2.SchedulesDirect.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: main1\epg123 main2
Source: "{#SourcePath}\GaRyan2.Tmdb.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: main1\epg123
Source: "{#SourcePath}\GaRyan2.Utilities.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourcePath}\GaRyan2.WmcUtilities.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: main1\hdhr main2
Source: "docs\license.rtf"; DestDir: "{app}"; Flags: ignoreversion
Source: "links\EPG123 Online.url"; DestDir: "{commonprograms}\{#MyAppName}"; Tasks: startmenu; Flags: ignoreversion

[Icons]
Name: "{commonprograms}\{#MyAppName}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: startmenu; Components: main1\epg123 main2 and not main1
Name: "{commonprograms}\{#MyAppName}\{#MyClientName}"; Filename: "{app}\{#MyClientExeName}"; Tasks: startmenu; Components: main2
Name: "{commonprograms}\{#MyAppName}\EPG123 Transfer Tool"; Filename: "{app}\epg123Transfer.exe"; Tasks: startmenu; Components: main2
Name: "{commonprograms}\{#MyAppName}\EPG123 Tray"; Filename: "{app}\epgTray.exe"; Tasks: startmenu; Components: main2\tray
Name: "{commonprograms}\{#MyAppName}\Log Viewer"; Filename: "{app}\logViewer.exe"; Tasks: startmenu;
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; Components: main1\epg123 main2 and not main1
Name: "{commondesktop}\{#MyClientName}"; Filename: "{app}\{#MyClientExeName}"; Tasks: desktopicon; Components: main2
Name: "{commonstartup}\EPG123 Tray"; Filename: "{app}\epgTray.exe"; Components: main2\tray

[Registry]
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Media Center\Service\Epg"; ValueType: dword; ValueName: "epg123LastUpdateStatus"; ValueData: "0"; Flags: deletevalue uninsdeletevalue noerror; Check: not IsWin64; Components: main2
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Media Center\Service\Epg"; ValueType: string; ValueName: "epg123LastUpdateTime"; ValueData: ""; Flags: deletevalue uninsdeletevalue noerror; Check: not IsWin64; Components: main2
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Media Center\Service\Epg"; ValueType: string; ValueName: "dbgc:next run time"; ValueData: "{olddata}"; Flags: uninsdeletevalue noerror; Check: not IsWin64; Components: main2
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Media Center\Start Menu"; ValueType: string; ValueName: "OEMLogoAccent"; ValueData: "Light"; Flags: createvalueifdoesntexist uninsdeletevalue noerror; Check: not IsWin64; Components: main2
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Media Center\Start Menu"; ValueType: dword; ValueName: "OEMLogoOpacity"; ValueData: "100"; Flags: createvalueifdoesntexist uninsdeletevalue noerror; Check: not IsWin64; Components: main2
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Media Center\Start Menu"; ValueType: string; ValueName: "OEMLogoUri"; ValueData: "{olddata}"; Flags: uninsclearvalue noerror; Check: not IsWin64; Components: main2

Root: HKLM64; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Media Center\Service\Epg"; ValueType: dword; ValueName: "epg123LastUpdateStatus"; ValueData: "0"; Flags: deletevalue uninsdeletevalue noerror; Check: IsWin64; Components: main2
Root: HKLM64; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Media Center\Service\Epg"; ValueType: string; ValueName: "epg123LastUpdateTime"; ValueData: ""; Flags: deletevalue uninsdeletevalue noerror; Check: IsWin64; Components: main2
Root: HKLM64; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Media Center\Service\Epg"; ValueType: string; ValueName: "dbgc:next run time"; ValueData: "{olddata}"; Flags: uninsdeletevalue noerror; Check: IsWin64; Components: main2
Root: HKLM64; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Media Center\Start Menu"; ValueType: string; ValueName: "OEMLogoAccent"; ValueData: "Light"; Flags: createvalueifdoesntexist uninsdeletevalue noerror; Check: IsWin64; Components: main2
Root: HKLM64; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Media Center\Start Menu"; ValueType: dword; ValueName: "OEMLogoOpacity"; ValueData: "100"; Flags: createvalueifdoesntexist uninsdeletevalue noerror; Check: IsWin64; Components: main2
Root: HKLM64; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Media Center\Start Menu"; ValueType: string; ValueName: "OEMLogoUri"; ValueData: "{olddata}"; Flags: uninsclearvalue noerror; Check: IsWin64; Components: main2

; clean up deprecated keys
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Services\EventLog\Media Center\EPG123"; Flags: deletekey noerror
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Services\EventLog\Media Center\EPG123Client"; Flags: deletekey noerror
Root: HKLM; Subkey: "SOFTWARE\GaRyan2\"; Flags: deletekey noerror; Check: not IsWin64
Root: HKLM; Subkey: "SOFTWARE\GaRyan2\epg123\"; Flags: deletekey noerror; Check: not IsWin64
Root: HKLM64; Subkey: "SOFTWARE\GaRyan2\"; Flags: deletekey noerror; Check: IsWin64
Root: HKLM64; Subkey: "SOFTWARE\GaRyan2\epg123\"; Flags: deletekey noerror; Check: IsWin64

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent runascurrentuser unchecked; Components: main1\epg123 main2 and not main1
Filename: "{app}\{#MyClientExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyClientName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent runascurrentuser unchecked; Components: main2
Filename: "{app}\epgTray.exe"; Flags: nowait runasoriginaluser; Components: main2\tray

Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""EPG123 Server"""; Flags: runhidden; StatusMsg: "Removing TCP firewall rule..."
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""EPG123 Client"""; Flags: runhidden; StatusMsg: "Removing UDP firewall rule..."
Filename: "{sys}\sc.exe"; Parameters: "stop epg123Server"; Flags: runhidden; StatusMsg: "Stopping EPG123 Server..."
Filename: "{sys}\sc.exe"; Parameters: "delete epg123Server" ; Flags: runhidden; StatusMsg: "Deleting server service..."

Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""EPG123 Server"" dir=in action=allow profile=private,domain protocol=tcp localport=9009"; Flags: runhidden; Components: main1\epg123 main1\hdhr; StatusMsg: "Adding TCP firewall rule..."
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""EPG123 Server"" dir=in action=allow profile=private,domain protocol=udp localport=9009"; Flags: runhidden; Components: main1\epg123 main1\hdhr main2; StatusMsg: "Adding UDP firewall rule..."
Filename: "{sys}\sc.exe"; Parameters: "create epg123Server start= delayed-auto binPath= ""{app}\epg123Server.exe"" displayname= ""EPG123 Server"""; Flags: runhidden; Components: main1\epg123 main1\hdhr; StatusMsg: "Creating server service..."
Filename: "{sys}\sc.exe"; Parameters: "description epg123Server ""Services image redirects adding token requirements and provides an endpoint to download output files."""; Flags: runhidden; Components: main1\epg123 main1\hdhr
Filename: "{sys}\sc.exe"; Parameters: "failure ""epg123Server"" reset= 86400 actions= restart/60000/restart/60000/restart/60000"; Flags: runhidden; Components: main1\epg123 main1\hdhr
Filename: "{sys}\sc.exe"; Parameters: "start epg123Server"; Flags: runhidden; Components: main1\epg123 main1\hdhr; StatusMsg: "Starting server service..."

[Dirs]
Name: {code:GetRootDataFolder}; Permissions: everyone-full

[InstallDelete]
Type: files; Name: "{app}\Newtonsoft.json.dll"; Components: not main1\epg123 main1\hdhr
Type: files; Name: "{app}\epg123.exe"; Components: not main1\epg123
Type: files; Name: "{app}\epg123.exe.config"; Components: not main1\epg123
Type: files; Name: "{app}\epg123_gui.exe"; Components: not main1\epg123 main2
Type: files; Name: "{app}\epg123_gui.exe.config"; Components: not main1\epg123 main2
Type: files; Name: "{app}\epg123Server.exe"; Components: not main1\epg123 main1\hdhr
Type: files; Name: "{app}\hdhr2mxf.exe"; Components: not main1\hdhr
Type: files; Name: "{app}\epg123Client.exe"; Components: not main2
Type: files; Name: "{app}\epg123Client.exe.config"; Components: not main2
Type: files; Name: "{app}\epg123Transfer.exe"; Components: not main2
Type: files; Name: "{app}\epg123Transfer.exe.config"; Components: not main2
Type: files; Name: "{app}\epgTray.exe"; BeforeInstall: TaskKill('epgTray.exe'); Components: not main2\tray
Type: files; Name: "{app}\epgTray.exe.config"; Components: not main2\tray
Type: files; Name: "{app}\logViewer.exe";
Type: files; Name: "{app}\logViewer.exe.config";
Type: files; Name: "{app}\GaRyan2.Github.dll"; Components: not main1\epg123
Type: files; Name: "{app}\GaRyan2.MxfXmltvTools.dll"; Components: not main1\epg123 main1\hdhr main2
Type: files; Name: "{app}\GaRyan2.SchedulesDirect.dll"; Components: not main1\epg123
Type: files; Name: "{app}\GaRyan2.Tmdb.dll"; Components: not main1\epg123
Type: files; Name: "{app}\GaRyan2.Utilities.dll";
Type: files; Name: "{app}\GaRyan2.WmcUtilities.dll"; Components: not main2 main1\hdhr
Type: filesandordirs; Name: "{commonprograms}\{#MyAppName}"
Type: files; Name: "{commondesktop}\{#MyAppName}.lnk"
Type: files; Name: "{commondesktop}\{#MyClientName}.lnk"
Type: files; Name: "{commonstartup}\EPG123 Tray.lnk"

; clean up deprecated files
Type: files; Name: "{app}\customLineup.xml.example";
; Type: files; Name: "{app}\plutotv.exe";
; Type: files; Name: "{app}\stirrtv.exe";

[UninstallRun]
Filename: "{sys}\taskkill.exe"; Parameters: "/im ""epgTray.exe"" /f"; Flags: runhidden; StatusMsg: "Killing EPG123 Tray Application..."
Filename: "{sys}\taskkill.exe"; Parameters: "/im ""epg123Client.exe"" /f"; Flags: runhidden; StatusMsg: "Killing EPG123 Client Application..."
Filename: "{sys}\sc.exe"; Parameters: "stop epg123Server"; Flags: runhidden; StatusMsg: "Stopping EPG123 Server..."
Filename: "{sys}\sc.exe"; Parameters: "delete epg123Server" ; Flags: runhidden; StatusMsg: "Deleting server service..."
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""EPG123 Server"""; Flags: runhidden; StatusMsg: "Removing firewall rules..."
Filename: "{sys}\schtasks.exe"; Parameters: "/delete /tn ""epg123_update"" /f"; Flags: runhidden; StatusMsg: "Deleting scheduled task..."

[Code]
// determine whether .NET Framework 4.6.2 is installed
function Framework4IsInstalled(): Boolean;
var
    success: boolean;
    install: cardinal;
begin
    success := RegQueryDWordValue(HKLM, 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full', 'Release', install);
    result := success and (install > 394801);
end;

// install .NET Framework
function PrepareToInstall(var NeedsRestart: Boolean): String;
var
    ResultCode: Integer;
begin
    // check if minimum framework is installed
    if not Framework4IsInstalled() then begin
        // prompt user to install if not suppressed
        if SuppressibleMsgBox('The minimum .NET Framework is not installed. Do you wish to install .NET Framework 4.6.2 Client software now?', mbConfirmation, MB_YESNO, IDNO) = IDYES then begin
            // extract web bootstrap and execute
            ExtractTemporaryFile('ndp462-kb3151802-web.exe');
            if not Exec(ExpandConstant('{tmp}\ndp462-kb3151802-web.exe'), '/passive /norestart', '', SW_SHOW, ewWaitUntilTerminated, ResultCode) then begin
                MsgBox('.NET installation failed with code: ' + IntToStr(ResultCode) + '.', mbError, MB_OK);
            end
            else begin
                Result := 'You need to restart your machine to complete .NET Framework 4.6.2.'
                NeedsRestart := True;
            end;
        end;
    end;
    Exec(ExpandConstant('{sys}\sc.exe'), 'stop epg123Server', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    Exec(ExpandConstant('{sys}\taskkill.exe'), '/f /im epg123Server.exe', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    Exec(ExpandConstant('{sys}\taskkill.exe'), '/f /im epgTray.exe', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    Exec(ExpandConstant('{sys}\taskkill.exe'), '/f /im epg123Client.exe', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
end;

// check where the installation folder is located
function GetRootDataFolder(Param: String) : String;
begin
    if Pos(ExpandConstant('{pf32}'), ExpandConstant('{app}')) > 0 then begin
        result := ExpandConstant('{commonappdata}\{#MyAppPublisher}\') + Lowercase(ExpandConstant('{#MyAppName}'))
    end
    else begin
        result := ExpandConstant('{app}')
    end;
end;

procedure CurUninstallStepChanged (CurUninstallStep: TUninstallStep);
var
    mres : Integer;
begin
    case CurUninstallStep of
        usPostUninstall:
            begin
                mres := MsgBox('Do you want to remove all traces of EPG123 install to include configuration, images, logos, and cache?', mbConfirmation, MB_YESNO or MB_DEFBUTTON2)
                if mres = IDYES then
                    DelTree(GetRootDataFolder('{app}'), True, True, True);
                end;
            end;
end;

// kill tray task
procedure TaskKill(FileName: String);
var
    ResultCode: Integer;
begin
    Exec(ExpandConstant('{sys}\taskkill.exe'), '/f /im ' + '"' + FileName + '"', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
end;