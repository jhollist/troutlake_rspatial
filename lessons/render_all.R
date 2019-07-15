render_all<-function(path=".",pattern="*.Rmd"){
  files <- list.files(path,pattern,full.names = T)
  for(i in files){
    out <- stringr::str_replace(i,"Rmd","md")
    if(!file.exists(out)){
      rmarkdown::render(i)
    } else if((file.info(i)$mtime-file.info(out)$mtime)>0){
      rmarkdown::render(i)
    }
  }
}