# arabic2kansuji 0.0.0.9900

## NEW FEATURES

* New function `arabic2kansuji_cal`. This function can convert one or more Arabic numerals to kansuji.

* New function `arabic2kansuji_all`. The function can  convert a string that includes one or more non-Arabic numerals to kansuji, keeping the non-Arabic numerals.

## BUG FIXES

* Problem with `arabic2kansuji_num` concatenating numbers when two or more Arabic numerals were accepted (e.g., c(123, 456) would be calculated as 132456), so we changed it to exit with a message if two or more Arabic numerals were entered.

# arabic2kansuji 0.0.0.9000

* Initial Release to GitHub.
