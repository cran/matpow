\name{matpow}
\alias{matpow}

\title{Matrix Powers}
\description{
  Computes matrix powers, with optional application-specific callbacks.
  Accommodates (external) parallel multiplication mechanisms.
}
\usage{
  matpow(m,k=NULL,squaring=FALSE,genmulcmd=NULL,dup=NULL,callback=NULL,...)
}
\arguments{
  \item{m}{input matrix.}
  \item{k}{desired power.  If NULL, it is expected that the
     initialization portion of the user's callback function will set
     \code{k}.}
  \item{squaring}{if TRUE, saves time by first squaring \code{m}, then
     squaring the result and so on, until a power is reached of \code{k} 
     or more.}
  \item{genmulcmd}{function to generate multiplication commands, in
     quoted string form.  For the ordinary R \code{"matrix"} class this
     is \code{function(a,b,c) paste(c," <- ",a," \%*\% ",b)}, supplied as
     \code{genmulcmd.vanilla} with the package.}
  \item{dup}{function to make a deep copy of a  matrix.}
  \item{callback}{application-specific callback function.}
  \item{...}{application-specific arguments}
}
\value{
   An R environment \code{ev}, including the following components:

   \item{prod1}{matrix, the final power.}
   \item{stop}{boolean value, indicating whether the iterations were
   stopped before the final power was to be computed.}
   \item{i}{number of the last iteration performed.}

   Application-specific data, maintained by the callback function, can
   be stored here as well.  } 
   
\details{ Multiplication is iterated until the desired power \code{k} is
   reached, with these exceptions:  (a) If \code{squaring} is TRUE,
   \code{k} may be exceeded.  (b) The callback function can set \code{stop}
   in \code{ev}, halting iterations; this is useful, for instance, if some
   convergence criterion has been reached.

   One key advantage of using \code{matpow} rather than direct iteration
   is that parallel computation can be accommodated, by specifying
   \code{genmulcmd}.  (The word "accommodated" here means the user must
   have available a mechanism for parallel computation; \code{matpow}
   itself contains no parallel code.)

   For instance, if one is using GPU with \code{gputools}, one sets
   \code{genmulcmd} to \code{genmulcmd.gputools}, which calls
   \code{gpuMatMult()} instead of the usual \code{\%*\%}.  So, one can
   switch from serial to parallel by merely changing this one argument.
   If \code{genmulcmd} is not specified, the code attempts to sense the
   proper function by inspecting \code{class(m)}, in the cases of
   classes \code{"matrix"} and \code{"big.matrix"}.  
   
   Of course, if the user's R is configured to use a parallel BLAS, such
   as OpenBLAS, this is automatically handled via the ordinary R
   \code{"matrix"} class.

   Another important advantage of \code{matpow} is the ability to write
   a callback function, which enables much flexibility.  The callback,
   if present, is called by \code{matpow} after each iteration, allowing
   application-specific operations to be applied.  For instance,
   \code{\link{cgraph}} determines the connectivity of a graph, by
   checking whether the current power has all of its entries nonzero.

   The call form is \code{callbackname(ev,init,...)} where \code{ev} is
   the R environment described above, and \code{init} must be set to
   TRUE on the first call, and FALSE afterward.

   Since some types of matrix multiplication do not allow the product to
   be in the same physical location as either multiplicand, a
   "red and black" approach is taken to the iteration process:  Storage
   space for powers in \code{ev} alternatives between \code{prod1} and
   \code{prod2}, for odd-numbered and even-numbered iterations,
   respectively.

}
\examples{
\dontrun{
m <- rbind(1:2,3:4)
ev <- matpow(m,16)
ev$prod1
# prints
#              [,1]        [,2]
# [1,] 115007491351 1.67615e+11
# [2,] 251422553235 3.66430e+11

ev$i  # prints 15
matpow(m,16,squaring=TRUE)$i  # prints 4, same prod1
}

# see further examples in the callbacks
}
