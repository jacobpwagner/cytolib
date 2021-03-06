# Copyright 2019 Fred Hutchinson Cancer Research Center
# See the included LICENSE file for details on the licence that is granted to the user of this software.
dllInfo <- NULL

.onLoad <- function(libname, pkgname) {
   
   # load cytolib and cytolibmalloc on supported platforms   
   cytolib <- cytolibLibPath()
   if (!is.null(cytolib)&& Sys.info()['sysname'] != "Windows") {
      if (!file.exists(cytolib)) {
         warning(paste("cytolib library", cytolib, "not found."))
      } else {
         dllInfo <<- dyn.load(cytolib, local = FALSE, now = TRUE)
      }
   }
  
   
   # load the package library
   # library.dynam("cytolib", pkgname, libname)
   
}

.onUnload <- function(libpath) {
   
   # unload the package library
   # library.dynam.unload("cytolib", libpath)
   
   # unload dll if we loaded it
   if (!is.null(dllInfo))
      dyn.unload(dllInfo[["path"]])
}
