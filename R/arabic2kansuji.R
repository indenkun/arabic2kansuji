#' Convert Arabic numerals to Kansuji
#' @description
#' Converts a given Arabic numerals to Kansuji numerical figures that written
#' in Chinese characters (in other words, Chinese numeral). \code{arabic2kansuji()}
#' function can also convert Arabic numerals in the string to kansuji.
#' \code{arabic2kansuji_num()} function can convert a vector of only one Arabic
#' numerals to Kansuji. Use \code{arabic2kansuji_all()} can calculate and convert
#' Arabic numerals to Kansuji while retaining the original non-Arabic numeral
#' string.
#' @param str Input vector.
#' @param zero Selects whether 0 should be zero like o ("rei") or zero like have
#'             rain crown ("zero") when Arabic numerals are converted to kansuji.
#' @param width Selects whether you want to convert Arabic numbers, only
#'              half-width numbers ("half") or only full-width
#'              numbers ("full") or both half-width and full-width
#'              numbers ("all") when converting Arabic numbers to kansuji.
#'
#' @rdname arabic2kansuji
#' @return a character.
#' @examples
#' arabic2kansuji(2020)
#' arabic2kansuji(2020, zero = "zero")
#' arabic2kansuji(c(2019, 2020, 2021))
#' arabic2kansuji_num(2020)
#' arabic2kansuji_num((c(2019, 2020, 2021)))
#' arabic2kansuji_all("This year is 2020, next year is 2021.")
#' @export
#'
arabic2kansuji <- function(str,
                           zero = c("rei", "zero"),
                           width = c("half", "full", "all")){

  zero <- match.arg(zero)
  width <- match.arg(width)

  arabicn_half <- "1234567890"
  arabicn_full <- "\uff11\uff12\uff13\uff14\uff15\uff16\uff17\uff18\uff19\uff10"

  if(zero == "rei") kansuji <- "\u4e00\u4e8c\u4e09\u56db\u4e94\u516d\u4e03\u516b\u4e5d\u3007"
  else if(zero == "zero") kansuji <- "\u4e00\u4e8c\u4e09\u56db\u4e94\u516d\u4e03\u516b\u4e5d\u96f6"

  arabicn_half <- unlist(stringr::str_split(arabicn_half, ""))
  arabicn_full <- unlist(stringr::str_split(arabicn_full, ""))
  kansuji <- unlist(stringr::str_split(kansuji, ""))

  if(width == "half") arabicn <- arabicn_half
  else if(width == "full") arabicn <- arabicn_full
  else if(width == "all"){
    arabicn <- c(arabicn_half, arabicn_full)
    kansuji <- c(kansuji, kansuji)
  }

  names(kansuji) <- arabicn

  stringr::str_replace_all(str, kansuji)

}

