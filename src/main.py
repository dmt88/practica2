# -*- coding: utf-8 -*-
from time import time
from jutjatsHeaders import jutjatsHeaders
from procuradorsHeaders import procuradorsHeaders
from jutjatsScraper import scrapeJutjats
from procuradorScraper import scrapeProcurador
from eliminaFitxer import eliminaFitxer

fitxerJutjats = "jutjats.csv"
fitxerProcuradors = "procuradors.csv"
webJutjats = "http://demarcacion.cgpe.es/provincia.aspx?idprovincia="
webProcuradors = "https://directorio.cgpe.es/DetColegiado.aspx?Id="

# esborrat dels fitxers anteriors si existeixen
eliminaFitxer(fitxerJutjats)
eliminaFitxer(fitxerProcuradors)

# JUTJATS
# temps inicial per calcular el temps d'execució
start_time1 = time()
jutjatsHeaders(fitxerJutjats)
# cerca els jutjats a les pàgines rang introduït
print("Cercant jutjats...")
for i in range(1,53):
    scrapeJutjats(webJutjats + str(i),fitxerJutjats)

print("Fitxer de jutjats creat i finalitzat.")
# temps empleat jutjats
elapsed_time = time() - start_time1
print("Temps empleat per generar el fitxer de jutjats: %0.10f segons." % elapsed_time)

# PROCURADORS
# temps inicial per calcular el temps d'execució
start_time2 = time()
procuradorsHeaders(fitxerProcuradors)
# cerca del les pàgines dels procuradors del rang introduït
print("Cercant procuradors...")
for i in range(1,99999):
    scrapeProcurador(webProcuradors + str(i) + '&UIHJ=N',fitxerProcuradors)
print("Fitxer de procuradors creat i finalitzat.")
# temps empleat procuradors
elapsed_time = time() - start_time2
print("Temps empleat per generar el fitxer de procuradors: %0.10f segons." % elapsed_time)

# temps empleat total
elapsed_time = time() - start_time1
print("Temps empleat total: %0.10f segons." % elapsed_time)


    
