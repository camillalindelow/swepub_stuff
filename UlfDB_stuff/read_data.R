# CHL 181026
#skript to prepare tibbles

#läs in de nya tsv-filerna till dfs:
swepub.datafiles <- list.files(DIRS, pattern = "*.tsv", full.names=TRUE,
                               recursive = FALSE, include.dirs = FALSE)

for(i in 1:length(swepub.datafiles))  {
  x <- str_extract(swepub.datafiles[i], "/swepub_[a-zA-Z]+")
  x <- str_sub(x, 2)
  assign(x, read_tsv(swepub.datafiles[i]))
}

swepub_publs_enriched <- left_join(swepub_publications, swepub_publication, by = "publication_type_code")
swepub_publs_enriched <- left_join(swepub_publs_enriched, swepub_output, by = "output_type_code")
swepub_publs_enriched <- left_join(swepub_publs_enriched, swepub_content, by = "content_type_code")
