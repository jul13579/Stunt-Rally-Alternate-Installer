;  LEGO� Stunt Rally Alternate Installer V1.0
;  Created 2013 Triangle717
;  <http://Triangle717.WordPress.com/>
;  Contains source code from Grim Fandango Setup
;  Copyright (c) 2007-2008 Bgbennyboy
;  <http://quick.mixnmojo.com/>

; If any version below the specified version is used for compiling, this error will be shown.
#if VER < EncodeVer(5,5,2)
  #error You must use Inno Setup 5.5.2 or newer to compile this script
#endif

#define MyAppInstallerName "LEGO Racers Alternate Installer"
#define MyAppInstallerVersion "1.0"
#define MyAppName "LEGO® Stunt Rally"
#define MyAppNameNoR "LEGO Stunt Rally"
#define MyAppVersion "0.3.1.1"
#define MyAppPublisher "LEGO Media"
#define MyAppExeName "StuntRally.exe"
#define MySecondAppExeName "_msr.exe"

[Setup]                                               
AppID={#MyAppInstallerName}{#MyAppInstallerVersion}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
VersionInfoVersion={#MyAppInstallerVersion}
AppPublisher={#MyAppPublisher}
AppCopyright=© 1999 {#MyAppPublisher}
LicenseFile=license.txt
; Start menu/screen and Desktop shortcuts
DefaultDirName={pf}\LEGO Media\Games\{#MyAppNameNoR}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
; Installer Graphics
; SetupIconFile=Racers.ico
; WizardImageFile=Sidebar.bmp
WizardSmallImageFile=Small Image.bmp
WizardImageStretch=True
WizardImageBackColor=clBlack
; Location of the compiled Exe
OutputDir=Here Lie The EXE
OutputBaseFilename={#MyAppInstallerName} {#MyAppInstallerVersion}
; Uninstallation stuff
UninstallFilesDir={app}
; UninstallDisplayIcon={app}\Racers.ico
CreateUninstallRegKey=yes
UninstallDisplayName={#MyAppName}
; This is required so Inno can correctly report the installation size.
UninstallDisplaySize=112820029
; Compression
Compression=lzma2/ultra64
SolidCompression=True
InternalCompressLevel=ultra
LZMAUseSeparateProcess=yes
; From top to bottom: Allows installation to C:\ (and the like),
; Explicitly set Admin rights, no other languages, do not restart upon finishing.
AllowRootDirectory=yes
PrivilegesRequired=admin
ShowLanguageDialog=no
RestartIfNeededByRun=no

[Languages]
Name: "English"; MessagesFile: "compiler:Default.isl"

[Messages]
BeveledLabel={#MyAppInstallerName} {#MyAppInstallerVersion}
; WelcomeLabel2 is overridden because I'm unsure if every LEGO Racers disc says version 0.3.1.1 or just mine.
WelcomeLabel2=This will install [name] on your computer.%n%nIt is recommended that you close all other applications before continuing.
; DiskSpaceMBLabel is overridden because it reports an incorrect installation size.
DiskSpaceMBLabel=At least 107 MB of free disk space is required.

; Both Types and Components sections are required to create the installation options.
[Types]
Name: "Full"; Description: "Full Installation (With Movies)"  
Name: "Minimal"; Description: "Minimal Installation (Without Movies)"

[Components]
Name: "Full"; Description: "Full Installation (With Movies)"; Types: Full
Name: "Minimal"; Description: "Minimal Installation (Without Movies)"; Types: Minimal

[Files]
; Pull the game files off a standard LEGO Racers disc.
Source: "{code:GetSourceDrive}DATA1.CAB"; DestDir: "{app}"; Flags: external ignoreversion deleteafterinstall skipifsourcedoesntexist
Source: "{code:GetSourceDrive}DATA1.HDR"; DestDir: "{app}"; Flags: external ignoreversion deleteafterinstall skipifsourcedoesntexist
Source: "{code:GetSourceDrive}SETUPDIR\0009\Readme.txt"; DestDir: "{app}"; Flags: external ignoreversion skipifsourcedoesntexist

; Manual and icon
Source: "Manual.pdf"; DestDir: "{app}"; Flags: ignoreversion skipifsourcedoesntexist
Source: "Racers.ico"; DestDir: "{app}"; Flags: ignoreversion

; Tool needed to extract the CAB
Source: "Tools\CABExtract\i5comp.exe"; DestDir: "{app}"; Flags: deleteafterinstall
Source: "Tools\CABExtract\ZD51145.DLL"; DestDir: "{app}"; Flags: deleteafterinstall

; Original tools to delete LEGORacers.icd and the videos (the latter under certain conditions).
; Source: "Tools\DelFiles\VideoDel.exe"; DestDir: "{app}\Uninstall"; Flags: deleteafterinstall
; Source: "Tools\DelFiles\ICDDel.exe"; DestDir: "{app}\Uninstall"; Flags: uninsrestartdelete
; Source: "Tools\DelFiles\_bz2.pyd"; DestDir: "{app}\Uninstall"; Flags: uninsrestartdelete
; Source: "Tools\DelFiles\python33.dll"; DestDir: "{app}\Uninstall"; Flags: uninsrestartdelete
; Source: "Tools\DelFiles\unicodedata.pyd"; DestDir: "{app}\Uninstall"; Flags: uninsrestartdelete

[Icons]
; First and last icons are created only if user choose not to use the videos, else the normal ones are created.
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\Racers.ico"; IconIndex: 0; Comment: "Run LEGO Racers"; Components: Full
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\Racers.ico"; IconIndex: 0; Parameters: "-novideo"; Comment: "Run LEGO Racers without Intro videos"; Components: Minimal
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\Racers.ico"; IconIndex: 0
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\Racers.ico"; IconIndex: 0; Comment: "Run LEGO Racers"; Components: Full; Tasks: desktopicon
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\Racers.ico"; IconIndex: 0; Parameters: "-novideo"; Comment: "Run LEGO Racers without Intro videos"; Components: Minimal; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "Admin"; Description: "Run {#MyAppName} with Administrator Rights"; GroupDescription: "{cm:AdditionalIcons}"

[Registry]
; Registry strings are always hard-coded (No ISPP functions) to ensure everything works properly.
Root: "HKCU"; Subkey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\LEGORacers.exe"; ValueData: "RUNASADMIN"; Flags: uninsdeletevalue; Tasks: Admin

[Run]
; From to to bottom: Extract the CAB, run game (depending on user's choice on the videos).
Filename: "{app}\i5comp.exe"; Parameters: "x ""{app}\DATA1.CAB"""; Flags: runascurrentuser
 Filename: "{app}\{#MyAppExeName}"; Flags: nowait postinstall skipifsilent runascurrentuser; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Components: Full
Filename: "{app}\{#MyAppExeName}"; Parameters: "-novideo"; Flags: nowait postinstall skipifsilent runascurrentuser; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Components: Minimal

; Python Exe written to delete the intro videos, replaced with native Inno Script.
; Filename: "{app}\Uninstall\VideoDel.exe"; Parameters: """{app}"""; Flags: runascurrentuser; Components: Minimal

[UninstallDelete]
; Because the files came from a CAB were not installed from [Files], this is needed to delete them.
Type: files; Name: "{app}\{#MyAppExeName}"
Type: files; Name: "{app}\*.tun"
; Deletes LEGORacers.icd if it exists; Does not throw error if it does not exist
Type: files; Name: "{app}\LEGORacers.icd"
Type: files; Name: "{app}\GolDP.dll"
Type: files; Name: "{app}\LEGO.JAM"
Type: files; Name: "{app}\*.avi"
; Type: filesandordirs; Name: "{app}\Uninstall"

; Python Exe written to delete LEGORacers.icd if it exists, replaced with native Inno Script.
; [UninstallRun]
; Filename: "{app}\Uninstall\ICDDel.exe"; Parameters: """{app}"""; Components: Full Minimal

[Dirs]
; Created to ensure the save games are not removed (which should never ever happen).
Name: "{app}\Save"; Flags: uninsneveruninstall

[Code]
// Pascal script from Bgbennyboy to pull files off a CD, greatly trimmed up and modified to support ANSI and Unicode Inno Setup by Triangle717.
var
	SourceDrive: string;

#include "FindDisc.iss"

function GetSourceDrive(Param: String): String;
begin
	Result:=SourceDrive;
end;

procedure InitializeWizard();
begin
	SourceDrive:=GetSourceCdDrive();
end;