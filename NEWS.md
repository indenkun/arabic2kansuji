# arabic2kansuji 0.0.0.9902

## BUG FIXES

* Fixed a bug that prevented `arabic2kansuji_all` from converting Arabic numerals and kansuji into a single number(e.g., 1億2345万6789).

* `arabic2kansuji_all`'s processing system has been slightly revised to improve its speed.

# arabic2kansuji 0.0.0.9901

## BUG FIXES

* `arabic2kansuji_num`, `arabic2kansuji_cal` and `arabic2kansuji_all`: Fixed a problem where the conversion could not work well for 0 only.

# arabic2kansuji 0.0.0.9900

## NEW FEATURES

* New function `arabic2kansuji_cal`. This function can convert one or more Arabic numerals to kansuji.

* New function `arabic2kansuji_all`. The function can  convert a string that includes one or more non-Arabic numerals to kansuji, keeping the non-Arabic numerals.

## BUG FIXES

* Problem with `arabic2kansuji_num` concatenating numbers when two or more Arabic numerals were accepted (e.g., c(123, 456) would be calculated as 132456), so we changed it to exit with a message if two or more Arabic numerals were entered.

# arabic2kansuji 0.0.0.9000

* Initial Release to GitHub.
