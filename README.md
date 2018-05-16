<link rel="stylesheet" href= "modest.css">

# remote_shark {.modest-h1}

Use a Windows command file to do remote capture with Wireshark.

## Overview {.modest-h2}

Wireshark is a graphical network capture and analysis tool available for Windows, Mac and Linux systems. Among its many features, it allows the real time analysis of packets captured on a different Windows system. Remote capture involving non-Windows systems  can be done through an SSH tunnel. remote_shark is project to develop a series of shell scripts to provide remote capture on non-Windows systems.

## remote_shark.cmd {.modest-h2}

remote_shark.cmd provides remote capture capability between Wireshark running on Windows and non-Windows systems supporting SSH.

### Usage {.modest-h3}

remote_shark user remote interface

   user: A user on the remote system with sufficient privileges to run tcpdump. The remote system must be able to authenticate this user with authentication keys, i.e. there is no password prompt when establishing the connection.

   remote: The server name. Some Windows systems will require this to a fully qualified domain name (FQDN) in order to do DNS look up on a local network. If trying to connect produces a not found error, try appending a '.' to the server name.

   interface: The interface on the remote system from which to capture packets.
