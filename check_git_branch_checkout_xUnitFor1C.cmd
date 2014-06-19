@echo off
rem 
rem ����஢���� ��४��祭�� ��⮪ �࠭���� xUnitFor1C
rem
rem �ॡ������: 
rem 	1. ��⠭������� Git. ���� � ���� ��室����� � ��⥬��� PATH.
rem		⠪�� ����� ���� ��⠭����� SourceTree c� ���஥��� Git.
rem		2. ����� � ᠩ�� GitHub - https://github.com/xDrivenDevelopment/xUnitFor1C
rem 
rem �ਬ�� �맮�� (��४��祭�� master <-> develop � ���⭮): 
rem 	git_xUnitFor1C_check.cmd
rem ��� (��४��祭�� master <-> develop <-> �����⪨ � ���⭮): 
rem 	git_xUnitFor1C_check.cmd �����⪨
rem

setlocal
if "%1"=="" ( set branch=develop 
) else ( 
	set branch=%1
)
	rem echo %branch%

set git_cmd=git
if EXIST "%LOCALAPPDATA%\Atlassian\SourceTree\git_local\cmd\git.exe" set git_cmd="%LOCALAPPDATA%\Atlassian\SourceTree\git_local\cmd\git.exe"

set remoteRepo=https://github.com/xDrivenDevelopment/xUnitFor1C.git
	rem set remoteRepo=C:\Projects\xUnitFor1C_t1\.git

set repo=%CD%\xUnitFor1C_temp831

	rem echo %repo%

rd /S /Q %repo%
if EXIST %repo% (
	tskill TGitCache
	rd /S /Q %repo%
	if EXIST %repo% (
		echo �� 㤠���� 㤠���� ��⠫�� %repo%
		exit 1
		pause
	)
)

md %repo%

%git_cmd% -c diff.mnemonicprefix=false -c core.quotepath=false clone --recursive %remoteRepo% %repo%

cd %repo%
%git_cmd% checkout -b develop
if errorlevel 1 (
	echo �� 㤠���� ��४������� �� ���� develop
	exit 2
	pause
)
%git_cmd% status

if not %branch%==develop (
	%git_cmd% checkout -b %branch%
	if errorlevel 1 (
		echo �� 㤠���� ��४������� �� ���� %branch%
		exit 5
		pause
	)
	%git_cmd% status
)

%git_cmd% checkout master
if errorlevel 1 (
	echo �� 㤠���� ��४������� �� ���� master
	exit 3
	pause
)
%git_cmd% status

%git_cmd% checkout  develop
if errorlevel 1 (
	echo �� 㤠���� ����୮ ��४������� �� ���� develop
	exit 4 
	pause
)
%git_cmd% status

if not %branch%==develop (
	%git_cmd% checkout %branch%
	if errorlevel 1 (
		echo �� 㤠���� ����୮ ��४������� �� ���� %branch%
		exit 6
		pause
	)
	%git_cmd% status
)

%git_cmd% checkout master
if errorlevel 1 (
	echo �� 㤠���� ����୮ ��४������� �� ���� master
	exit 7
	pause
)
%git_cmd% status

endlocal
echo �� ��४��祭�� �����訫��� �ᯥ譮
exit 0