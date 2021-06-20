## code to prepare `srol2021` dataset 
path <- "data-raw/srol2021.csv"
srol2021 <- read.csv(path)

cnames <- colnames(srol2021)
cnames[1] <- "id"

cnames <- gsub("negative", "neg", cnames)
cnames <- gsub("conspriacy", "conspiracy", cnames)
cnames <- gsub("comspotie", "composite", cnames)

colnames(srol2021) <- cnames

usethis::use_data(srol2021, overwrite = TRUE)
