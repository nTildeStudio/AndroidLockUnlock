ECHO OFF

adb shell dumpsys power | findstr "mScreenOn=true" > nul 2>&1
if not ERRORLEVEL 1 (
	if "%1" == "unlock" (
		adb shell dumpsys statusbar | findstr "mDisabled=0x0" > nul 2>&1
		if ERRORLEVEL 1 (
			GOTO UNLOCKSCREEN
		)
	) else if "%1" == "toggle" (
		adb shell dumpsys statusbar | findstr "mDisabled=0x0" > nul 2>&1
		if ERRORLEVEL 1 (
			GOTO UNLOCKSCREEN
		) else (
			GOTO TURNONOFF
		)
	) else (
		GOTO TURNONOFF
	)
) else (
	if "%1" == "unlock" (
		GOTO TURNONOFF
		GOTO UNLOCKSCREEN
	) else if "%1" == "toggle" (
		GOTO TURNONOFF
		GOTO UNLOCKSCREEN
	)
)
GOTO END

:TURNONOFF
	adb shell input keyevent 26

:UNLOCKSCREEN
	adb shell input keyevent 20
	adb shell input text PUTYOURPASSWORKDHERE
	adb shell input keyevent 66

:END
	EXIT /B
