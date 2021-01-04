
<!-- README.md is generated from README.Rmd. Please edit that file -->

# arabic2kansuji

<!-- badges: start -->

<!-- badges: end -->

`{arabic2kansuji}` is a package consisting of Simple functions to
convert given Arabic numerals to “Kansuji” numerical figures that
represent numbers written in Chinese characters.

## Installation

You can install the released version of {zipangu} from CRAN with:

``` r
install.packages("arabic2kansuji")
```

and also, install the development version install from GitHub:

``` r
install.packages("remotes")
remotes::install_github("indenkun/arabic2kansuji")
```

## Example

load library.

``` r
library(arabic2kansuji)
```

### `arabic2kansuji`

`arabic2kansuji` is a function that converts Arabic numerals to Kansuji
verbatim.

There is no need to enclose only half-width Arabic numerals with
double-quotation marks.

``` r
arabic2kansuji(1234567890)
#> [1] "一二三四五六七八九〇"
```

If you give a string containing Arabic numerals, everything else is
retained except the Arabic numerals to be converted. Strings containing
Arabic numerals can be converted, but please enclose them in
double-quotations

``` r
arabic2kansuji("昭和64年は1989年1月7日までです。")
#> [1] "昭和六四年は一九八九年一月七日までです。"
```

By default, it converts only half-width Arabic numerals, but you can
also convert only full-width Arabic numerals or convert both full-width
and half-width Arabic numerals to Kansuji by specifying arguments.

``` r
# By default, full-width Arabic numerals will not be converted.
arabic2kansuji("東京都新宿区西新宿２丁目８−１")
#> [1] "東京都新宿区西新宿２丁目８－１"
# It can convert full-width Arabic numerals by providing an argument.
arabic2kansuji("東京都新宿区西新宿２丁目８−１", width = "full")
#> [1] "東京都新宿区西新宿二丁目八－一"
arabic2kansuji("全角アラビア数字１２３と半角アラビア数字123の混在も引数を指定すると変換できます。", width = "all")
#> [1] "全角アラビア数字一二三と半角アラビア数字一二三の混在も引数を指定すると変換できます。"
```

By default, 0 is converted to rei (〇), but it can be converted to zero
(零) by specifying an argument.

``` r
arabic2kansuji("令和２年は2020年")
#> [1] "令和２年は二〇二〇年"
arabic2kansuji("令和2年は2020年", zero = "zero")
#> [1] "令和二年は二零二零年"
```

Since this function only replaces Arabic numerals with Kansuji verbatim,
it cannot be converted by calculating 1234 as 千二百三十四. This feature is
provided by the `arabic2kansuji_num` functions.

### `arabic2kansuji_num`

This `arabic2kansuji_num` calculates and converts a given number to a
kanji value. For example, 1234 can be converted to 千二百三十四.

``` r
arabic2kansuji_num(124271318)
#> [1] "一億二千四百二十七万千三百十八"
```

However, currently only accept one half-width Arabic numerals.

Use `arabic2kansuji_cal` if you want to convert two or more half-width
Arabic numerals by calculating the number of Chinese characters. You can
also use `arabic2kansuji_all` to convert full-width Arabic numerals (as
a string) to Kansuji.

``` r
arabic2kansuji_num("124271318人")
#> Warning in .f(.x[[i]], ...): only number can convert to kansuji.
#> [1] NA
```

Use `arabic2kansuji_all` to calculate and convert Arabic numerals to
Kansuji while keeping the string in Arabic numerals containing the
string.

For more than 17 digits, a warning is given because calculation
processing may not be performed correctly due to problems on the R.

``` r
arabic2kansuji_num(1234567890123456789)
#> Warning in .f(.x[[i]], ...): too long number to convert exactly.
#> [1] "百二十三京四千五百六十七兆八千九百一億二千三百四十五万六千七百六十八"
```

Negative values are also supported. The notation will be 負Kansuji.

``` r
arabic2kansuji_num(-123456789)
#> [1] "負一億二千三百四十五万六千七百八十九"
```

Too large values (more than 10 to the power of 20) cannot be calculated.

``` r
arabic2kansuji_num(100000000000000000000)
#> Warning in .f(.x[[i]], ...): too large number to convert.
#> [1] NA
```

`arabic2kansuji_num` accepts two or more Arabic numerals, calculates and
converts them to Kansuji.

``` r
x <- c(123, 456, 789)
arabic2kansuji_num(x)
#> [1] "百二十三"   "四百五十六" "七百八十九"
```

### `arabic2kansuji_all`

`arabic2kansuji_num` only accepts half-width Arabic numbers, but
`arabic2kansuji_all` can convert a string containing a half-width Arabic
number to Kansuji and keep the string. `arabic2kansuji_all` can convert
not only half-width Arabic numerals but also full-width Arabic numerals
can be converted by specifying an argument. However, it is not possible
to convert only the full-size Arabic numerals in the string and keep the
half-size Arabic numerals.

``` r
arabic2kansuji_all("昭和64年は1989年1月7日までです。")
#> [1] "昭和六十四年は千九百八十九年一月七日までです。"
arabic2kansuji_all("平成３１年は2019年4月30日までです。")
#> [1] "平成３１年は二千十九年四月三十日までです。"
arabic2kansuji_all("平成３１年は2019年4月30日までです。", widths = "all")
#> [1] "平成三十一年は二千十九年四月三十日までです。"
```

`arabic2kansuji_all` can receive more than one string.

``` r
x <- c("昭和64年は1989年1月7日までです。", "平成31年は2019年4月30日までです。")
arabic2kansuji_all(x)
#> [1] "昭和六十四年は千九百八十九年一月七日までです。"
#> [2] "平成三十一年は二千十九年四月三十日までです。"
```

`arabic2kansuji_all` can also convert Arabic numerals and Kansuji
intended for digits to represent a single number, such as 1億2345万
intended for 一億二千三百四十五万. This is a kind of side effect that happens when
Arabic numbers are converted to Kansuji because the readings are just
the same.

``` r
arabic2kansuji_all("1億2345万")
#> [1] "一億二千三百四十五万"
```

## Imports packages

  - `{purrr}`
  - `{stringr}`
  - `{stats}`

## Known Issue

  - `arabic2kansuji_all` a combination of Arabic and Kansuji
    representing a single number of digits, such as tens or billions,
    but not including the next upper tens or billions of digits, such as
    12345万, which is intended to be 一億二千三百四十五万, would be valued at
    一万二千三百四十五 in the Arabic numeral place and would not
    appear in the intended form. There is currently no error on this
    issue.

<!-- end list -->

``` r
arabic2kansuji_all("12345万")
#> [1] "一万二千三百四十五万"
```

  - `arabic2kansuji_*` does not support conversion of values greater
    than one hundred quintillion. Entering a value greater than one
    hundred quintillion will return a warning message and NA.

<!-- end list -->

``` r
arabic2kansuji_num(1e+20)
#> Warning in .f(.x[[i]], ...): too large number to convert.
#> [1] NA
arabic2kansuji_all("100000000000000000000個")
#> Warning in .f(.x[[i]], ...): too large number to convert.
#> [1] NA
```

## License

MIT.
