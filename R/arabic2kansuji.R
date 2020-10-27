#' Convert Arabic numerals to kansuji
#' @description
#' Converts a given arabic mumerals to kansuji. `arabic2kansuji` function can
#' also convert Arabic numerals in the string to kansuji. `arabic2kansuji_num`
#' function can convert a vector of only one Arabic numerals to kansuji. Use
#' `arabic2kansuji_cal` if you want to convert one or more Arabic numerals to
#' kansuji. `arabic2kansuji_all` can calculate and convert Arabic numerals to
#' kansuji while retaining the original non-Arabic numeral string.
#' @param str Input vector.
#' @param zero Selects whether 0 should be zero like o ("rei") or zero like have
#'             rain crown ("zero") when Arabic numerals are converted to kansuji.
#' @param width Selects whether you want to convert Arabic numbers, only
#'              half-width numbers ("halfwidth") or only full-width
#'              numbers ("fullwidth") or both half-width and full-width
#'              numbers ("all") when converting Arabic numbers to kansuji.
#'
#' @rdname arabic2kansuji
#' @importFrom stringr str_split
#' @importFrom stringr str_replace_all
#' @return a character.
#' @export
#'
arabic2kansuji <- function(str,
                           zero = c("rei", "zero"),
                           width = c("halfwidth", "fullwidth", "all")){

  zero <- match.arg(zero)
  width <- match.arg(width)

  arabicn_half <- "1234567890"
  arabicn_full <- "\uff11\uff12\uff13\uff14\uff15\uff16\uff17\uff18\uff19\uff10"

  if(zero == "rei") kansuji <- "\u4e00\u4e8c\u4e09\u56db\u4e94\u516d\u4e03\u516b\u4e5d\u3007"
  else if(zero == "zero") kansuji <- "\u4e00\u4e8c\u4e09\u56db\u4e94\u516d\u4e03\u516b\u4e5d\u96f6"

  arabicn_half <- unlist(stringr::str_split(arabicn_half, ""))
  arabicn_full <- unlist(stringr::str_split(arabicn_full, ""))
  kansuji <- unlist(stringr::str_split(kansuji, ""))

  if(width == "halfwidth") arabicn <- arabicn_half
  else if(width == "fullwidth") arabicn <- arabicn_full
  else if(width == "all"){
    arabicn <- c(arabicn_half, arabicn_full)
    kansuji <- c(kansuji, kansuji)
  }

  names(kansuji) <- arabicn

  stringr::str_replace_all(str, kansuji)

}

#' @param num Input only one number.
#' @importFrom purrr reduce
#' @importFrom stringr boundary
#' @importFrom stringr str_flatten
#' @importFrom stats na.omit
#' @rdname arabic2kansuji
#' @export
#'
arabic2kansuji_num <- function(num){
  if(length(table(num)) > 1) stop( writeLines("only one number can convert to kansuji. \nuse `arabic2kansuji_cal` to convert to over 2 numbers."))
  if(!is.numeric(num)) stop("only number can convert to kansuji.")

  negative <- 0
  if(num < 0){
    negative <- 1
    num <- abs(num)
  }
  n <- purrr::reduce(stringr::str_split(num,
                                        stringr::boundary(type = "character")),
                     c)
  n <- suppressWarnings(as.numeric(n))

  if(anyNA(n)){
    if(num > 2147483647) stop("too large number and not good shape to convert.")
    num <- as.integer(num)
    n <- purrr::reduce(stringr::str_split(num,
                                          stringr::boundary(type = "character")),
                       c)
    n <- as.numeric(n)
  }

  if(length(n) >= 17) warning("too long to convert.")

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


#' @param nums Input only number. Accept more than one number.
#' @importFrom purrr map_chr
#' @rdname arabic2kansuji
#' @export
#'
arabic2kansuji_cal <- function(nums){
  unlist(purrr::map_chr(nums, arabic2kansuji_num))
}

#' @importFrom stringr str_split
#' @importFrom stringr str_detect
#' @importFrom stringr str_c
#' @importFrom stringr str_replace_all
#' @importFrom stats na.omit
#'
arabic2kansuji_all_num <- function(str, widths = c("halfwidth", "all")){
  widths <- match.arg(widths)
  if(widths == "all"){
    arabicn_half <- "1234567890"
    arabicn_full <- "\uff11\uff12\uff13\uff14\uff15\uff16\uff17\uff18\uff19\uff10"

    arabicn_half <- unlist(stringr::str_split(arabicn_half, ""))
    arabicn_full <- unlist(stringr::str_split(arabicn_full, ""))

    names(arabicn_half) <- arabicn_full

    str <- stringr::str_replace_all(str, arabicn_half)
  }

  doc_num <- stats::na.omit(as.numeric(stringr::str_split(str, pattern = "[^0123456789]")[[1]]))
  str <- stringr::str_replace_all(str, pattern = "[0123456789]", replacement = "00")
  doc_str <- stringr::str_split(str, pattern = "[0123456789]")[[1]]

  doc_num <- arabic2kansuji_cal(doc_num)

  j <- 1
  for(i in 1:length(doc_str)){
    if(!stringr::str_detect(doc_str[i], pattern = "") && i == 1){
      doc_str[i] <- doc_num[j]
      j <- j + 1
    }
    else if(stringr::str_detect(doc_str[i - 1], pattern = "[^\u4e00\u4e8c\u4e09\u56db\u4e94\u516d\u4e03\u516b\u4e5d\u5341\u767e\u5343\u4e07\u5104\u5146\u4eac]")
            && !stringr::str_detect(doc_str[i], pattern = "")){
      doc_str[i] <- doc_num[j]
      j <- j + 1
    }
    if((length(doc_num) + 1)  ==  j) break
  }
  ans <- stringr::str_c(doc_str, collapse = "")
  return(ans)
}

#' @param widths Selects whether you want to convert Arabic numbers, only
#'               half-width numbers ("halfwidth") or both half-width and
#'               full-width numbers ("all") when converting Arabic numbers to
#'               kansuji.
#' @importFrom purrr map
#' @rdname arabic2kansuji
#' @export
#'
arabic2kansuji_all <- function(str, widths = c("halfwidth", "all")){
  widths <- match.arg(widths)
  unlist(purrr::map2(str, widths, arabic2kansuji_all_num))
}
