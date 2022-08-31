\name{samur}
\alias{samur}
\alias{print.samur}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Stochastic Augmentation of Matched Datasets Using Restriction Methods
}
\description{
This function generates multiple subsets of the data in which the distribution of covariates is balanced across treatment groups. It works by binning the output of a base matching algorithm into a multidimensional histogram, and drawing - without replacement - from the full data set according to the histogram. This leads to higher data coverage across multiple matched subsets without duplication of cases within each subset.
}
\usage{
samur(
  formula, data
  , matched.subset = 1:nrow(data)
  , nsmp = 100
  , use.quantile = TRUE, breaks = 10
  , replace = length(unique(matched.subset)) < length(matched.subset)
  )
\method{print}{samur}(x, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{formula}{Formula expression used to describe the treatment variable (lhs) and covariates used during matching (rhs).}
  \item{data}{Data frame containing the treatment variables and matched covariates as specified in the \code{formula}.}
  \item{matched.subset}{An integer vector representing the indexes of a subset of \code{data} that is the output of a base matching algorithm. It cannot contain duplicate values.}
  \item{nsmp}{Number of stochastically matched subsets to generate.}
  \item{use.quantile}{Should numeric covariates be binned using quantiles (\code{TRUE}) or not.}
  \item{breaks}{number of breaks to use in binning numeric covariates.}
  \item{replace}{Boolean flag indicating whether or not to perform sampling with replacement.}
  \item{x}{An object of class \code{samur}, typically the output of function \code{samur}.}
  \item{...}{Arguments passed to/from other methods.}
}

\value{
An object of class \code{samur}, a matrix of size \code{length(matched.subset)} by \code{nsmp}, where each column is a matched subset wihtout case duplication. It also has the following attributes:
  \item{call}{Copy of function call.}
  \item{formula}{Formula passed to the function.}
  \item{mdg}{Multi-dimensional grid used for binning the matched data subsets.}
  \item{mdh}{Multi-dimensional histogram resulting frm binning \code{data[matched.subset, ]} according to the grid specified in \code{mdg}.}
  \item{data}{Copy of data frame passed to the function.}
}

\author{Mansour T.A. Sharabiani, Alireza S. Mahani}

\seealso{
\code{\link{summary.samur}}
}
\examples{
\dontrun{
library(SAMUR)
library(Matching)
data(lalonde)
myformula <- treat ~ age + educ
myglm <- glm(myformula, lalonde, family="binomial")
X <- myglm$fitted.values
# using M=1 and replace=F to ensure no duplication
bimatch <- Match(Tr = lalonde$treat, X = myglm$fitted.values
  , M = 1, replace = F, caliper = 0.25)
idx <- c(bimatch$index.control, bimatch$index.treated)
my.samur <- samur(formula = myformula, data = lalonde
  , matched.subset = idx, nsmp = 100
  , breaks = 10, use.quantile = TRUE)
summary(my.samur, nboots = 500)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
