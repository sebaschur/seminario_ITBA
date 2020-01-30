library(data.table)
library(foreign)
library(openxlsx)

#Cargo archivo con años y ubicaciones de los datos a levantar
archivos=read.table(
  "archivos.txt",
  sep = "\t",
  header = TRUE,
  stringsAsFactors=FALSE
)

#Cargo listados con nombres de las variables a mantener y etiquetas a usar luego
#(las que se van a seleccionar de cada base, y los nombres definitivos a usar)
vars_sel=read.table("vars_sel.txt",header = FALSE,stringsAsFactors=FALSE)[,1]
vars_def=read.table("vars_def.txt",header = FALSE,stringsAsFactors=FALSE)[,1]
codebook_cnt=as.data.table(read.xlsx("codebook_gral.xlsx",sheet = "cnt"))
codebook_subn=as.data.table(read.xlsx("codebook_gral.xlsx",sheet = "subnation"))

#Cargo todos los datos
for(x in 1:nrow(archivos)){
  anio=archivos[x,3]
  df=as.data.table(
    read.spss(
      archivos[x,2],
      use.value.labels = FALSE,
      to.data.frame = TRUE,
      )
    )
  df[,CYC:=NULL]
  df[,CYC:=anio]
  df[,prom_read:=rowMeans(.SD),.SDcols=colnames(df)[colnames(df) %like% "PV[0-9]+READ" ]]
  df[,prom_math:=rowMeans(.SD),.SDcols=colnames(df)[colnames(df) %like% "PV[0-9]+MATH" ]]
  df[,prom_scie:=rowMeans(.SD),.SDcols=colnames(df)[colnames(df) %like% "PV[0-9]+SCIE" ]]
  cols=c(vars_sel[vars_sel %in% colnames(df)])
  df=df[,..cols]
  colnames(df)=vars_def
  assign(paste0("datos",archivos[x,1]),df)
}

#Intengro todo en una base unica, corrijo cosas, agrego etiquetas y datos adicionales
rm(df)
datos2015B=datos2015B[cnt=="ARG",]
datos2018=datos2018[cnt!="VNM",] #Quito los datos de Vietnam que están vacios respecto de los resultados.
datos_comp=rbind(datos2012,datos2015A,datos2015B,datos2018)
datos_comp[oecd==2,oecd:=0] #Corrijo valores en columna 'oecd'
datos_comp=codebook_subn[datos_comp,on="subnation"] #agrego etiquetas de 'subnation'
datos_comp=codebook_cnt[datos_comp,on="cnt"] #agrego datos referidos a los paises

#Exporto los datos archivos .csv de cada año (de otro modo es demasiado grande para cargarlo todo junto desde Python)
for(x in unique(datos_comp$cyc)){
  write.csv(datos_comp[cyc==x,],paste0("datos",x,".csv"),row.names = FALSE,fileEncoding = "UTF8")
}
