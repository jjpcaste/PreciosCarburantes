
setwd("C:/Users/UM/UMUbox/gasolina")


# urlorigen <- "http://geoportalgasolineras.es/descargarPreciosTodasEstaciones.do"
# urlorigen <- "http://geoportalgasolineras.es/descargarPreciosTodasEstaciones.do?tipoBusqueda=0"
# download.file(urlorigen,"preciosEESS_es.xls",quiet=F,mode="wb")


#VIEJA library("XLConnect")
library("readxl")

#VIEJA hojadatos<-loadWorkbook("preciosEESS_es.xls")
muda <- read_excel(path="preciosEESS_es.xls",sheet=1,
           col_names=F,col_types=NULL,na ="",skip=1)

#VIEJA fecha<-format(as.Date(substr(readWorksheet(hojadatos,sheet=1,region="A1:B2")[1,2],1,10),
#VIEJA                       format="%d/%m/%Y"),"%y%m%d")
fecha<-format(as.Date(substr(muda[1,2],1,10),format="%d/%m/%Y"),"%y%m%d");rm(muda)


##VIEJA datn<-readWorksheet(hojadatos,sheet=1,startRow=5,header=T)
datn <- read_excel(path="preciosEESS_es.xls",sheet = 1,
                   col_names=T,col_types=NULL,na="",skip=4)
datn<-as.data.frame(datn)

file.rename("preciosEESS_es.xls",paste("datos",fecha,".xls",sep=""))


# datn<-datn[,-2]

##VIEJA for (i in 1:21){
##VIEJA         datn[datn[,i]=="",i]<-NA
##VIEJA }

for (i in 7:17){
        datn[,i]<-as.numeric(gsub(",",".",datn[,i]))
}

assign(paste("datos",fecha,sep=""),datn)
save(list=c(paste("datos",fecha,sep="")),
     file=paste("datos",fecha,".Rdata",sep=""))

rm(datn)

