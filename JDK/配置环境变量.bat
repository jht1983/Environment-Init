@echo off
echo зЂВс JDK
md "%temp%\regeditTemp"
cd /d "%temp%\regeditTemp"
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v path >> path.txt
for /f "skip=2 tokens=1,2*" %%a in ('type path.txt') do (
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v path /t REG_EXPAND_SZ /d "%%c;%%JAVA_HOME%%\bin;%%JAVA_HOME%%\jre\bin" /f
)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v JAVA_HOME /d "C:\Program Files\Java\jdk1.8.0_60" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v CLASSPATH /d "." /f
cd /d "%temp%"
rd /s /q "%temp%\regeditTemp"
