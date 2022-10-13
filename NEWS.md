# arabic2kansuji 0.1.3

* Made it possible to correct conversions of some numbers to Chinese numerals that are not erroneous but are uncomfortable for native speakers.
    * A new argument (`add.one_thousand` and `add.one_thousand.all`) has been added to specify whether or not 1 should be displayed as a Chinese numeral when the thousandth digit is 1.

# arabic2kansuji 0.1.2

* Fixed the situation so that the NOTE of the check does not appear in CRAN.

# arabic2kansuji 0.1.1

* FIX BUG
    * Fixed a bug that prevented the return of a value when a large value such as 1e23 was entered, and changed it to return NA with an error message.
 
# arabic2kansuji 0.1.0

* Initial CRAN release.
