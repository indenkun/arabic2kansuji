* Update familiar to version 1.3.0.

* Made it possible to correct conversions of some numbers to Chinese numerals that are not erroneous but are uncomfortable for native speakers.

## Test environments
* local R installation, R 4.2.1
* Ubuntu Linux 20.04.1 LTS (on R-hub), R 4.2.1
* Fedora Linux (on R-hub), R-devel
* win-builder (devel)

## R CMD check results

* There is one NOTE that is only found on Windows (Server 2022, R-devel 64-bit): 

```
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
```
This could be due to a bug/crash in MiKTeX and can likely be ignored.

* There is one NOTE that is only found on Fedora Linux (R-devel, clang, gfortran):

```
* checking HTML version of manual ... NOTE
Skipping checking HTML validation: no command 'tidy' found
```

I cannot change that Tidy is not on the path, or update Tidy on the external Fedora Linux server. This issue on Fedora does not seem to be caused by the package itself.

## revdepcheck results

We checked 1 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages

