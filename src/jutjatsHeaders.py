# -*- coding: utf-8 -*-
import sys

def jutjatsHeaders(nomFitxer):
	# adició de la capçalera del fitxer de jutjats
	newLine="LINK PROVINCIA;PARTIT JUDICIAL;DESCRIPCIO PARTIT JUDICIAL;LINK PARTIT JUDICIAL;JUTJAT;LINK JUTJAT;ADRECA JUTJAT;CP JUTJAT;POBLACIO JUTJAT;PROVINCIA JUTJAT\n"
	newLine=newLine.encode(sys.stdout.encoding, errors='replace')

	with open(nomFitxer, "ab") as myfile:
		myfile.write(newLine)
		myfile.close()
