\name{genmulcmd}
\alias{genmulcmd.vanilla}
\alias{genmulcmd.bigmemory}

\title{Generate Multiplication Command} 

\description{ Functions to form quoted multiplication commands. } 

\usage{ 
   genmulcmd.vanilla(a,b,c) 
   genmulcmd.bigmemory(a,b,c) 
} 

\arguments{
   \item{a}{a quoted string.} 
   \item{b}{a quoted string.} 
   \item{c}{a quoted string.} 

} 

\value{A quoted string for c = a * b for the given type of
matrix/multiplication.} 
   
\details{One of the arugments to \code{\link{matpow}} is
\code{genmulcmd}, a function to generate a string containing the command
the multiply matrices.  The string is fed into \code{parse} and
\code{eval} for execution.  The user may supply a custom function, 
or use either \code{genmulcmd.vanilla} or
\code{genmulcmd.bigmemory.}
}

