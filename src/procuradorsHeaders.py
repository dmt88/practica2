# -*- coding: utf-8 -*-
import sys

def procuradorsHeaders(nomFitxer):
	# adició de la capçalera del fitxer de procuradors
	newLine="NOM;COLEGI;ID PROCURADOR;TELEFON PROCURADOR;WEB PROCURADOR;EMAIL PROCURADOR;ADRECA;POBLACIO;PROVINCIA;TELEFON DESPATX;FAX DESPATX;LINK\n"
	newLine=newLine.encode(sys.stdout.encoding, errors='replace')
       
	with open(nomFitxer, "ab") as myfile:
		myfile.write(newLine)
		myfile.close()
