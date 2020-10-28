# Function to work with './Data/data.csv' table
# Description:
#  Zone = Zone d'étude entre fluvial et marine.
#         1: Fluvial
#         2: Marine
#         3: Fluvial & marine
#
#  Communication = Statut de la communication
#                  0: Inconnu
#                  1: À déterminer
#                  2: Contacter
#                  3: Contact établi

# Data:
#   dat <- read.table('./Data/data.csv', sep = '\t', header = TRUE, stringsAsFactors = FALSE, quote = "\"")
#   accr <- read.table('./Data/accronymes.csv', sep = '\t', header = TRUE, stringsAsFactors = FALSE, quote = "\"")
#   contact <- read.table('./Data/contacts.csv', sep = '\t', header = TRUE, stringsAsFactors = FALSE, quote = "\"")
#   comp <- read.table('./Data/composantes.csv', sep = '\t', header = TRUE, stringsAsFactors = FALSE, quote = "\"")


# Portrait data
RenderPortrait <- function(type, caption) {
 library(magrittr)
 library(tidyverse)
 library(kableExtra)
 comp <- read.table('./Data/composantes.csv', sep = '\t', header = TRUE, stringsAsFactors = FALSE, quote = "\"")
 options(knitr.kable.NA = '')

 # Table
 comp %>%
 filter(Composante == type) %>%
 select(Categorie, SousCategorie) %>%
 kbl(caption = caption, row.names = FALSE, col.names = c('Catégorie','Sous-catégorie')) %>%
 kable_paper(full_width = F) %>%
 collapse_rows(valign = "top")
}
# RenderPortrait('Stresseurs', 'Liste des stresseurs')
# RenderPortrait('CV', 'Liste des stresseurs')


# Datasets identified
RenderData <- function(type) {
  library(magrittr)
  library(tidyverse)
  library(kableExtra)
  dat <- read.table('./Data/data.csv', sep = '\t', header = TRUE, stringsAsFactors = FALSE, quote = "\"")
  options(knitr.kable.NA = '')

  # Table
  dat %>%
  filter(Categorie == type) %>%
  select(Categorie, SousCategorie, Organisation, Contact, Communication, Commentaire) %>%
  arrange(SousCategorie, Communication) %>%
  kbl(caption = 'Données identifiées. Communication : statut de la communication (0 : Inconnu; 1 : À déterminer; 2 : Contacter; 3 : Contact établi)',
      row.names = FALSE, col.names = c('Catégorie','Sous-catégorie','Organisation','Contact','Communication','Commentaires')) %>%
  kable_paper(full_width = F) %>%
  collapse_rows(valign = "top", columns = 1)
 }
 # RenderPortrait('Stresseurs', 'Liste des stresseurs')
 # RenderPortrait('CV', 'Liste des stresseurs')


# Contacts
RenderContactsData <- function() {
  library(magrittr)
  library(tidyverse)
  library(kableExtra)
  dat <- read.table('./Data/data.csv', sep = '\t', header = TRUE, stringsAsFactors = FALSE, quote = "\"")
  contact <- read.table('./Data/contacts.csv', sep = '\t', header = TRUE, stringsAsFactors = FALSE, quote = "\"")
  options(knitr.kable.NA = '')


  dat %>%
  arrange(Organisation, Contact, Categorie, SousCategorie, Communication) %>%
  select(Organisation, Contact, Categorie, SousCategorie, Description, Communication, Commentaire) %>%
  kbl(caption = 'Données identifiées. Communication : statut de la communication (0 : Inconnu; 1 : À déterminer; 2 : Contacter; 3 : Contact établi)',
      row.names = FALSE, col.names = c('Organisation','Contact','Catégorie','Sous-catégorie','Description','Communication','Commentaires')) %>%
  kable_paper(full_width = FALSE) %>%
  kable_styling(font_size = 8) %>%
  collapse_rows(valign = "top", columns = 1:2)
}

RenderContacts <- function() {
  library(magrittr)
  library(tidyverse)
  library(kableExtra)
  dat <- read.table('./Data/data.csv', sep = '\t', header = TRUE, stringsAsFactors = FALSE, quote = "\"")
  contact <- read.table('./Data/contacts.csv', sep = '\t', header = TRUE, stringsAsFactors = FALSE, quote = "\"")
  options(knitr.kable.NA = '')


  contact %>%
  select(Organisation, Contact, Phone, Email, Web) %>%
  arrange(Organisation, Contact) %>%
  kbl(caption = 'Données identifiées. Communication : statut de la communication (0 : Inconnu; 1 : À déterminer; 2 : Contacter; 3 : Contact établi)',
      row.names = FALSE, col.names = c('Organisation','Contact','Téléphone','Courriel','URL')) %>%
  kable_paper(full_width = F) %>%
  kable_styling(font_size = 12) %>%
  collapse_rows(valign = "top", columns = 1:2)
}
