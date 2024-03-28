RustDesk Install Script (GPO/MDT)
-
This Powershell script is capable of:

- Checking to see if the device has RustDesk installed already.
- Storing the IP Address and Key for the RustDesk Server.
- Silently install version 1.2.3-1 of RustDesk on the device.

It can be used as a GPO or MDT script to help provision this software automatically and mass deploy it to endpoints. You may need to add:
````
%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -Noninteractive -Executionpolicy bypass -Noprofile -File {pathToFile.ps1}
````
