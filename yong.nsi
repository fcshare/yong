; �ýű�ʹ�� HM VNISEdit �ű��༭���򵼲���

; ��װ�����ʼ���峣��
!define PRODUCT_NAME "СС98���"
!define HELP_ME "�����ĵ�"
!define PRODUCT_VERSION "5.0.0.0"
!define PRODUCT_PUBLISHER "��������"
!define PRODUCT_WEB_SITE "http://98wb.ys168.com/"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
!include "MUI.nsh"

; MUI Ԥ���峣��
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\orange-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; ��ӭҳ��
!insertmacro MUI_PAGE_WELCOME
; ���Э��ҳ��
!insertmacro MUI_PAGE_LICENSE "README.txt"
; ��װĿ¼ѡ��ҳ��
!insertmacro MUI_PAGE_DIRECTORY
; ��װ����ҳ��
!insertmacro MUI_PAGE_INSTFILES
; ��װ���ҳ��
!define MUI_FINISHPAGE_RUN "$INSTDIR\yong.exe"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\*.*"
!insertmacro MUI_PAGE_FINISH

; ��װж�ع���ҳ��
!insertmacro MUI_UNPAGE_INSTFILES

; ��װ�����������������
!insertmacro MUI_LANGUAGE "SimpChinese"

; ��װԤ�ͷ��ļ�
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI �ִ����涨����� ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "..\СС98���.exe"
InstallDir "$PROGRAMFILES\СС98���"
ShowInstDetails show
ShowUnInstDetails show
BrandingText "98������뷨"

Section "MainSection" SEC01
  loop:
  FindWindow $R0 "yong_main"
  IntCmp $R0 0 done
  MessageBox MB_OKCANCEL "�����������С�$\n�����ȷ������ť��رճ���Ȼ�������װ�������ȡ������ť���˳���װ����" IDOK NoAbort
  Abort
  NoAbort:
  SendMessage $R0 2 0 0
; �ԵȺ�������ֱ����ⲻ�����û�ѡ��ȡ��
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
 *  �����ǰ�װ�����ж�ز���  *
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
#-- ���� NSIS �ű��༭�������� Function ���α�������� Section ����֮���д���Ա��ⰲװ�������δ��Ԥ֪�����⡣--#

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���������е������" IDYES +2
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
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) �ѳɹ��ش����ļ�����Ƴ���"
FunctionEnd
