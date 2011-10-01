+------------------+
|  EXTRACT-P7M.PL  |
+------------------+

The script requires perl and openssl. See below how to install them.
The script works on the current folder where it's executed. It takes
all files in that folder with .p7m extension and extracts the original
file. It extracts up to 5 nested levels of signing. For example the file
document.pdf.p7m.p7m.p7m.p7m.p7m should be extracted to document.pdf.
For more than 5 levels rerun this script in the same folder.

WINDOWS REQUIREMENTS INSTALLATION
---------------------------------
Install Activeperl Community Edition for windows.
Install OpenSSL for windows. OpenSSL can be downloaded
from www.slproweb.com, at this link:

http://www.slproweb.com/download/Win32OpenSSL_Light-1_0_0e.exe

[light version is enough]

check openssl and perl executables are in the path.

LINUX REQUIREMENTS INSTALLATION
-------------------------------
Perl and OpenSSL should be already installed. If not,
install the packages of your distribution.
On ubuntu for example run:
sudo apt-get install perl openssl






