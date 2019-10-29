#!/usr/bin/env Rscript
if ( !require("primes") ) install.packages("primes")

primes <- primes::generate_primes(max = 2e6)

polar_to_cartesian <- function(r,t) {
  c(
    r * cos( t ),
    r * sin( t )
  )
}

get_visible_points <- function(p, lim) {
  check <- abs(p) < lim
  which(apply(check, 1, all))
}

p <- do.call("rbind", lapply(primes, function(x) polar_to_cartesian(x, x)))


png("frames/primes%05i.png", 1152L, 720L, "px")
  par(
    mai = rep(0,4L),
    bg = "#000000",
    ann = FALSE,
    cex = 0.01,
    bty = "n",
    col = "#47ffd7"
  )
  for (i in 2**(0:20)) {
    plot.new()
    lim <- i
    lims <- c(-lim, lim)
    plot.window(ylim = lims, xlim = lims, asp = 1)
    points(p[get_visible_points(p,max(abs(par("usr")))),], pch = 20L)
  }
dev.off()

system("ffmpeg -y -framerate 3 -i frames/primes%05d.png out.mp4")

