\name{dup}
\alias{dup.vanilla}
\alias{dup.bigmemory}

\title{Deep-Copy} 

\description{ Functions to perform deep copies of
matrices.} 

\usage{ 
   dup.vanilla(mat) 
   dup.bigmemory(mat)
} 
   
\arguments{
   \item{mat}{matrix to be copied.} 
} 

\value{The matrix copy.} 
   
\details{One of the arugments to \code{\link{matpow}} is \code{dup}, a
function to do deep copying of the type of matrix being used.  The user
may supply a custom one, or use either \code{dup.vanilla} or
\code{dup.bigmemory.}
}

