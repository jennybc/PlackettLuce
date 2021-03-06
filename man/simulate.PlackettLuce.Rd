% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simulate.R
\name{simulate.PlackettLuce}
\alias{simulate.PlackettLuce}
\title{Simulate from \code{PlackettLuce} fitted objects}
\usage{
\method{simulate}{PlackettLuce}(
  object,
  nsim = 1L,
  seed = NULL,
  multinomial = FALSE,
  max_combinations = 20000,
  ...
)
}
\arguments{
\item{object}{an object representing a fitted model.}

\item{nsim}{number of response vectors to simulate.  Defaults to \code{1}.}

\item{seed}{an object specifying if and how the random number
generator should be initialised. Either \code{NULL} or an
integer that will be used in a call to \code{set.seed} before
simulating the rankings. If set, the value is saved as the
\code{seed} attribute of the returned value.  The default,
\code{NULL}, will not change the random generator state, and
return \code{.Random.seed} as the \code{seed} attribute.}

\item{multinomial}{use multinomial sampling anyway? Default is
\code{FALSE}. see Details.}

\item{max_combinations}{a positive number. Default is
\code{20000}. See Details.}

\item{...}{additional optional arguments.}
}
\value{
A \code{data.frame} of \code{\link{rankings}} objects of the same
dimension as \code{object$rankings}.
}
\description{
Simulate from \code{PlackettLuce} fitted objects
}
\details{
If \code{multinomial} is \code{FALSE} (default) and there are no
tie parameters in the object (i.e. \code{length(object$ties) == 1}),
then rankings are sampled by ordering exponential random variates
with rate 1 scaled by the estimated item-worth parameters
\code{object$coefficients} (see, Diaconis, 1988, Chapter 9D for
details).

In all other cases, the current implementation uses direct
multinomial sampling, and will throw an error if there are more
than \code{max_combinations} combinations of items that the sampler
has to decide from. This is a hard-coded exit to prevent issues
relating to the creation of massive objects in memory.

If \code{length(object$ties) > 1} the user's setting for
\code{multinomial} is ignored and \code{simulate.PlackettLuce} operates as if
\code{multinomial} is \code{TRUE}.
}
\examples{
R <- matrix(c(1, 2, 0, 0,
              4, 1, 2, 3,
              2, 1, 1, 1,
              1, 2, 3, 0,
              2, 1, 1, 0,
              1, 0, 3, 2), nrow = 6, byrow = TRUE)
colnames(R) <- c("apple", "banana", "orange", "pear")
mod <- PlackettLuce(R)
simulate(mod, 5)

s1 <- simulate(mod, 3, seed = 112)
s2 <- simulate(mod, 2, seed = 112)

identical(s1[1:2], s2[1:2])

}
\references{
Diaconis (1988). \emph{Group Representations in Probability and
Statistics}. Institute of Mathematical Statistics Lecture Notes
11. Hayward, CA.
}
