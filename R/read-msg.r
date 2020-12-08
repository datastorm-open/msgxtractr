#' Read in an Outlook '.msg' file
#'
#' @md
#' @param path path to '.msg' file
#' @return a `list` of extracted fields and metadata with class "`msg`"
#' @export
#' @examples
#' read_msg(system.file("extdata/unicode.msg", package="msgxtractr"))
#' read_msg(system.file("extdata/TestMessage-ansi.msg", package="msgxtractr"))
#' read_msg(system.file("extdata/TestMessage-default.msg", package="msgxtractr"))
#' read_msg(system.file("extdata/TestMessage-unicode.msg", package="msgxtractr"))
read_msg <- function(path) {

  # path <- normalizePath(path.expand(path))
  if (!file.exists(path)) stop("File not found.", call.=FALSE)

  x <- int_read_msg(path)

  names(x$values) <- x$keys

  x <- x$values

  list(
    headers = process_headers(x),
    sender = process_sender(x),
    recipients = process_recipients(x),
    subject = process_subject(x),
    body = process_body(x),
    attachments = process_attachments(x),
    display_envelope = process_envelope(x),
    times = process_times(x)
  ) -> res

  print(res)
  print(process_body(x))
  class(res) <- "msg"

  # list(
  #   orig = x,
  #   res = res
  # )

  res

}