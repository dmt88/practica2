# Pràctica 2: _Neteja i validació de dades_
Tipologia i cicle de vida de les dades - Pràctica 2

## Descripció

Aquesta pràctica s'ha realitzat sota el context de l'assignatura Tipologia i cicle de vida de les dades, pertanyent al Màster de Ciència de Dades de la UOC - Universitat Oberta de Catalunya. S'ha elaborat un cas pràctic on s'han utilitzat les eines d'integració, neteja, validació i anàlisi de dades.

El conjunt de dades sobre el que s'ha treballat és una mostra de les transaccions realitzades en una tenda minorista. La tenda vol conèixer millor el comportament de compra del client enfront a diferents productes. Específicament, és tracta d’un problema de regressió, al que es vol predir la variable dependent, l’import de la compra, amb ajuda de la informació continguda a la resta de variables.

També es podria realitzar una anàlisi de classificació, ja que les variables són categòriques. Alguns enfocaments podrien ser predir l’edat del consumidor o, inclús, predir la categoria dels béns comprats. El conjunt de dades també és particularment convenient per agrupar i, potser, trobar diferents grups de consumidors dintre d’ell.


## Membres de l'equip

L'activitat ha estat realitzada de manera individual per **David Martin Tinaquero**.

## Fitxer amb les respostes a la pràctica

* **pdf/respostes.pdf

## Fitxer amb codi font

* **src/blackFriday.R**: fitxer que conté el codi font en llenguatge R.

## _Dataset_

* **BlackFriday.csv**: conté les dades del _dataset_ original.
* **BlackFridayCleaned.zip**: conté les dades finals analitzades. 

## Llibreries necessàries:
```
library(dplyr)
library(ggplot2)
library(moments)
library(nortest)
library(car)
library(C50)

```

## Conclusions

Als apartats anteriors s’han realitzat diferents proves estadístiques sobre un conjunt de dades que es correspon amb les transaccions de les compres d’una tenda minorista, amb diferents variables categòriques que fan referència a l’usuari (comprador) i les variables que indiquen les categories a les quals pertanyen els productes de les compres.

L’anàlisi de la normalitat ha retornat que la variable dependent (Purchase) no té una distribució normal. Els contrasts d’hipòtesis també han mostrat que no existeix cap camp que tingui una relació forta amb el preu de la compra, i que el que més influència té són els que indiquen les categories dels productes comprats.

Degut a la poca correlació que existeix entre les variables categòriques i la variable dependent, els models de regressió lineals que s’han provat per realitzar prediccions, han resultat bastant dolents. Només tenen un percentatge d’encert mig acceptable (~64%) si s’utilitza com a regressor la variable que conté les combinacions de les categories dels productes.

D’altra banda, també s’ha intentat trobar el perfil dels usuaris a partir de les categories a les que pertanyen els productes comprats. Tal i com ha passat amb els models de regressió, els resultats obtinguts no sigut gaire prometedors, ja que només s’ha aconseguit un percentatge d’encert acceptable quan s’ha utilitzat la variable Purchase.

## Recursos
1. Megan Squire (2015). Clean Data. Packt Publishing Ltd.
2. Jiawei Han, Micheine Kamber, Jian Pei (2012). Data mining: concepts and techniques. Morgan Kaufmann.
3. Jason W. Osborne (2010). Data Cleaning Basics: Best Practices in Dealing with Extreme Scores. Newborn and Infant Nursing Reviews; 10 (1): pp. 1527-3369.
4. Peter Dalgaard (2008). Introductory statistics with R. Springer Science & Business Media.
5. Wes McKinney (2012). Python for Data Analysis. O’Reilley Media, Inc.
