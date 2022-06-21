* Fixed the situation so that the NOTE of the check does not appear in CRAN.

## Test environments
* local R installation, R 4.2.0
* Ubuntu Linux 20.04.1 LTS (on R-hub), R 4.2.0
* win-builder (devel)

## R CMD check results

* There is one NOTE that is only found on Windows (Server 2022, R-devel 64-bit): 

```
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
```
This could be due to a bug/crash in MiKTeX and can likely be ignored.

* The note refers to possibly mis-spelled words in DESCRIPTION. One of this word is "Kansuji" which used in the Japanese writing system.

```
Possibly mis-spelled words in DESCRIPTION:
     Kansuji
```
