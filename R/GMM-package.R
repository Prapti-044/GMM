#' @import "mvtnorm"
#' @importFrom "stats" "dnorm" "runif"
NULL

#'
#' GMM: A package for applying Gaussian Mixture Model clustering algorithm
#'
#' The GMM package provides the following function:
#' apply.GMM
#'
#' @docType package
#' @name GMM
NULL
#> NULL

#' Applies GMM algorithm to the given data data.matrix
#'
#' \code{apply.GMM} returns the log likelihood from the cluster to the observations. It also provides the labels/classifications of each points.
#'
#' @param data.matrix Dataset of type matrix (List of double) and shape (n x d), where n is the number of observations and d is the dimension of the dataset.
#' @param K The number of Gaussian mixtures.
#' @return A class where "loglik" is the log likelihood, and "K" is the number of gaussian mixtures
#'
#'   For description of how GMM clustering algorithm works, please see the following url.
#'   \url{https://en.wikipedia.org/wiki/Mixture_model#Gaussian_mixture_model}
#' @examples
#' apply.GMM(as.matrix(iris[,-5]), 3)
#'
#' @export
apply.GMM <-  function(data.matrix, K) {
  rand.mat <- matrix(
    runif(nrow(data.matrix)*K),
    nrow=nrow(data.matrix),
    ncol=K)
  prob.mat <- rand.mat/rowSums(rand.mat)
  cluster.param.list <- list()
  for(cluster in 1:K){
    prob.vec <- prob.mat[, cluster]
    mean.vec <- colSums(data.matrix * prob.vec)/sum(prob.vec)
    mean.mat <- matrix(
      mean.vec, nrow(data.matrix), ncol(data.matrix), byrow=TRUE)
    diff.mat <- data.matrix - mean.mat
    diff.mat[1,] %*% t(diff.mat[1,])
    unconstrained.cov.mat <-
      t(diff.mat) %*% (diff.mat*prob.vec) / sum(prob.vec)
    constrained.cov.mat <- diag(diag(unconstrained.cov.mat))
    colSums(diff.mat^2 * prob.vec)/sum(prob.vec)
    this.cluster.params <- list(
      prior.weight=mean(prob.vec),
      mean.vec=mean.vec,
      cov.mat=constrained.cov.mat)
    cluster.param.list[[cluster]] <- this.cluster.params
  }
  density.mat <- matrix(NA, nrow(data.matrix), K)
  dnorm.mat <- matrix(NA, nrow(data.matrix), K)
  for(cluster in 1:K){
    params <- cluster.param.list[[cluster]]
    density.mat[,cluster] <- mvtnorm::dmvnorm(
      data.matrix, params$mean.vec, params$cov.mat
    )*params$prior.weight
    mean.mat <- matrix(
      params$mean.vec, nrow(data.matrix), ncol(data.matrix),
      byrow=TRUE)
    sd.mat <- matrix(
      sqrt(diag(params$cov.mat)), nrow(data.matrix), ncol(data.matrix),
      byrow=TRUE)

    dnorm.mat[,cluster] <-
      apply(dnorm(data.matrix, mean.mat, sd.mat), 1, prod)*params$prior.weight
    with(cluster.param.list[[cluster]], mvtnorm::dmvnorm(
      data.matrix, mean.vec, cov.mat)*prior.weight)
  }
  total.density.vec <- rowSums(density.mat)
  prob.mat <- density.mat/total.density.vec

  result <- list(loglik=sum(log(total.density.vec)), classification=max.col(prob.mat))
  class(result) <- append(class(result),"result")
  return(result)
}