#'
arabic2kansuji_cal <- function(num, ...){
  if(length(num) > 1) stop("only one number can convert to kansuji. use `arabic2kansuji_cal` to convert to over 2 numbers.")
  if(!is.numeric(num)){
    warning("only number can convert to kansuji.")
    return(NA)
  }
  if(is.na(num) || is.nan(num) || is.infinite(num) || is.null(num)){
    warning("only number can convert to kansuji.")
    return(NA)
  }

  negative <- 0
  if(num < 0){
    negative <- 1
    num <- abs(num)
  }

  num.str <- prettyNum(num, scientific = FALSE)

  n <- purrr::reduce(stringr::str_split(num.str,
                                        stringr::boundary(type = "character")),
                     c)
  n <- suppressWarnings(as.numeric(n))

  if(length(stats::na.omit(n)) == 1 && stats::na.omit(n) == 0) return(arabic2kansuji(stats::na.omit(n), ...))

  if(any(num >= 1e+17 && num < 1e+20)){
    warning("too long number to convert exactly.")
  }else if(num >= 1e+20){
    warning("too large number to convert.")
    return(NA)
  }

  m <- max(which(n >= 0)) - which(n >= 0) + 1
  names(n) <- m

  for(i in 1:length(n)){
    if(as.numeric(names(n[i])) %% 4 == 1){
      if(n[i] >= 1) n[i] <- arabic2kansuji(n[i])
    }
    else if(as.numeric(names(n[i])) %% 4 == 2){
      if(n[i] >= 2) n[i] <- paste0(arabic2kansuji(n[i]), "\u5341")
      else if(n[i] == 1) n[i] <- "\u5341"
    }
    else if(as.numeric(names(n[i])) %% 4 == 3){
      if(n[i] >= 2) n[i] <- paste0(arabic2kansuji(n[i]), "\u767e")
      else if(n[i] == 1) n[i] <- "\u767e"
    }
    else if(as.numeric(names(n[i])) %% 4 == 0){
      if(n[i] >= 2) n[i] <- paste0(arabic2kansuji(n[i]), "\u5343")
      else if(n[i] == 1) n[i] <- "\u5343"
    }
  }

  if(length(n) >= 5){
    if(length(n) >= 9) l <- length(n) - 7
    else l <- 1
    for(i in (length(n) - 4):l){
      if(n[i] != 0){
        n[i] <- paste0(n[i], "\u4e07")
        break
      }
    }
  }
  if(length(n) >= 9){
    if(length(n) >= 13) l <- length(n) - 11
    else l <- 1
    for(i in (length(n) - 8):l){
      if(n[i] != 0){
        n[i] <- paste0(n[i], "\u5104")
        break
      }
    }
  }
  if(length(n) >= 13){
    if(length(n) >= 17) l <- length(n) - 15
    else l <- 1
    for(i in (length(n) - 12):l){
      if(n[i] != 0){
        n[i] <- paste0(n[i], "\u5146")
        break
      }
    }
  }
  if(length(n) >= 17){
    if(length(n) >= 21) l <- length(n) - 19
    else l <- 1
    for(i in (length(n) - 16):l){
      if(n[i] != 0){
        n[i] <- paste0(n[i], "\u4eac")
        break
      }
    }
  }

  n <- gsub("0", NA, n)
  if(negative == 1) n <- c("\u8ca0", n)
  stringr::str_flatten(stats::na.omit(n))

}

#' @param num Input only number. Accept more than one number.
#' @rdname arabic2kansuji
#' @export
#'
arabic2kansuji_num <- function(num, ...){

  purrr::map_chr(num, arabic2kansuji_cal, ...)
}

#'
arabic2kansuji_all_num <- function(str, widths = c("half", "all"), ...){
  widths <- match.arg(widths)

  str_row <- str
  if(widths == "all"){
    arabicn_half <- "1234567890"
    arabicn_full <- "\uff11\uff12\uff13\uff14\uff15\uff16\uff17\uff18\uff19\uff10"

    arabicn_half <- unlist(stringr::str_split(arabicn_half, ""))
    arabicn_full <- unlist(stringr::str_split(arabicn_full, ""))

    names(arabicn_half) <- arabicn_full

    str <- stringr::str_replace_all(str, arabicn_half)
  }

  str_num <- stringr::str_split(str, pattern = "[^0123456789]")[[1]]
  str_num[str_num == ""] <- NA
  str_num <- stats::na.omit(str_num)
  str_kansuji <- arabic2kansuji_num(as.numeric(str_num), ...)

  if(length(str_num) == 0) return(str_row)

  for(i in 1:length(str_num)){
    str <- stringr::str_replace(str, pattern = str_num[i], replacement = str_kansuji[i])
  }

  return(str)
}

#' @param widths Selects whether you want to convert Arabic numbers, only
#'               half-width numbers ("half") or both half-width and
#'               full-width numbers ("all") when converting Arabic numbers to
#'               kansuji.
#' @param ...    Other arguments to carry over to `arabic2kansuji()`.
#' @rdname arabic2kansuji
#' @export
#'
arabic2kansuji_all <- function(str, widths = c("half", "all"), ...){
  widths <- match.arg(widths)
  purrr::map2_chr(str, widths, arabic2kansuji_all_num, ...)
}
