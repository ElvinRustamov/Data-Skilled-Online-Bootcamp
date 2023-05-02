library(tidyverse)


#1. "sözlər <- stringr::words; cümlələr <- stringr::sentences" kodunu icra et. "sözlər"dəki sözləri vergüllə birbirinə yapışdır.
sözlər <- stringr::words
cümlələr <- stringr::sentences

sözlər %>% str_c(collapse = ",")


#2. "cümlələr"də max character olan cümlənin characterlərinin sayını göstər.
cümlələr %>% str_length() %>% max()


#3. "cümlələr"də max characteri olan cümləni göstər.
cümlələr[which.max(str_length(cümlələr))]


#4. "sözlər"də neçə sözün ilk hərfi "a"dır.
sözlər %>% str_count("^a") %>% sum()


#5. "cümlələr"də bütün boşluqları "-" işarəsi ilə əvəzlə.
cümlələr %>% str_replace_all(" ", "-")


#6. "sözlər"də tərkibində "at" olan sözləri göstər.
sözlər[sözlər %>% str_detect("at")]

