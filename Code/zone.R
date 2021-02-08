# source('./code/stl.R')
library(slmeta)
data(egslSimple)
sa <- st_read('./Data/StudyArea/StudyArea.shp', quiet = TRUE) %>%
      st_transform(st_crs(egslSimple))

### Colors
stl    <- '#68908b'
focus  <- '#25364A'
off    <- '#C7CBCE'
border <- '#f4f4f4'
names  <- slmetaPal('platform')[8]
pal <- colorRampPalette(slmetaPal('platform'))
bg <- '#f5f5f5'

png('./Figures/stlTC.png', res = 250, width = 120, height = 150, units = "mm")
plotEGSL(layers = c('egslOutline','quebec'),
         prj        = slmetaPrj('default'),
         extent     = 'quebec',
         cols       = c(off, focus),
         borders    = border,
         lwds       = 1.25,
         mar        = c(0,0,0,0),
         box        = FALSE,
         axes       = NULL,
         background = bg,
         graticules = NULL,
         scale      = FALSE,
         northArrow = FALSE,
         prjText    = FALSE,
         prjCol     = NULL)
plot(st_geometry(sa), col = stl, border = stl, add = TRUE)
dev.off()
