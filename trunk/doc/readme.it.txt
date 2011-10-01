+------------------+
|  EXTRACT-P7M.PL  |
+------------------+

Lo script richiede perl ed openssl. Vedere sotto come installarli.
Lo script agisce sulla cartella corrente dove viene eseguito. Prende tutti i file
con estensione .p7m e ne estrae il file originale. Vengono estratti fino a 5 livelli di firma,
quindi per esempio dal file documento.pdf.p7m.p7m.p7m.p7m.p7m viene
estratto correttamente il file documento.pdf. Nel caso ci siano ulteriori livelli
di firma, basta rieseguire lo script nella stessa cartella.

INSTALLAZIONE PREREQUISITI WINDOWS
----------------------------------
Installare Activeperl Community Edition per windows.
Installare OpenSSL per windows. OpenSSL per windows puo' essere scaricato
dal sito www.slproweb.com, da questo indirizzo:

http://www.slproweb.com/download/Win32OpenSSL_Light-1_0_0e.exe

[la versione light e' sufficiente]

controllare che i comandi openssl e perl siano nella path.

INSTALLAZIONE PREREQUISITI LINUX
--------------------------------
Perl e openssl dovrebbero essere gia' installati. Se non fosse cosi'
installare i pacchetti della propria distribuzione, per esempio su
xubuntu-11.04 eseguire il comando:

sudo apt-get install perl openssl






