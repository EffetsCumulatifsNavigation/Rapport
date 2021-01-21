# =~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~= #
# Get study area
dataURL <- c('https://github.com/EffetsCumulatifsNavigation/ZoneEtude/raw/main/Data/StudyArea/StudyArea.zip')

# Files names
fileName <- c('./Data/StudyArea/StudyArea.zip')

# Download file
download.file(dataURL, destfile = fileName)

# Unzip
unzip(zipfile = fileName, exdir = './Data/StudyArea/')

# Move files
fold <- './Data/StudyArea/Data/StudyArea/'
fileNames <- dir(fold)
for(i in fileNames) file.rename(paste0(fold, i), paste0('./Data/StudyArea/',i))

# Remove folders
unlink('./Data/StudyArea/Data/', recursive = TRUE)
# =~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~=~-~= #
