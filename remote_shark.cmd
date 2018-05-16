:: Name:	remote_wireshark.cmd
:: Purpose:	Execute tcpdump on a remote system box via ssh from a Windows machine
:: 		and pipe the captured packets to wireshark locally.
:: Author:	erubinskt@chaveirisystems.com
:: Revisions:	May 15, 2018. Initial version.
:: Called as:	remote_wireshark.cmd user remote interface
::    user: A user on the remote system with sufficient privileges to run tcpdump.
::    remote: The remote system to be monitored.
::    interface: The interface to monitor.
::    remote_wireshark.cmd root somemachine eth0
::
:: Requirements.
:: ssh must be able to make the connection using authentication keys, i.e. without entering a password.
::
:: Wireshark must be in the path of the local user running this script.

@ECHO OFF
setlocal ENABLEDELAYEDEXPANSION
Echo R E M O T E  PACKET CAPTURE
SETLOCAL

:: Validate that 3 paramters were passed
set argCount=0
for %%x in (%*) do (
   set /A argCount+=1
   set "argVec[!argCount!]=%%~x"
 )
 IF !argCount! NEQ 3 (
   echo Usage: %0 user_name remote_system interface
   goto fini
 )


:: Check that both wireshark and ssh are in the path
echo %PATH% > path.txt
FINDSTR /I /c:wireshark path.txt > NUL &&  (echo Wireshark in path) || (echo Wireshark not in path && exit /B 1)
FINDSTR /I /c:ssh  path.txt > NUL &&  (echo ssh in path) || (echo ssh not in path && exit /B 1)
DEL  path.txt

:: Initialize local variables.
:: Script name
set me=%0

:: Remote user
set usr=%1

:: Remote to run capture on. If running the capture requires root privledges the root account
:: should have the public key of the the user running this batch file in it's .ssh/authorized_keys
:: file.
SET remote=%2

:: Remote interface
set interface=%3

:: The ssh command to start the capture.
:: The interface to capture on follows the -i.
:: The captured packets are written to stdout, causing them to written here.
SET ssh_cmd=ssh %usr%@%remote% tcpdump -U -s0 'not port 22' -i %interface% -w -

:: The command to run wireshark.
:: -k starts capturing immediately.
:: -i - sets the interface to stdin.
SET shark=wireshark.exe -k -i -

:: Do it. Note that may be delay before packets are displayed when this script is started, as well as a delay before
:: this script to terminates after exiting Wireshark. This is (probably) due to the time it takes to build the ssh connection
:: at startup and flush the pipe and take down the ssh connection on termination.
ECHO %ssh_cmd%

%ssh_cmd% | %shark%

:fini
:: Any errors from either Wireshark or the remote tcpdump will be displayed in the command window.
:: There shouldn't be any need to check %ERRORLEVEL%,
Exit /B 0
