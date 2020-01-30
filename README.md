# seminario_ITBA
Archivos de la entrega del seminario

# Instrucciones:

1. Descargar los archivos del git.

2. Descargar los archivos con las bases de datos de PISA 2012, 2015 y 2018 de los siguientes links. Guardarlos en la misma carpeta que el resto de los archivos del git. Los archivos 2015 y 2018 descomprimirlos.
  - PISA 2012: https://drive.google.com/open?id=0B6bsnORy_Ii_XzNicDF6ajlXejg
  - PISA 2015A (base general): https://webfs.oecd.org/pisa/PUF_SPSS_COMBINED_CMB_STU_QQQ.zip
  - PISA 2015B (base de paises no incluidos en la general): https://webfs.oecd.org/pisa/PUF_SPSS_COMBINED_CM2_STU_QQQ_COG_QTM_SCH_TCH.zip
  - PISA 2018: https://webfs.oecd.org/pisa2018/SPSS_STU_QQQ.zip

3. Abrir y ejecutar el script de R "lectura_datos_PISA.R". Instalar las librerias que se requieran (data.table, foreign y openxlsx).
El script va a leer los archivos .sav (SPSS), seleccionar algunas variables y armar archivos .csv de cada ciclo para cargar en Postgres.

4. Copiar los archivos .csv a la carpeta de Jupyter Notebooks del entorno Spark, junto con el archivo "Script PISA Python.ipynb". Correr el script. Va a leer los archivos y cargarlos en la base de datos de Postgres. Si en la carpeta hay otros archivos .csv, guardar todo en una subcarpeta. El script y los CSV deben estar juntos.

