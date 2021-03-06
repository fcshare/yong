; 该脚本使用 HM VNISEdit 脚本编辑器向导产生

; 安装程序初始定义常量
!define PRODUCT_NAME "小小98五笔"
!define HELP_ME "帮助文档"
!define PRODUCT_VERSION "5.0.0.0"
!define PRODUCT_PUBLISHER "乘凉的猪"
!define PRODUCT_WEB_SITE "http://98wb.ys168.com/"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; ------ MUI 现代界面定义 (1.67 版本以上兼容) ------
!include "MUI.nsh"

; MUI 预定义常量
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\orange-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; 欢迎页面
!insertmacro MUI_PAGE_WELCOME
; 许可协议页面
!insertmacro MUI_PAGE_LICENSE "README.txt"
; 安装目录选择页面
!insertmacro MUI_PAGE_DIRECTORY
; 安装过程页面
!insertmacro MUI_PAGE_INSTFILES
; 安装完成页面
!define MUI_FINISHPAGE_RUN "$INSTDIR\yong.exe"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\*.*"
!insertmacro MUI_PAGE_FINISH

; 安装卸载过程页面
!insertmacro MUI_UNPAGE_INSTFILES

; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"

; 安装预释放文件
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI 现代界面定义结束 ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "..\小小98五笔.exe"
InstallDir "$PROGRAMFILES\小小98五笔"
ShowInstDetails show
ShowUnInstDetails show
BrandingText "98五笔输入法"

Section "MainSection" SEC01
  loop:
  FindWindow $R0 "yong_main"
  IntCmp $R0 0 done
  MessageBox MB_OKCANCEL "程序正在运行。$\n点击“确定”按钮会关闭程序然后继续安装，点击“取消”按钮将退出安装程序" IDOK NoAbort
  Abort
  NoAbort:
  SendMessage $R0 2 0 0
; 稍等后继续检测直至检测不到或用户选择取消
  Sleep 444
  Goto loop
  done:
   
SetOutPath $INSTDIR

File *.bat
File *.txt
File *.bin
File *.ini
File *.so
File *.dll
File *.chm
File *.exe

SetOutPath $INSTDIR\mb
File mb\*
SetOutPath $INSTDIR\skin
File skin\*
SetOutPath $INSTDIR\entry
File entry\*
SetOutPath $INSTDIR\tsf
File tsf\*
SetOutPath $INSTDIR\w64
File w64\*

CreateDirectory $APPDATA\yong 

  Sleep 444
    
 ExecWait '"$INSTDIR\tsf\tsf-reg.exe" -i'
 ExecWait '"$INSTDIR\tsf\tsf-reg64.exe" -i'


  
SectionEnd

Section -AdditionalIcons
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Run" "yong" "$INSTDIR\yong.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Run" "yong" "$INSTDIR\yong.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

/******************************
 *  以下是安装程序的卸载部分  *
 ******************************/

Section Uninstall
 
loop:
FindWindow $R0 "yong_main"
IntCmp $R0 0 done
SendMessage $R0 2 0 0
Sleep 444
Goto loop
done:

RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"
Delete "$SMSTARTUP\${PRODUCT_NAME}.lnk"

IfFileExists "$INSTDIR\tsf\tsf-reg.exe" 0 +2
ExecWait '"$INSTDIR\tsf\tsf-reg.exe" -u -d'

IfFileExists "$INSTDIR\tsf\tsf-reg64.exe" 0 +2
ExecWait '"$INSTDIR\tsf\tsf-reg64.exe" -u -d'

  Sleep 420
  
  Delete "$INSTDIR\*.bat"
  Delete "$INSTDIR\*.txt"
  Delete "$INSTDIR\*.bin"
  Delete "$INSTDIR\*.ini"
  Delete "$INSTDIR\*.so"
  Delete "$INSTDIR\*.dll"
  Delete "$INSTDIR\*.chm"
  Delete "$INSTDIR\*.nsi"
  Delete "$INSTDIR\*.dat"
  Delete "$INSTDIR\*.url"
  Delete "$INSTDIR\*.exe"
  Delete "$INSTDIR\*.del"
  
  Sleep 444
  
  Delete   "$INSTDIR\w64\*"
  Delete   "$INSTDIR\tsf\*"
  Delete   "$INSTDIR\skin\*"
  Delete   "$INSTDIR\mb\*"
  Delete   "$INSTDIR\entry\*"

  Sleep 444
  
  RMDir /r "$INSTDIR\mb"
  RMDir /r "$INSTDIR\tsf"
  RMDir /r "$INSTDIR\skin" 
  RMDir /r "$INSTDIR\w64"  
  RMDir /r "$INSTDIR\entry"
  RMDir /r "$INSTDIR\.yong"
  RMDir /r "$APPDATA\yong"
  RMDir /r "$INSTDIR"
  
  Sleep 444
  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Run"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd
#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确实要完全移除 $(^Name) ，及其所有的组件？" IDYES +2
  Abort
FunctionEnd

Function .onInstSuccess
  CreateDirectory $APPDATA\yong\mb
  CreateDirectory $APPDATA\yong\mb\secret  
  SetOutPath $APPDATA\yong\mb
  File mb\*
  SetOutPath $APPDATA\yong\mb\secret
  File mb\secret\* 
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) 已成功地从您的计算机移除。"
FunctionEnd
