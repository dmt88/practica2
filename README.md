# Pràctica 2: _Neteja i validació de dades_
Tipologia i cicle de vida de les dades - Pràctica 2

## Descripció

Aquesta pràctica s'ha realitzat sota el context de l'assignatura Tipologia i cicle de vida de les dades, pertanyent al Màster de Ciència de Dades de la UOC - Universitat Oberta de Catalunya. S'elabora un cas pràctic on s'han utilitzat les eines d'integració, neteja, validació i anàlisi de les mateixes.

El conjunt de dades sobre el que s'ha treballat és una mostra de les transaccions realitzades en una tenda minorista. La tenda vol conèixer millor el comportament de compra del client enfront a diferents productes. Específicament, és tracta d’un problema de regressió, al que es vol predir la variable dependent, l’import de la compra, amb ajuda de la informació continguda a la resta de variables.
També es podria realitzar una anàlisi de classificació, ja que les variables són categòriques. Alguns enfocaments podrien ser predir l’edat del consumidor o, inclús, predir la categoria dels béns comprats. El conjunt de dades també és particularment convenient per agrupar i, potser, trobar diferents grups de consumidors dintre d’ell.

## Membres de l'equip

L'activitat ha estat realitzada de manera individual per **David Martin Tinaquero**.

## Fitxers del codi font

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

## Recursos
1. Megan Squire (2015). Clean Data. Packt Publishing Ltd.
2. Jiawei Han, Micheine Kamber, Jian Pei (2012). Data mining: concepts and techniques. Morgan Kaufmann.
3. Jason W. Osborne (2010). Data Cleaning Basics: Best Practices in Dealing with Extreme Scores. Newborn and Infant Nursing Reviews; 10 (1): pp. 1527-3369.
4. Peter Dalgaard (2008). Introductory statistics with R. Springer Science & Business Media.
5. Wes McKinney (2012). Python for Data Analysis. O’Reilley Media, Inc.
