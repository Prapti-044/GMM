test_that("Output shapes are correct", {
  K.list <- 3:5
  for(K in K.list) {
    result <- apply.GMM(as.matrix(iris[,-5]), K)

    expect_type(result[["loglik"]], "double")
    expect_equal(length(result[["classification"]]),length(as.matrix(iris[,-5]))/ncol(iris[,-5]))
  }
})

test_that("The clustering algorithm is working", {
  set.seed(1)
  result <- apply.GMM(as.matrix(iris[,-5]), 3)

  expect_lte(result[["loglik"]],-700)
})
