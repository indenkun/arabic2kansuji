
<!-- README.md is generated from README.Rmd. Please edit that file -->

# arabic2kansuji

<!-- badges: start -->

<!-- badges: end -->

`{arabic2kansuji}` is a package consisting of functions to convert
Arabic numerals to kansuji.

## Installation

You can install `{arabic2kansuji}` from GitHub:

``` r
devtools::install_github("indenkun/arabic2kansuji")
```

## Example

load library.

``` r
library(arabic2kansuji)
```

### `arabic2kansuji`

`arabic2kansuji` is a function that converts Arabic numerals to kansuji
verbatim.

There is no need to enclose only half-width Arabic numerals with
double-cotation marks.

``` r
arabic2kansuji(1234567890)
#> [1] "一二三四五六七八九〇"
```

If you give a string containing Arabic numerals, everything else is
retained except the Arabic numerals to be converted. Strings containing
Arabic numerals can be converted, but please enclose them in
double-cotations

``` r
arabic2kansuji("昭和64年は1989年1月7日までです。")
#> [1] "昭和六四年は一九八九年一月七日までです。"
```

By default, it converts only half-width Arabic numerals, but you can
also convert only full-width Arabic numerals or convert both full-width
and half-width Arabic numerals to kansuji by specifying arguments.

``` r
# By default, full-width Arabic numerals will not be converted.
arabic2kansuji("東京都新宿区西新宿２丁目８−１")
#> [1] "東京都新宿区西新宿２丁目８－１"
# It can convert full-width Arabic numerals by providing an argument.
arabic2kansuji("東京都新宿区西新宿２丁目８−１", width = "fullwidth")
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

Since this function only replaces Arabic numerals with kansuji verbatim,
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
a string) to kansuji.

``` r
arabic2kansuji_num("124271318人")
#> Error in arabic2kansuji_num("124271318人"): only number can convert to kansuji.
```

Use `arabic2kansuji_all` to calculate and convert Arabic numerals to
kansuji while keeping the string in Arabic numerals containing the
string.

For more than 17 digits, a warning is given because calculation
processing may not be performed correctly due to problems on the R.

``` r
arabic2kansuji_num(1234567890123456789)
#> Warning in arabic2kansuji_num(1234567890123456768): too long to convert.
#> [1] "百二十三京四千五百六十七兆八千九百一億二千三百四十五万六千七百六十八"
```

Negative values are also supported. The notation will be 負kansuji.

``` r
arabic2kansuji_num(-123456789)
#> [1] "負一億二千三百四十五万六千七百八十九"
```

Some values (e.g. 10 to the power of 10, such as 10 to the power of 10)
cannot be correctly calculated to a multiple greater than 2147483647,
resulting in an error. This is a problem that relies on R’s integer
processing, so there are no plans to fix it as the present time.

``` r
arabic2kansuji_num(10000000000)
#> Error in arabic2kansuji_num(1e+10): too large number and not good shape to convert.
```

### `arabic2kansuji_call`

`arabic2kansuji_num` does not accept more than one half-width Arabic
numeral, but `arabic2kansuji_cal` accepts two or more Arabic numerals,
calculates and converts them to kansuji.

``` r
x <- c(123, 456, 789)
arabic2kansuji_num(x)
#> only one number can convert to kansuji. 
#> use `arabic2kansuji_cal` to convert to over 2 numbers.
#> Error in arabic2kansuji_num(x):
```

``` r
arabic2kansuji_cal(x)
#> [1] "百二十三"   "四百五十六" "七百八十九"
```

### `arabic2kansuji_all`

`arabic2kansuji_num` and `arabic2kansuji_cal` only accepts half-width
Arabic numbers, but `arabic2kansuji_all` can convert a string containing
a half-width Arabic number to kansuji and keep the string.
`arabic2kansuji_all` can convert not only half-width Arabic numerals but
also full-width Arabic numerals can be converted by specifying an
argument. However, it is not possible to convert only the full-size
Arabic numerals in the string and keep the half-size Arabic numerals.

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

## Improrts packges

  - `{purrr}`
  - `{stringr}`
  - `{stats}`

## Known Issue

<<<<<<< HEAD
`arabic2kansuji_num`, `arabic2kansuji_call` and `arabic2kansuji_all` is
that it represents a single number like this “1億2345万6789”, mixed Arabic
=======
It represents a single number like this “1億2345万6789”, mixed Arabic
>>>>>>> c2f78c71ce8448587640322eedfcd1e4e7a3a754
numeral and kansuji do not convert well.

## Reference

The code and sites we used to write this code. Thank you very much.

  - [Rで文字列中の旧字体を新字体にまとめて変換する -
    Qiita](https://qiita.com/hzm_0901/items/c77bec84d261e0ae2bfe)
  - [uribo/zipangu](https://github.com/uribo/zipangu)

## License

MIT.

## Notice

The email address listed in the DESCRIPTION is a dummy. If you have any
questions, please post them on ISSUE.
