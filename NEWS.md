# arabic2kansuji 0.0.0.9911

## BUG FIXES

* Problem solved where certain patterns of numbers could not be converted to kansuji.

# arabic2kansuji 0.0.0.9910

## BUG FIXES

* Problem solved with multiple functions that could not be converted Arabic numerals to kansuji correctly.

## Deprecation

* The functions of `arabic2kansuji_num`, which converts single Arabic numerals to kansuji, and `arabic2kansuji_cal`, which accepts multiple Arabic numerals and converts them to kansuji are duplicated, so `arabic2kansuji_num` is now a function that converts multiple Arabic numerals to kansuji, and functions that accept single Arabic numerals can no longer be used (but existing in code as `arabic2kansuji_cal`).

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
