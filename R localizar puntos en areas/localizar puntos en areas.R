# la pregunta: "En que zona postal esta ubicado cada cliente? 

library(sf) # para manejar los shapes/mapas coordenadas etc
library(dplyr)

# shape de zonas postales de texas (N=1748)
zonas <- st_read("texas_zips.shp")

# un mapita de log-Poblacion para ver si esto funciona :)
zonas$poblacion <- zonas$SUMBLKPOP # poblacion de la zona postal
zonas$logpob <- log(zonas$poblacion + 1) # logaritmo para mejor visualizacion
plot(zonas["logpob"])

# leer la base de clientes (n=8)
clientes <- read.csv("clientes.csv")

# cual es el sistema de coordenadas [crs] del mapa?
zonas_crs   <- st_crs(zonas) 
# poner los puntos (clientes) en el mismo sistema de coordenadas (crs) de los condados (shape)
clientes <- st_as_sf(clientes, coords = c("x_center", "y_center"), crs = zonas_crs)

# la respuesta a "En que zona postal esta ubicado cada cliente? 
# ... �apa: cual es la poblacion de la zona postal?" 
# tip: los nombres de los clientes empiezan con la misma letra de la zona
# (a prosofito! para validar)
clientes_zona <- st_join(clientes, zonas[c('PO_NAME','ZIP','poblacion')], join = st_intersects)
(clientes_zona)

# Suerte!  Atte. Edgar Munoz - 2020
