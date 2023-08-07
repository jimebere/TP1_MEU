#INSTRUMENTOS_DE_ANALISIS_URBANO_TP1

#1. Se creó un repositorio en mi cuenta personal de GitHub: jimebere/TP1_MEU, con versión de control. 

#2. Se instalaron los paquetes y librerías

install.packages("tidyverse")
library(tidyverse)

#3. Se importó la base de datos correspondiente a las Obras Registradas en la Ciudad de Buenos Aires, obtenida de la pagina: https://data.buenosaires.gob.ar/dataset/obras-registradas

obras <- obrasregistradas_acumulado 

#PREGUNTA: CUANTAS DEMOLICIONES O PERMISOS DE DEMOLICION HAY REGISTRADOS EN LOS BARRIOS DE PALERMO Y BELGRANO? CUAL ES EL PROMEDIO REGISTRADO POR AÑO EN ESOS BARRIOS?

#4.TRANSFORMACIONES

### FILTRAR
#Se filtró la información referente a obras detectadas en los barrios: Palermo y Belgrano

palermo_belgrano <- obras %>% 
  filter(barrio %in% c("PALERMO", "BELGRANO"))

### Por último chequeo la selección
unique(palermo_belgrano$barrio)

#### SELECCIÓN de columnas
#Se corroboró el nombre de cada columna y se seleccionó de la tabla solo la columna tipos de obras y nombre de barrios

colnames(palermo_belgrano)

palermo_belgrano_sel1 <- palermo_belgrano %>% 
  select(3, 5, 11)

#Se seleccionaron de esos datos, solo los registros de demolición y permiso de demolición
palermo_belgrano_sel2 <- palermo_belgrano_sel1 %>% 
  filter(tipo_obra %in% c("DEMOLICION", "PERMISO DE DEMOLICION"))

install.packages("plyr")
library(plyr)
count(palermo_belgrano_sel2, "tipo_obra")

#Aqui, tal como lo indica el resultado obtenido, podemos observar que en los barrios de Palermo y Belgrano hubo, según estos registros, 17 demoliciones y 230 permisos de demolición.


##### Cuántos por año?
library(lubridate)

palermo_belgrano_anios <- palermo_belgrano_sel2 %>%
  mutate(mes = month(fecha),
         dia = day(fecha),
         anio = year(fecha)) 
count (palermo_belgrano_anios, "anio")

#Por ultimo según el resultado arrojado, la mayoria de las demoliciones y permisos de deomilicion se dieron en el año 2022

