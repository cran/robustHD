% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nci60.R
\docType{data}
\name{nci60}
\alias{nci60}
\alias{protein}
\alias{gene}
\alias{proteinInfo}
\alias{geneInfo}
\alias{cellLineInfo}
\title{NCI-60 cancer cell panel}
\format{
Protein and gene expression data on 59 observations are stored in two
separate matrices:
\describe{
  \item{\code{protein}}{a matrix containing protein expressions based on
  antibodies (162 columns), acquired via reverse-phase protein lysate
  arrays and log2 transformed.}
  \item{\code{gene}}{a matrix containing gene expression data (22283
  columns), obtained with an Affymetrix HG-U133A chip and normalized
  with the GCRMA method.}
}
In addition, meta information on the proteins, genes, and cancer cell lines
is stored in three separate data frames:
\describe{
  \item{\code{proteinInfo}}{a data frame with 162 rows and the following 4
  columns: \code{Experiment} (the name of the experiment for collecting
  the data), \code{Probe} (the name of the individual probe), \code{Symbol}
  (the symbol of the protein in Human Genome Organisation (HUGO)
  nomenclature), and \code{ID} (identifier of the protein per the National
  Center for Biotechnology Information (NCBI) Entrez database).  The rows of
  this data frame correspond to the columns of the matrix \code{protein}.}
  \item{\code{geneInfo}}{a data frame with 22283 rows and the following 4
  columns: \code{Experiment} (the name of the experiment for collecting
  the data), \code{Probe} (the name of the individual probe), \code{Symbol}
  (the symbol of the gene in Human Genome Organisation (HUGO) nomenclature),
  and \code{ID} (identifier of the gene per the National Center for
  Biotechnology Information (NCBI) Entrez database).  The rows of this
  data frame correspond to the columns of the matrix \code{gene}.}
  \item{\code{cellLineInfo}}{a data frame with 59 rows and 15 columns
  containing various information on the cancer cell lines, such as tissue of
  origin and histology, or age and sex of the patient. The rows of this data
  frame correspond to the rows of the matrices \code{protein} and
  \code{gene}.}
}
}
\source{
The original data were downloaded from
\url{https://discover.nci.nih.gov/cellminer/} on 2012-01-27.

The exact version of the data used in Alfons, Croux & Gelper (2013) can be
obtained from \url{https://github.com/aalfons/nci60}, together with the
script for pre-processing.  The data in package \pkg{robustHD} differ in
that the matrix of the gene expressions is called \code{gene} and that they
include the three data frames with meta information on proteins, genes, and
cancer cell lines.
}
\usage{
data("nci60")
}
\description{
The data set is a pre-processed version of the NCI-60 cancer cell panel as
used in Alfons, Croux & Gelper (2013).  One observation was removed since
all values in the gene expression data were missing.
}
\examples{
\donttest{
# load data
data("nci60")
# define response variable
y <- protein[, 92]
# screen most correlated predictor variables
correlations <- apply(gene, 2, corHuber, y)
keep <- partialOrder(abs(correlations), 100, decreasing = TRUE)
X <- gene[, keep]
}
}
\references{
Reinhold, W.C., Sunshine, M., Liu, H., Varma, S., Kohn, K.W., Morris, J.,
Doroshow, J. and Pommier, Y. (2012) CellMiner: A Web-Based Suite of Genomic
and Pharmacologic Tools to Explore Transcript and Drug Patterns in the
NCI-60 Cell Line Set. \emph{Cancer Research}, \bold{72}(14), 3499--3511.
\doi{10.1158/0008-5472.CAN-12-1370}

Alfons, A., Croux, C. and Gelper, S. (2013) Sparse least trimmed squares
regression for analyzing high-dimensional large data sets. \emph{The Annals
of Applied Statistics}, \bold{7}(1), 226--248. \doi{10.1214/12-AOAS575}
}
