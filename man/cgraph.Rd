\name{cgraph}
\alias{cgraph}
\alias{eig}
\alias{mc}
\alias{mexp}

\title{Callback Examples}
\description{
  Callback examples for \code{\link{matpow}}.
}
\usage{
  cgraph(ev,cbinit=FALSE,mindist=FALSE)
  eig(ev,cbinit=FALSE,x=NULL,eps=1e-08)
  mc(ev,cbinit=FALSE,eps=1e-08)
  mexp(ev,cbinit=FALSE,eps=1e-08) 
}
\arguments{
  \item{ev}{R environment as in the return value of \link{matpow}.}
  \item{cbinit}{\code{\link{matpow}} will first call the callback with
     \code{cbinit} set to TRUE before iterations begin, then to FALSE
     during iterations.}
  \item{mindist}{if TRUE, the matrix of minimum intervertex distances 
  will be calculated.}
  \item{x}{initial guess for the principal eigenvector.}
  \item{eps}{convergence criterion.}
}
\value{
   Callback functions don't normally return values, but they usually do
   maintain data in the R environment \code{ev} that is eventually 
   returned by \code{\link{matpow}}, including the following components as 
   well as the application-independent ones:

\itemize{

   \item \code{cgraph}:  Graph connectedness is returned in a boolean
   component \code{connected}.  If the \code{mindist} option had been
   chosen, the \code{dists} component will show the minimum intervertex
   distances.

   \item \code{eig}:  The \code{x} component will be the principal
   eigenvector.

   \item \code{mc}:  The \code{pivec} component will be the long-run
   distribution vector.

   \item \code{mexp}:  The \code{esum} component will be the matrix
   exponential.

}
} 
   
\details{Note that these functions are not called directly.  The user
specifies the callback function (whether one of the examples here or one
written by the user) in his/her call to \code{\link{matpow}}, which
calls the callback after each iteration.

\itemize{

\item \code{cgraph}: Determines the connectivity of a
graph, and optionally the minimum intervertex distance matrix.  The
matrix \code{m} in the call to \code{\link{matpow}} should be an adjacency
matrix, 1s and 0s.

\item \code{eig}:  Calculates the principal eigenvector of the
input matrix.

\item \code{mc}: Calculates the long-run distribution vector for
an aperiodic, discrete-time Markov chain; the input matrix is the
transition matrix for the chain.

\item \code{mexp}: Calculates the exponential of the input matrix, as in
e.g. \code{expm} of the \pkg{Matrix} package.

}

In \code{cgraph}, it is recommended that \code{squaring} be set to TRUE
in calling \code{matpow}, though this cannot be done if the
\code{mindist} option is used.  Use of squaring is unconditionally
recommended for \code{eig} and \code{mc}.  Do not use squaring
with \code{mexp}.

Restrictions:  These functions are currently set up only for
ordinary R matrix multiplication or use with \code{gputools}.

}
\examples{
\dontrun{
m <- rbind(c(1,0,0,1),c(1,0,1,1),c(0,1,0,0),c(0,0,1,1))
ev <- matpow(m,callback=cgraph,mindist=T)
ev$connected  # prints TRUE
ev$dists  # prints, e.g. that min dist from 1 to 2 is 3
m <- rbind(1:2,3:4)
# allow for 1000 iterations max
ev <- matpow(m,1000,callback=eig,squaring=TRUE)
# how many iterations did we actually need?
ev$i  # only 8
ev$x  # prints eigenvec; check by calling R's eigen()
}
}
