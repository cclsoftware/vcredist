SetOutPath "$TEMP"

!ifdef ARM64
  File "${CCL_BASEDIR}\submodules\vcredist\VC_redist.arm64.exe"
  !define CRTINSTALLER "$OUTDIR\VC_redist.arm64.exe"
!else
  !ifdef X64_COMPATIBLE
    File "${CCL_BASEDIR}\submodules\vcredist\VC_redist.x64.exe"
    !define CRTINSTALLER "$OUTDIR\VC_redist.x64.exe"
  !else
    File "${CCL_BASEDIR}\submodules\vcredist\VC_redist.x86.exe"
    !define CRTINSTALLER "$OUTDIR\VC_redist.x86.exe"
  !endif
!endif

var /global crtInstallerUIMode
${If} ${Silent}
	StrCpy $crtInstallerUIMode "/quiet"
${Else}
	StrCpy $crtInstallerUIMode "/passive"
${EndIf}

ExecWait '"${CRTINSTALLER}" /install $crtInstallerUIMode /norestart'
Delete "${CRTINSTALLER}"
