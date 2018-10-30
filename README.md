# Pràctica 1: _Web scraping_
Tipologia i cicle de vida de les dades - Pràctica 1

## Descripció

Aquesta pràctica s'ha realitzat sota el context de l'assignatura Tipologia i cicle de vida de les dades, pertanyent al Màster de Ciència de Dades de la UOC - Universitat Oberta de Catalunya. S'han aplicat tècniques de _web scraping_, mitjançant el llenguatge de programació Python, per extreure dades de la web del "_Consejo General de Procuradores de España_".

## Membres de l'equip

L'activitat ha estat realitzada de manera individual per **David Martin Tinaquero**.

## Fitxers del codi font

* **src/main.py**: punt d'entrada al programa. Inicia el procés de _scraping_.
* **src/eliminaFitxer.py**: conté la implementació de la funció _eliminaFitxer_ que s'encarrega d'esborrar el fixter introduït per paràmetere en la crida, si existeix.
* **src/jutjatsHeaders.py**: conté la implementació de la funció _jutjatsHeaders_ que s'encarrega d'afegir els noms de les capçaleres del fitxer dels jutjats.
* **src/jutjatsScraper.py**: conté la implementació de la funció _jutjatsScraper_ que s'encarrega de fer _scraping_ del web dels jutjats corresponent al codi de la província introduïda per paràmetre a la crida. [http://demarcacion.cgpe.es/provincia.aspx].
* **src/procuradorScraper.py**: conté la implementació de la funció _procuradorScraper_ que s'encarrega de fer _scraping_ del web del procurador corresponent al codi indtroduït per paràmetre.[https://directorio.cgpe.es/DetColegiado.aspx].
* **src/procuradorsHeaders.py**: onté la implementació de la funció _procuradorsHeaders_ que s'encarrega d'afegir els noms de les capçaleres del fitxer dels procuradors.

## _Dataset_

* **jutjats.csv**: conté les dades recollides el 29/10/2018, mitjançant _scraping_ de tots els jutjats d'Espanya.
* **procuradors.csv**: conté les dades recollides el dia 29/10/2018, mitjançant _scraping_ de tots els procuradors que actuen a Espanya. 

## Biblioteques necessàries:
```
pip install requests
pip install lxml
```

## Comanda d'execució:
```
python main.py 
```

# Camps que s'extreuen de jutjats

- Link província
- Partit judicial
- Descripció partit judicial
- Link partit judicial
- Jutjat
- Link jutjat
- Adreça jutjat
- CP jutjat
- Població jutjat
- Província jutjat

# Camps que s'extreuen de procuradors
- Nom
- Col·legi
- Id procurador
- Telèfon procurador
- Web procurador
- Email procurador
- Adreça
- Població
- Província
- Telèfon despatx
- Fax despatx
- Link

## Recursos
1. Subirats, L., Calvo, M. (2018). _Web Scraping_. Editorial UOC.
2. Masip, D. El llenguatge Python. Editorial UOC.
3. Lawson, R. (2015). _Web Scraping with Python. Packt Publishing Ltd. Chapter_ 2._Scraping the Data_.
