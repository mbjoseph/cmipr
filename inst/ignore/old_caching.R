#' Manage cached CMIP files
#'
#' @export
#' @name cmip_cache
#' @param files (character) one or more complete file names
#' @param force (logical) Should files be force deleted? Default: \code{TRUE}
#'
#' @details \code{cache_delete} only accepts 1 file name, while
#' \code{cache_delete_all} doesn't accept any names, but deletes all files.
#' For deleting many specific files,
#' use \code{cache_delete} in a \code{\link{lapply}} type call
#'
#' We cache using \code{\link[rappdirs]{user_cache_dir}}, find your
#' cache folder by executing \code{rappdirs::user_cache_dir("cmip")}
#'
#' @section Functions:
#' \itemize{
#'  \item \code{cmip_cache_list()} returns a character vector of full path file
#'  names
#'  \item \code{cmip_cache_delete()} deletes one or more files, returns nothing
#'  \item \code{cmip_cache_delete_all()} delete all files, returns nothing
#'  \item \code{cmip_cache_details()} prints file name and file size for each
#'  file, supply with one or more files, or no files (and get details for
#'  all available)
#' }
#'
#' @examples \dontrun{
#' # list files in cache
#' cmip_cache_list()
#'
#' # List info for single files
#' cmip_cache_details(files = cmip_cache_list()[1])
#' cmip_cache_details(files = cmip_cache_list()[2])
#'
#' # List info for all files
#' cmip_cache_details()
#'
#' # delete files by name in cache
#' # cmip_cache_delete(files = cmip_cache_list()[1])
#'
#' # delete all files in cache
#' # cmip_cache_delete_all()
#' }

#' @export
#' @rdname cmip_cache
cmip_cache_list <- function() {
  list.files(cmip_cache_path(), ignore.case = TRUE, include.dirs = TRUE,
             recursive = TRUE, full.names = TRUE)
}

#' @export
#' @rdname cmip_cache
cmip_cache_delete <- function(files, force = TRUE) {
  if (!all(file.exists(files))) {
    stop("These files don't exist or can't be found: \n",
         strwrap(files[!file.exists(files)], indent = 5), call. = FALSE)
  }
  unlink(files, force = force, recursive = TRUE)
}

#' @export
#' @rdname cmip_cache
cmip_cache_delete_all <- function(force = TRUE) {
  files <- list.files(cmip_cache_path(), ignore.case = TRUE,
                      include.dirs = TRUE, full.names = TRUE, recursive = TRUE)
  unlink(files, force = force, recursive = TRUE)
}

#' @export
#' @rdname cmip_cache
cmip_cache_details <- function(files = NULL) {
  if (is.null(files)) {
    files <- list.files(cmip_cache_path(), ignore.case = TRUE,
                        include.dirs = TRUE, full.names = TRUE,
                        recursive = TRUE)
    structure(lapply(files, file_info_), class = "cmip_cache_info")
  } else {
    structure(lapply(files, file_info_), class = "cmip_cache_info")
  }
}

file_info_ <- function(x) {
  if (file.exists(x)) {
    fs <- file.size(x)
  } else {
    fs <- type <- NA
    x <- paste0(x, " - does not exist")
  }
  list(file = x,
       type = "nc",
       size = if (!is.na(fs)) getsize(fs) else NA
  )
}

getsize <- function(x) {
  round(x/10 ^ 6, 3)
}

#' @export
print.cmip_cache_info <- function(x, ...) {
  cat("<cmip cached files>", sep = "\n")
  cat(sprintf("  directory: %s\n", cmip_cache_path()), sep = "\n")
  for (i in seq_along(x)) {
    cat(paste0("  file: ", sub(cmip_cache_path(), "", x[[i]]$file)), sep = "\n")
    cat(paste0("  size: ", x[[i]]$size, if (is.na(x[[i]]$size)) "" else " mb"),
        sep = "\n")
    cat("\n")
  }
}
