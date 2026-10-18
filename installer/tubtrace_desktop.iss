#define MyAppName "TubTrace Desktop"
#define MyAppVersion "1.0.0"
#define MyAppExeName "tubtrace_desktop.exe"

[Setup]
AppId={{C7E16AC2-70C4-4D80-A55A-B7D9111324D6}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
DefaultDirName={autopf}\TubTrace Desktop
DefaultGroupName={#MyAppName}
OutputDir=..\dist
OutputBaseFilename=TubTraceDesktopSetup
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
PrivilegesRequired=admin
Compression=lzma2
SolidCompression=yes
WizardStyle=modern

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional icons:"; Flags: unchecked

[Files]
Source: "..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch {#MyAppName}"; Flags: postinstall nowait skipifsilent