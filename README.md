# remote_shark

Use a Windows command file to do remote capture with Wireshark.

## Overview

Wireshark is a graphical network capture and analysis tool available for Windows, Mac and Linux systems. Among its many features, it allows the real time analysis of packets captured on a different Windows system. Remote capture involving non-Windows systems  can be done through an SSH tunnel. remote_shark is project to develop a series of shell scripts to provide remote capture on non-Windows systems.

## remote_shark.cmd

remote_shark.cmd provides remote capture capability between Wireshark running on Windows and non-Windows systems supporting SSH.

### Usage

remote_shark user remote interface tcpdump_-arguments

   user: A user on the remote system with sufficient privileges to run tcpdump. The remote system must be able to authenticate this user with authentication keys, i.e. there is no password prompt when establishing the connection.

   remote: The server name. Some Windows systems will require this to a fully qualified domain name (FQDN) in order to do DNS look up on a local network. If trying to connect produces a not found error, try appending a '.' to the server name.

   interface: The interface on the remote system from which to capture packets.



   tcpdump-arguments: Additional arguments to passed to tcpdump.

### Samples

Monitor eht0 as user ed on server1@example.com

`remote_wireshark.cmd ed example.com eth0`

Monitor wlan0 in monitor (promiscuous) mode, displaying link level data.

`remote_shark>remote_shark.cmd ed server1.example.com wlan0 --monitor-mode -e`



