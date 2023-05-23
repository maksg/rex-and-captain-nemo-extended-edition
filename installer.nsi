;NSIS Modern User Interface
;Multilingual Example Script
;Written by Joost Verburg

!pragma warning error all

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;Include FileFunc

  !include "FileFunc.nsh"

;--------------------------------
;Registry Settings

  !define EN_NAME "Rex and Captain Nemo - Extended Edition"
  !define REGISTRY_KEY "Software\${EN_NAME}"
  !define UNINSTALL_REGISTRY_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${EN_NAME}"

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

  ;Show all languages, despite user's codepage
  !define MUI_LANGDLL_ALLLANGUAGES

  ;Properly display all languages (Installer will not work on Windows 95, 98 or ME!)
  Unicode true

;--------------------------------
;Language Selection Dialog Settings

  ;Remember the installer language
  !define MUI_LANGDLL_REGISTRY_ROOT "HKCU" 
  !define MUI_LANGDLL_REGISTRY_KEY "${REGISTRY_KEY}" 
  !define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

;--------------------------------
;Create Desktop Shortcut Function

Function CreateDesktopShortcut
  SetOutPath "$INSTDIR"
  CreateShortcut "$DESKTOP\$(NAME).lnk" "$INSTDIR\nemo.exe"
FunctionEnd

  !define MUI_FINISHPAGE_SHOWREADME ""
  !define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
  !define MUI_FINISHPAGE_SHOWREADME_TEXT "$(CreateDesktopShortcutText)"
  !define MUI_FINISHPAGE_SHOWREADME_FUNCTION CreateDesktopShortcut

;--------------------------------
;Set Install Directory

Function SetInstallDir
  ;Default installation folder
  StrCpy $INSTDIR "$PROGRAMFILES\$(NAME)"
FunctionEnd

;--------------------------------
;Pages

  !define MUI_PAGE_CUSTOMFUNCTION_LEAVE SetInstallDir
  !define MUI_WELCOMEPAGE_TITLE_3LINES
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "license.txt"
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !define MUI_FINISHPAGE_TITLE_3LINES
  !insertmacro MUI_PAGE_FINISH
  
  !define MUI_WELCOMEPAGE_TITLE_3LINES
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !define MUI_FINISHPAGE_TITLE_3LINES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English" ; The first language is the default language
  !insertmacro MUI_LANGUAGE "Polish"
  !insertmacro MUI_LANGUAGE "Czech"
  !insertmacro MUI_LANGUAGE "German"
  !insertmacro MUI_LANGUAGE "Hungarian"
  !insertmacro MUI_LANGUAGE "Romanian"
  !insertmacro MUI_LANGUAGE "Russian"

;--------------------------------
;Reserve Files
  
  ;If you are using solid compression, files that are required before
  ;the actual installation should be stored first in the data block,
  ;because this will make your installer start faster.
  
  !insertmacro MUI_RESERVEFILE_LANGDLL

;--------------------------------
;Create Desktop Shortcut Text

  LangString CreateDesktopShortcutText ${LANG_ENGLISH} "Create desktop shortcut"
  LangString CreateDesktopShortcutText ${LANG_POLISH} "Utwórz skrót na pulpicie"
  LangString CreateDesktopShortcutText ${LANG_CZECH} "Vytvořit zástupce na ploše"
  LangString CreateDesktopShortcutText ${LANG_GERMAN} "Desktopverknüpfung erstellen"
  LangString CreateDesktopShortcutText ${LANG_HUNGARIAN} "Asztali parancsikon létrehozása"
  LangString CreateDesktopShortcutText ${LANG_ROMANIAN} "Creați o comandă rapidă pe desktop"
  LangString CreateDesktopShortcutText ${LANG_RUSSIAN} "Создать ярлык на рабочем столе"

;--------------------------------
;General

  ;Name and file
  LangString Name ${LANG_ENGLISH} "${EN_NAME}"
  LangString Name ${LANG_POLISH} "Reksio i Kapitan Nemo - Edycja Rozszerzona"
  LangString Name ${LANG_CZECH} "${EN_NAME}"
  LangString Name ${LANG_GERMAN} "${EN_NAME}"
  LangString Name ${LANG_HUNGARIAN} "${EN_NAME}"
  LangString Name ${LANG_ROMANIAN} "${EN_NAME}"
  LangString Name ${LANG_RUSSIAN} "${EN_NAME}"
  
  Name $(NAME)
  
  OutFile "RaCN-EE-setup.exe"
  
  ;Default installation folder
  InstallDir "$PROGRAMFILES\$(NAME)"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "${REGISTRY_KEY}" "ProgramPath"

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin

;--------------------------------
;Installer Sections

