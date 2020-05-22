# source('./Code/IC.R')
library(raster)
library(graphicsutils)

# random <- function(cont = TRUE) {
#   m <- secr::make.mask(nx = 100, ny = 100, spacing = 20)
#   h <- secr::randomHabitat(m, p = 0.5, A = 0.3)
#   r <- secr::raster(h)
#
#   if (cont) {
#     r <- r * rnorm(length(r), 1, .2)
#     r <- r / maxValue(r)
#     return(r)
#   }
#
#   if (!cont) {
#     return(r)
#   }
# }
#
# s <- stack(list(s1 = random(), s2 = random(), s3 = random()))
# h <- stack(list(h1 = random(F), h2 = random(F), h3 = random(F)))

cols <- c("#ffffff","#C7CBCE", "#96A3A3", "#687677", "#222D3D", "#25364A", "#C77F20", "#E69831", "#E3AF16", "#E4BE29", "#F2EA8B")
pal <- colorRampPalette(cols)
pal2 <- colorRampPalette(c('#ffffff','#306919'))
box3 <- function(side) box2(side = side, which = 'figure', lty = 2)

xBox <- c(-75,175,175,-75)
yBox <- c(2075,2075,1825,1825)
cBox <- '#ffffff'
cap <- function(caption) {
  polygon(x = xBox, y = yBox, col = cBox, border = cBox)
  text(x = 50, y = 1950, labels = caption, cex = 1.5, font = 2, adj = c(.5,.5))
}


mat <- matrix(nrow = 7, ncol = 7)
mat[1, ] <- c(0,1,2,2,2,3,0)
mat[2, ] <- c(0,17,9,10,11,12,0)
mat[3, ] <- c(4,13,18,19,20,27,8)
mat[4, ] <- c(4,14,21,22,23,28,8)
mat[5, ] <- c(4,15,24,25,26,29,8)
mat[6, ] <- c(0,16,30,31,32,33,0)
mat[7, ] <- c(0,5,6,6,6,7,0)


png('./Figures/IC.png', res = 900, width = 200, height = 200, units = "mm")

layout(mat, heights = c(.25,1,1,1,1,1,.25), widths = c(.25,1,1,1,1,1,.25))
# layout.show(max(mat))

# Titles
par(mar = c(.5,.5,.5,.5))
plot0(); text(0,0,"Aire\nd'étude", adj = c(.5,.5), font = 2)
plot0(); text(0,0,"Facteurs de stress", adj = c(.5,.5), font = 2); box3('24')
plot0(); text(0,0,"Exposition\ncumulée", adj = c(.5,.5), font = 2)
plot0(); text(0,0,"Composantes valorisées", adj = c(.5,.5), font = 2, srt = 90); box3('13')
plot0(); text(0,0,"Composantes\nvalorisées intégrées", adj = c(.5,.5), font = 2)
plot0(); text(0,0,"Impacts intégrés stresseurs", adj = c(.5,.5), font = 2); box3('24')
plot0(); text(0,0,"Impacts cumulés", adj = c(.5,.5), font = 2)
plot0(); text(0,0,"Impacts intégrés\ncomposantes valorisées", adj = c(.5,.5), font = 2, srt = 90); box3('13')


# Stressors
par(mar = c(.5,.5,.5,.5))
image(s[[1]], col = pal(100), axes = F, xlab = '', ylab = ''); box(); box3('12')
cap('B')
image(s[[2]], col = pal(100), axes = F, xlab = '', ylab = ''); box(); box3('1')
image(s[[3]], col = pal(100), axes = F, xlab = '', ylab = ''); box(); box3('14')

# Empreinte cumulée
image(sum(s, na.rm = T), col = pal(100), axes = F, xlab = '', ylab = ''); box(); box3('1')
cap('D')

# Composantes valorisées
image(h[[1]], col = '#BACDB2', axes = F, xlab = '', ylab = ''); box(); box3('34')
cap('C')
image(h[[2]], col = '#BACDB2', axes = F, xlab = '', ylab = ''); box(); box3('4')
image(h[[3]], col = '#BACDB2', axes = F, xlab = '', ylab = ''); box(); box3('14')

# Composantes valorisées intégrés
image(sum(h, na.rm = T), col = pal2(4), axes = F, xlab = '', ylab = ''); box(); box3('4')
cap('E')

# Aire d'étude
plot0(); box(); box3('1')
text(x = -.925, y = .925, labels = 'A', cex = 1.5, font = 2, adj = c(.5,.5))

# Impacts individuels
u <- matrix(nrow = 3, ncol = 3, data = runif(9, 1,2))
l <- list()
for(i in 1:3) {
  for(j in 1:3) {
    l <- c(l, s[[j]] * h[[i]] * u[i,j])
  }
}

l <- stack(l)

for(i in 1:9) {
  image(l[[i]], col = pal(100), axes = F, xlab = '', ylab = '')
  box()
  if (i == 1) cap('F')
}

# Composantes valorisées
image(sum(l[[c(1,2,3)]], na.rm = T), axes = F, col = pal(100), xlab = '', ylab = ''); box(); box3('2')
cap('G')
image(sum(l[[c(4,5,6)]], na.rm = T), axes = F, col = pal(100), xlab = '', ylab = ''); box(); box3('2')
image(sum(l[[c(7,8,9)]], na.rm = T), axes = F, col = pal(100), xlab = '', ylab = ''); box(); box3('2')


# Stresseurs
image(sum(l[[c(1,4,7)]], na.rm = T), axes = F, col = pal(100), xlab = '', ylab = ''); box(); box3('3')
cap('H')
image(sum(l[[c(2,5,8)]], na.rm = T), axes = F, col = pal(100), xlab = '', ylab = ''); box(); box3('3')
image(sum(l[[c(3,6,9)]], na.rm = T), axes = F, col = pal(100), xlab = '', ylab = ''); box(); box3('3')

# Impacts cumulés
image(sum(l, na.rm = T), axes = F, col = pal(100), xlab = '', ylab = ''); box(); box3('23')
cap('I')
dev.off()
