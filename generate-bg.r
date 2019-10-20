if ( !require("primes") ) install.packages("primes")

primes <- primes::generate_primes(max = 150000L)

polar_to_cartesian <- function(r,t) {
  c(
    r * cos( t ),
    r * sin( t )
  )
}

p <- do.call("rbind", lapply(primes, function(x) polar_to_cartesian(x, x)))

lim <- 50000L
lims <- c(-lim, lim)

png("primes-bg.png", 1920L, 1080L, "px")
  par(
    mai = rep(0,4L),
    bg = "#000000",
    ann = FALSE,
    cex = 0.01,
    bty = "n",
    col = "#47ffd7"
  )
  plot.new()
  plot.window(ylim = lims, xlim = lims, asp = 1)
  points(p, pch = 20L)
dev.off()
