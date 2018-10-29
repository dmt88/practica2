# -*- coding: utf-8 -*-
import os

# funció que esborra el fitxer introduït per paràmetre si existeix
def eliminaFitxer(nomFitxer):
    if os.path.exists(nomFitxer):
        try:
            os.remove(nomFitxer)
            print("Fitxer %s esborrat correctament." % nomFitxer)
        except OSError, e:
            print("Error: %s - %s." % (e.nomFitxer,e.strerror))
    else:
        print("No existeix el fitxer %s." % nomFitxer)
