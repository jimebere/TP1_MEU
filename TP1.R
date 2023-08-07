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

#Como R reconoce las variables categóricas, usé la función Summary para mostrar la frecuencia de cada categoría.
summary(palermo_belgrano_sel2)

##### Creación de variables con mutate(): Recodificación en rangos
palermo_belgrano_anios <- palermo_belgrano_sel2 %>% 
  mutate(fecha = case_when(fecha < 2022-12-30~ "2022_o_menor",
                                          fecha >= 2022-12-30~ "2023"))

### "Radiografía de los datos
install.packages("skimr")
library(skimr)
skimr::skim(palermo_belgrano_anios)