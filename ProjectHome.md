A perl script to extract from one or more signed p7m file the original file/files. It uses openssl command line tools available on multiple platforms.

It uses the command proposed by Luca Regoli:

openssl.exe  smime -decrypt -verify -inform DER -in "pippo.tif.p7m" -noverify -out "pippo.tif"

It works with the p7m signed files, it's not tested on cades signed files (SHA-256). But tests on SHA-256 signed files are working using openssl 1.0.0e.

The cades signed format will be the new format proposed by U.E.