Section "Game" Game

  SetOutPath "$INSTDIR"
  
  File "BlooMoo.ini"
  File "BlooMooDLL.dll"
  File "dorozka.wav"
  File "dziki_zachod.wav"
  File "egipt.wav"
  File "happyend.wav"
  File "hipisi.wav"
  File "indie.wav"
  File "intro.wav"
  File "introtytul.wav"
  File "komnata_b.wav"
  File "konstantynopol.wav"
  File "kretes.wav"
  File "masajaje.wav"
  File "Microsoft.VC80.CRT.manifest"
  File "msvcm80.dll"
  File "msvcp80.dll"
  File "msvcr80.dll"
  File "mu.wav"
  File "nautilus.wav"
  File "Nemo.exe"
  File "/oname=Nemo.ini" "Nemo.ini.example"
  File "orient_express.wav"
  File "paryz.wav"
  File "rejs.wav"
  File "sndDLL.dll"
  File "wieza.wav"
  File "wyspa.wav"

  SetOutPath "$INSTDIR\common"
  
  File "common\*.*"

  SetOutPath "$INSTDIR\common\classes"
  
  File /r "common\classes\"
  
  !define COMMON_SAVE_DIRECTORY "common\save"
  !define COMMON_SAVE_FULL_DIRECTORY "$INSTDIR\${COMMON_SAVE_DIRECTORY}"

  SetOutPath "${COMMON_SAVE_FULL_DIRECTORY}"
  
  File "/oname=global_info.dta" "${COMMON_SAVE_DIRECTORY}\global_info.dta.example"
  File "${COMMON_SAVE_DIRECTORY}\slot_def.dta"
  CopyFiles "${COMMON_SAVE_FULL_DIRECTORY}\slot_def.dta" "${COMMON_SAVE_FULL_DIRECTORY}\slot0.dta"
  CopyFiles "${COMMON_SAVE_FULL_DIRECTORY}\slot_def.dta" "${COMMON_SAVE_FULL_DIRECTORY}\slot0free.dta"
  CopyFiles "${COMMON_SAVE_FULL_DIRECTORY}\slot_def.dta" "${COMMON_SAVE_FULL_DIRECTORY}\slot1.dta"
  CopyFiles "${COMMON_SAVE_FULL_DIRECTORY}\slot_def.dta" "${COMMON_SAVE_FULL_DIRECTORY}\slot1free.dta"
  CopyFiles "${COMMON_SAVE_FULL_DIRECTORY}\slot_def.dta" "${COMMON_SAVE_FULL_DIRECTORY}\slot2.dta"
  CopyFiles "${COMMON_SAVE_FULL_DIRECTORY}\slot_def.dta" "${COMMON_SAVE_FULL_DIRECTORY}\slot2free.dta"
  CopyFiles "${COMMON_SAVE_FULL_DIRECTORY}\slot_def.dta" "${COMMON_SAVE_FULL_DIRECTORY}\slot3.dta"
  CopyFiles "${COMMON_SAVE_FULL_DIRECTORY}\slot_def.dta" "${COMMON_SAVE_FULL_DIRECTORY}\slot3free.dta"

  SetOutPath "$INSTDIR\dane"
  
  File /r "dane\"

  SetOutPath "$INSTDIR\wavs"
  
  File /r "wavs\"
 
  ;Start Menu
  SetOutPath "$INSTDIR"
  CreateShortcut "$SMPROGRAMS\$(NAME).lnk" "$INSTDIR\Nemo.exe" "" ""
  
  ;Store installation folder
  WriteRegStr HKCU "${REGISTRY_KEY}" "ProgramPath" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
  WriteRegStr HKLM "${UNINSTALL_REGISTRY_KEY}" "DisplayName" "$(NAME)"
  WriteRegStr HKLM "${UNINSTALL_REGISTRY_KEY}" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""

  SectionGetSize ${Game} $0
  IntFmt $0 "0x%08X" $0
  WriteRegDWORD HKLM "${UNINSTALL_REGISTRY_KEY}" "EstimatedSize" "$0"

SectionEnd

;--------------------------------
;Installer Functions

Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  RMDir /r "$INSTDIR\common"
  RMDir /r "$INSTDIR\dane"
  RMDir /r "$INSTDIR\wavs"
  
  Delete "$INSTDIR\BlooMoo.ini"
  Delete "$INSTDIR\BlooMooDLL.dll"
  Delete "$INSTDIR\dorozka.wav"
  Delete "$INSTDIR\dziki_zachod.wav"
  Delete "$INSTDIR\egipt.wav"
  Delete "$INSTDIR\happyend.wav"
  Delete "$INSTDIR\hipisi.wav"
  Delete "$INSTDIR\indie.wav"
  Delete "$INSTDIR\intro.wav"
  Delete "$INSTDIR\introtytul.wav"
  Delete "$INSTDIR\komnata_b.wav"
  Delete "$INSTDIR\konstantynopol.wav"
  Delete "$INSTDIR\kretes.wav"
  Delete "$INSTDIR\masajaje.wav"
  Delete "$INSTDIR\Microsoft.VC80.CRT.manifest"
  Delete "$INSTDIR\msvcm80.dll"
  Delete "$INSTDIR\msvcp80.dll"
  Delete "$INSTDIR\msvcr80.dll"
  Delete "$INSTDIR\mu.wav"
  Delete "$INSTDIR\nautilus.wav"
  Delete "$INSTDIR\Nemo.exe"
  Delete "$INSTDIR\Nemo.ini"
  Delete "$INSTDIR\orient_express.wav"
  Delete "$INSTDIR\paryz.wav"
  Delete "$INSTDIR\rejs.wav"
  Delete "$INSTDIR\sndDLL.dll"
  Delete "$INSTDIR\wieza.wav"
  Delete "$INSTDIR\wyspa.wav"
  
  Delete "$DESKTOP\$(NAME).lnk"
  Delete "$SMPROGRAMS\$(NAME).lnk"
  
  Delete "$INSTDIR\uninstall.exe"

  RMDir "$INSTDIR"

  DeleteRegKey HKCU "${REGISTRY_KEY}"
  DeleteRegKey HKLM "${UNINSTALL_REGISTRY_KEY}"

SectionEnd

;--------------------------------
;Uninstaller Functions

Function un.onInit

  !insertmacro MUI_UNGETLANGUAGE
  
FunctionEnd
