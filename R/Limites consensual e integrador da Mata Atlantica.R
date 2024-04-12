####Limites consensuais e integradores da Mata Atlânticas####
#Paper: https://revistas.ufrj.br/index.php/oa/article/view/14317
#Download filed from https://github.com/LEEClab/ATLANTIC-limits/blob/master/limites_integradores_wgs84_v1_1_0.rar
#Convert to gpkg

library(terra)

integrador <- vect("C:/Users/wever/Downloads/limites_integradores_wgs84_v1_1_0/limites_integradores_wgs84/ma_limite_integrador_muylaert_et_al_2018_wgs84.shp")
plot(integrador)
writeVector(integrador, "Data/AF_limite_integrador.gpkg")

consensual <- vect("C:/Users/wever/Downloads/limites_integradores_wgs84_v1_1_0/limites_integradores_wgs84/ma_limite_consensual_muylaert_et_al_2018_wgs84.shp")
plot(consensual)
writeVector(consensual, "Data/AF_limite_consensual.gpkg")
