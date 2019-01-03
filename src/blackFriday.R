# Llibreries
library(dplyr)
library(ggplot2)
library(moments)
library(nortest)
library(car)
library(C50)

# EXPLORACIÓ DE DADES
# Lectura de dades
blackFriday <- read.csv("BlackFriday.csv", header = TRUE)
# 6 primers registres amb les 6 primeres columnes
head(blackFriday[1:6])
# 6 darrers registres amb les 6 primeres columnes
tail(blackFriday[1:6])
# Tipus de les variables
sapply(blackFriday, function(x) class(x))
# Tipus de les variables i continguts
glimpse(blackFriday)
# Nombres de valors desconeguts per camp
sapply(blackFriday, function(x) sum(is.na(x)))
# Selecció de les dades d'interés
blackFriday <- blackFriday[, -(1:2)]


# NETEJA I TRACTAMENT DE DADES
# Substitució dels valors nuls del camp Product_Category_2 per zeros ("0")
blackFriday$Product_Category_2[is.na(blackFriday$Product_Category_2)] <- "0"
# Substitució dels valors nuls del camp Product_Category_3 per zeros ("0")
blackFriday$Product_Category_3[is.na(blackFriday$Product_Category_3)] <- "0"
# Adició del prefix "C" als codis dels camps de les categories dels productes
blackFriday$Product_Category_1 <- paste("C",blackFriday$Product_Category_1,sep="")
blackFriday$Product_Category_2 <- paste("C",blackFriday$Product_Category_2,sep="")
blackFriday$Product_Category_3 <- paste("C",blackFriday$Product_Category_3,sep="")
# Conversió dels camps de categories dels productes a tipus factor
blackFriday$Product_Category_1 <- factor(blackFriday$Product_Category_1)
blackFriday$Product_Category_2 <- factor(blackFriday$Product_Category_2)
blackFriday$Product_Category_3 <- factor(blackFriday$Product_Category_3)
# Adició del prefix "O" als codis del camp Occupation
blackFriday$Occupation <- paste("O",blackFriday$Occupation,sep="")
# Conversió del camp Occupation a tipus factor
blackFriday$Occupation <- factor(blackFriday$Occupation)
# Substitució dels valors 0 per "NO" y 1 per "SI" al camp Marital_Status
blackFriday$Marital_Status[blackFriday$Marital_Status == 0] <- "NO"
blackFriday$Marital_Status[blackFriday$Marital_Status == 1] <- "SI"
# Conversió del camp Marital_Status a tipus factor
blackFriday$Marital_Status <- factor(blackFriday$Marital_Status)
# Conversió de l'import de la compra a preu real
blackFriday$Purchase <- blackFriday$Purchase/100
# Creació de la variable Categories amb el conjunt de les categories
categories <- paste(blackFriday$Product_Category_1,
                    blackFriday$Product_Category_2,
                    blackFriday$Product_Category_3)
blackFriday$Categories <- categories
blackFriday$Categories <- factor(blackFriday$Categories)
# Exportació de les dades tractades a fitxer
blackFriday <- write.csv(write.csv(blackFriday, file = "BlackFridayCleaned.csv"))

# Valors extrems
outliers <- boxplot.stats(blackFriday$Purchase)$out
# Número de registres amb valors extrems
paste("Número de registres que contenen valors extrems al dataset: ",length(outliers))
# Valor més baix
paste("Valor extrem més baix: ",min(outliers))
# Vaor mes alt
paste("Valor extrem més alt: ",max(outliers))
# Percentatge de registres que representen els valors extrems
outliersVsTotal <- (length(outliers)/nrow(blackFriday))*100
paste("Percentatge de registres que representen els valors extrems al dataset: ",round(outliersVsTotal,3), "%")
# Eliminació dels valors extrems (outliers)
blackFriday <- filter(blackFriday,blackFriday$Purchase < min(outliers))


# ANÀLISI DE DADES
# Selecció dels grups a analitzar
# Agrupació per gènere
blackFriday.gender_male <- blackFriday[blackFriday$Gender == "M",]
blackFriday.gender_female <- blackFriday[blackFriday$Gender == "F",]

# Agrupació per rangs d'edad
blackFriday.age_0_17 <- blackFriday[blackFriday$Age == "0-17",]
blackFriday.age_18_25 <- blackFriday[blackFriday$Age == "18-25",]
blackFriday.age_26_35 <- blackFriday[blackFriday$Age == "26-35",]
blackFriday.age_36_45 <- blackFriday[blackFriday$Age == "36-45",]
blackFriday.age_46_50 <- blackFriday[blackFriday$Age == "46-50",]
blackFriday.age_51_55 <- blackFriday[blackFriday$Age == "51-55",]
blackFriday.age_55_ <- blackFriday[blackFriday$Age == "55+",]

# Agrupació per ocupació
blackFriday.ocu_O0 <- blackFriday[blackFriday$Occupation == "O0",]
blackFriday.ocu_O1 <- blackFriday[blackFriday$Occupation == "O1",]
blackFriday.ocu_O2 <- blackFriday[blackFriday$Occupation == "O2",]
blackFriday.ocu_O3 <- blackFriday[blackFriday$Occupation == "O3",]
blackFriday.ocu_O4 <- blackFriday[blackFriday$Occupation == "O4",]
blackFriday.ocu_O5 <- blackFriday[blackFriday$Occupation == "O5",]
blackFriday.ocu_O6 <- blackFriday[blackFriday$Occupation == "O6",]
blackFriday.ocu_O7 <- blackFriday[blackFriday$Occupation == "O7",]
blackFriday.ocu_O8 <- blackFriday[blackFriday$Occupation == "O8",]
blackFriday.ocu_O9 <- blackFriday[blackFriday$Occupation == "O9",]
blackFriday.ocu_O10 <- blackFriday[blackFriday$Occupation == "O10",]
blackFriday.ocu_O11 <- blackFriday[blackFriday$Occupation == "O11",]
blackFriday.ocu_O12 <- blackFriday[blackFriday$Occupation == "O12",]
blackFriday.ocu_O13 <- blackFriday[blackFriday$Occupation == "O13",]
blackFriday.ocu_O14 <- blackFriday[blackFriday$Occupation == "O14",]
blackFriday.ocu_O15 <- blackFriday[blackFriday$Occupation == "O15",]
blackFriday.ocu_O16 <- blackFriday[blackFriday$Occupation == "O16",]
blackFriday.ocu_O17 <- blackFriday[blackFriday$Occupation == "O17",]
blackFriday.ocu_O18 <- blackFriday[blackFriday$Occupation == "O18",]
blackFriday.ocu_O19 <- blackFriday[blackFriday$Occupation == "O19",]
blackFriday.ocu_O20 <- blackFriday[blackFriday$Occupation == "O20",]

# Agrupació per categoria de ciutat
blackFriday.city_cat_A <- blackFriday[blackFriday$City_Category == "A",]
blackFriday.city_cat_B <- blackFriday[blackFriday$City_Category == "B",]
blackFriday.City_cat_C <- blackFriday[blackFriday$City_Category == "C",]

# Agrupació per anys vivint a la ciutat actual
blackFriday.years_0 <- blackFriday[blackFriday$Stay_In_Current_City_Years == "0",]
blackFriday.years_1 <- blackFriday[blackFriday$Stay_In_Current_City_Years == "1",]
blackFriday.years_2 <- blackFriday[blackFriday$Stay_In_Current_City_Years == "2",]
blackFriday.years_3 <- blackFriday[blackFriday$Stay_In_Current_City_Years == "3",]
blackFriday.years_4_ <- blackFriday[blackFriday$Stay_In_Current_City_Years == "4+",]

# Agrupació per estat civil
blackFriday.marital_SI <- blackFriday[blackFriday$Marital_Status == "SI",]
blackFriday.marital_NO <- blackFriday[blackFriday$Marital_Status == "NO",]

# Agrupació per categories
blackFriday.prod_cat_C0 <- blackFriday[blackFriday$Product_Category_1 == "C0" |
                                         blackFriday$Product_Category_2 == "C0" |
                                         blackFriday$Product_Category_3 == "C0",]
blackFriday.prod_cat_C1 <- blackFriday[blackFriday$Product_Category_1 == "C1" |
                                         blackFriday$Product_Category_2 == "C1" |
                                         blackFriday$Product_Category_3 == "C1",]
blackFriday.prod_cat_C2 <- blackFriday[blackFriday$Product_Category_1 == "C2" |
                                         blackFriday$Product_Category_2 == "C2" |
                                         blackFriday$Product_Category_3 == "C2",]
blackFriday.prod_cat_C3 <- blackFriday[blackFriday$Product_Category_1 == "C3" |
                                         blackFriday$Product_Category_2 == "C3" |
                                         blackFriday$Product_Category_3 == "C3",]
blackFriday.prod_cat_C4 <- blackFriday[blackFriday$Product_Category_1 == "C4" |
                                         blackFriday$Product_Category_2 == "C4" |
                                         blackFriday$Product_Category_3 == "C4",]
blackFriday.prod_cat_C5 <- blackFriday[blackFriday$Product_Category_1 == "C5" |
                                         blackFriday$Product_Category_2 == "C5" |
                                         blackFriday$Product_Category_3 == "C5",]
blackFriday.prod_cat_C6 <- blackFriday[blackFriday$Product_Category_1 == "C6" |
                                         blackFriday$Product_Category_2 == "C6" |
                                         blackFriday$Product_Category_3 == "C6",]
blackFriday.prod_cat_C7 <- blackFriday[blackFriday$Product_Category_1 == "C7" |
                                         blackFriday$Product_Category_2 == "C7" |
                                         blackFriday$Product_Category_3 == "C7",]
blackFriday.prod_cat_C8 <- blackFriday[blackFriday$Product_Category_1 == "C8" |
                                         blackFriday$Product_Category_2 == "C8" |
                                         blackFriday$Product_Category_3 == "C8",]
blackFriday.prod_cat_C9 <- blackFriday[blackFriday$Product_Category_1 == "C9" |
                                         blackFriday$Product_Category_2 == "C9" |
                                         blackFriday$Product_Category_3 == "C9",]
blackFriday.prod_cat_C10 <- blackFriday[blackFriday$Product_Category_1 == "C10" |
                                         blackFriday$Product_Category_2 == "C10" |
                                         blackFriday$Product_Category_3 == "C10",]
blackFriday.prod_cat_C11 <- blackFriday[blackFriday$Product_Category_1 == "C11" |
                                         blackFriday$Product_Category_2 == "C11" |
                                         blackFriday$Product_Category_3 == "C11",]
blackFriday.prod_cat_C12 <- blackFriday[blackFriday$Product_Category_1 == "C12" |
                                         blackFriday$Product_Category_2 == "C12" |
                                         blackFriday$Product_Category_3 == "C12",]
blackFriday.prod_cat_C13 <- blackFriday[blackFriday$Product_Category_1 == "C13" |
                                         blackFriday$Product_Category_2 == "C13" |
                                         blackFriday$Product_Category_3 == "C13",]
blackFriday.prod_cat_C14 <- blackFriday[blackFriday$Product_Category_1 == "C14" |
                                         blackFriday$Product_Category_2 == "C14" |
                                         blackFriday$Product_Category_3 == "C14",]
blackFriday.prod_cat_C15 <- blackFriday[blackFriday$Product_Category_1 == "C15" |
                                         blackFriday$Product_Category_2 == "C15" |
                                         blackFriday$Product_Category_3 == "C15",]
blackFriday.prod_cat_C16 <- blackFriday[blackFriday$Product_Category_1 == "C16" |
                                         blackFriday$Product_Category_2 == "C16" |
                                         blackFriday$Product_Category_3 == "C16",]
blackFriday.prod_cat_C17 <- blackFriday[blackFriday$Product_Category_1 == "C17" |
                                         blackFriday$Product_Category_2 == "C17" |
                                         blackFriday$Product_Category_3 == "C17",]
blackFriday.prod_cat_C18 <- blackFriday[blackFriday$Product_Category_1 == "C18" |
                                         blackFriday$Product_Category_2 == "C18" |
                                         blackFriday$Product_Category_3 == "C18",]


# COMPROVACIO DE LA NORMALITAT I HOMOGENEÏTAT DE LA VARIANCIA
# Histograma
purchase <- blackFriday$Purchase
hist(purchase,main="Histograma de la variable Purchase")
# Quantil-quantil
qqnorm(purchase,main="Quantil-quantil Purchase")
qqline(purchase)
# Mètode numèric (asimetria)
skewness(sample(purchase))
agostino.test(sample(purchase,46340))
# Mètode d'Anderson-Darling
ad.test(purchase)

# Homogeneïtat de la variància. Test de Fligner-Killeen
# Purchase amb gènere
fligner.test(x = list(blackFriday.gender_male$Purchase,
                      blackFriday.gender_female$Purchase))

# Purchase amb rangs d'edad
fligner.test(x = list(blackFriday.age_0_17$Purchase,
                      blackFriday.age_18_25$Purchase,
                      blackFriday.age_26_35$Purchase,
                      blackFriday.age_36_45$Purchase,
                      blackFriday.age_36_45$Purchase,
                      blackFriday.age_46_50$Purchase,
                      blackFriday.age_51_55$Purchase,
                      blackFriday.age_55_$Purchase))

# Purchase amb categoria de ciutat
fligner.test(x = list(blackFriday.city_cat_A$Purchase,
                      blackFriday.city_cat_B$Purchase,
                      blackFriday.City_cat_C$Purchase))

# Purchase amb anys vivint a la ciutat actual
fligner.test(x = list(blackFriday.years_0$Purchase,
                      blackFriday.years_1$Purchase,
                      blackFriday.years_2$Purchase,
                      blackFriday.years_3$Purchase,
                      blackFriday.years_4_$Purchase))

# Purchase amb estat civil
fligner.test(x = list(blackFriday.marital_NO$Purchase,
                      blackFriday.marital_SI$Purchase))

# Purchase amb ocupacions
fligner.test(x = list(blackFriday.ocu_O0$Purchase,
                      blackFriday.ocu_O1$Purchase,
                      blackFriday.ocu_O2$Purchase,
                      blackFriday.ocu_O3$Purchase,
                      blackFriday.ocu_O4$Purchase,
                      blackFriday.ocu_O5$Purchase,
                      blackFriday.ocu_O6$Purchase,
                      blackFriday.ocu_O7$Purchase,
                      blackFriday.ocu_O8$Purchase,
                      blackFriday.ocu_O9$Purchase,
                      blackFriday.ocu_O10$Purchase,
                      blackFriday.ocu_O11$Purchase,
                      blackFriday.ocu_O12$Purchase,
                      blackFriday.ocu_O13$Purchase,
                      blackFriday.ocu_O14$Purchase,
                      blackFriday.ocu_O15$Purchase,
                      blackFriday.ocu_O16$Purchase,
                      blackFriday.ocu_O17$Purchase,
                      blackFriday.ocu_O18$Purchase,
                      blackFriday.ocu_O19$Purchase,
                      blackFriday.ocu_O20$Purchase))

# Purchase amb categories de productes
fligner.test(x = list(blackFriday.prod_cat_C0$Purchase,
                      blackFriday.prod_cat_C1$Purchase,
                      blackFriday.prod_cat_C2$Purchase,
                      blackFriday.prod_cat_C3$Purchase,
                      blackFriday.prod_cat_C4$Purchase,
                      blackFriday.prod_cat_C5$Purchase,
                      blackFriday.prod_cat_C6$Purchase,
                      blackFriday.prod_cat_C7$Purchase,
                      blackFriday.prod_cat_C8$Purchase,
                      blackFriday.prod_cat_C9$Purchase,
                      blackFriday.prod_cat_C10$Purchase,
                      blackFriday.prod_cat_C11$Purchase,
                      blackFriday.prod_cat_C12$Purchase,
                      blackFriday.prod_cat_C13$Purchase,
                      blackFriday.prod_cat_C14$Purchase,
                      blackFriday.prod_cat_C15$Purchase,
                      blackFriday.prod_cat_C16$Purchase,
                      blackFriday.prod_cat_C17$Purchase,
                      blackFriday.prod_cat_C18$Purchase))


# PROVES ESTADÍSTIQUES
# Correlacions entre variables
# Amb el gènere
sumByGender <- tapply(blackFriday$Purchase, INDEX = blackFriday$Gender, FUN = sum)
medianByGender <- tapply(blackFriday$Purchase, INDEX = blackFriday$Gender, FUN = median)
pie(sumByGender, labels = c("Female", "Male"), 
    col = c("red","blue"), 
    main = "Import de compra total per gènere")
pie(medianByGender, 
    col = c("red","blue"), 
    main = "Import mitjà (mediana) per gènere")

# Amb els rangs d'edat
sumByAge <- tapply(blackFriday$Purchase, INDEX = blackFriday$Age, FUN = sum)
medianByAge <- tapply(blackFriday$Purchase, INDEX = blackFriday$Age, FUN = median)
barplot(sumByAge, 
    xlab = "Rangs d'edat", 
    ylab = "Import de la compra", 
    main = "Import de compra total per rang d'edat")
barplot(medianByAge, 
        xlab = "Rangs d'edat", 
        ylab = "Import mig (mediana) de la compra", 
        main = "Import mig (mediana) de compra per rang d'edat")

# Amb la categoria de la ciutat
sumByCityCat <- tapply(blackFriday$Purchase, INDEX = blackFriday$City_Category, FUN = sum)
medianByCityCat <- tapply(blackFriday$Purchase, INDEX = blackFriday$City_Category, FUN = median)
barplot(sumByCityCat, 
        xlab = "Categoria de la ciutat", 
        ylab = "Import de la compra", 
        main = "Import de compra total per categoria de la ciutat")
barplot(medianByCityCat, 
        xlab = "Categoria de la ciutat", 
        ylab = "Import mig (mediana) de la compra", 
        main = "Import mig (mediana) de compra per categoria de la ciutat")

# Amb els anys que porten vivint a la mateixa ciutat
sumByCityYears <- tapply(blackFriday$Purchase, INDEX = blackFriday$Stay_In_Current_City_Years, FUN = sum)
medianByCityYears <- tapply(blackFriday$Purchase, INDEX = blackFriday$Stay_In_Current_City_Years, FUN = median)
barplot(sumByCityYears, 
        xlab = "Anys de permanència a la mateixa ciutat", 
        ylab = "Import de la compra", 
        main = "Import de compra total per anys de permanència a la mateixa ciutat")
barplot(medianByCityYears, 
        xlab = "Anys de permanència a la mateixa ciutat", 
        ylab = "Import de la compra", 
        main = "Import de compra total per anys de permanència a la mateixa ciutat")

# Amb l'estat civil
sumByMarital <- tapply(blackFriday$Purchase, INDEX = blackFriday$Marital_Status, FUN = sum)
medianByMarital <- tapply(blackFriday$Purchase, INDEX = blackFriday$Marital_Status, FUN = median)
pie(sumByMarital, labels = c("NO", "SI"), 
    col = c("green","brown"), 
    main = "Import de compra total per estat civil")
pie(medianByMarital, labels = c("NO", "SI"), 
    col = c("green","brown"), 
    main = "Import mig (mediana) de compra per estat civil")

# Amb les ocupacions
sumByOccu <- tapply(blackFriday$Purchase, INDEX = blackFriday$Occupation, FUN = sum)
medianByOccu <- tapply(blackFriday$Purchase, INDEX = blackFriday$Occupation, FUN = median)
barplot(sumByOccu, 
        xlab = "Ocupació", 
        ylab = "Import de la compra", 
        main = "Import de compra total per ocupacions")
barplot(medianByOccu, 
        xlab = "Ocupació", 
        ylab = "Import de la compra", 
        main = "Import de compra total per ocupacions")

# Amb les categories de productes
sumByProdCat <- aggregate(blackFriday$Purchase, by=list(Category=blackFriday$Categories), FUN=sum)
sumByProdCatMax <- head(sumByProdCat[order(sumByProdCat[,2], decreasing = TRUE),], n = 10L)
sumByProdCatMin <- head(sumByProdCat[order(sumByProdCat[,2]),], n = 10L)
# Top 10 categories que més import de compra sumen
sumByProdCatMax
# Top 10 categories que menys import de compra sumen
sumByProdCatMin

medianByProdCat <- aggregate(blackFriday$Purchase, by=list(Category=blackFriday$Categories), FUN=median)
medianByProdCatMax <- head(medianByProdCat[order(medianByProdCat[,2], decreasing = TRUE),], n = 10L)
medianByProdCatMin <- head(medianByProdCat[order(medianByProdCat[,2]),], n = 10L)
# Top 10 categories amb import de compra més alt
medianByProdCatMax
# Top 10 categories amb import de compra més baix
medianByProdCatMin


# ALGORITME DE REGRESSIÓ PREDICTU
# Regresors qualitatius dels compradors
gender = blackFriday$Gender
age = blackFriday$Age
cityCat = blackFriday$City_Category
cityYears = blackFriday$Stay_In_Current_City_Years
maritalStatus = blackFriday$Marital_Status
occupation = blackFriday$Occupation
prodCat = blackFriday$Categories

# Variable a predir
purchase = blackFriday$Purchase

# Models
model1 <- lm(purchase ~ gender, data = blackFriday)
model2 <- lm(purchase ~ age, data = blackFriday)
model3 <- lm(purchase ~ cityCat, data = blackFriday)
model4 <- lm(purchase ~ cityYears, data = blackFriday)
model5 <- lm(purchase ~ maritalStatus, data = blackFriday)
model6 <- lm(purchase ~ occupation, data = blackFriday)
model7 <- lm(purchase ~ prodCat, data = blackFriday)
model8 <- lm(purchase ~ prodCat + cityCat, data = blackFriday)
model9 <- lm(purchase ~ prodCat + cityCat + occupation, data = blackFriday)
model10 <- lm(purchase ~ prodCat + cityCat + occupation + 
                gender, data = blackFriday)
model11 <- lm(purchase ~ prodCat + cityCat + occupation +
                gender + age, data = blackFriday)
model11 <- lm(purchase ~ prodCat + cityCat + occupation +
                gender + age + cityYears, data = blackFriday)
model12 <- lm(purchase ~ prodCat + cityCat + occupation + gender +
                age + cityYears + maritalStatus, data = blackFriday)


# Taula amb els coeficients de determinació de cada model
taula.coeficients <- matrix(c(1, summary(model1)$r.squared,
                              2, summary(model2)$r.squared,
                              3, summary(model3)$r.squared,
                              4, summary(model4)$r.squared,
                              5, summary(model5)$r.squared,
                              6, summary(model6)$r.squared,
                              7, summary(model7)$r.squared,
                              8, summary(model8)$r.squared,
                              9, summary(model9)$r.squared,
                              10, summary(model10)$r.squared,
                              11, summary(model11)$r.squared,
                              12, summary(model12)$r.squared),
                            ncol = 2, byrow = TRUE)
colnames(taula.coeficients) <- c("Model", "R^2")
taula.coeficients

# Dades per predir l'import de compra en productes 
# del perfil de comprador que més compra i productes més venuts
newdata <- data.frame(
  gender = "M",
  age = "26-35",
  cityCat = "B",
  cityYears = "1",
  maritalStatus = "NO",
  occupation = "O4",
  prodCat = "C8 C0 C0"
)
# Predicció
predict(model12, newdata)
  
# Dades per predir l'import de compra en productes 
# del perfil de comprador que menys compra i productes menys venuts
newdata <- data.frame(
  gender = "F",
  age = "0-17",
  cityCat = "A",
  cityYears = "0",
  maritalStatus = "SI",
  occupation = "O8",
  prodCat = "C5 C10 C16"
)
predict(model12, newdata)


# ARBRE DE DECISSIÓ DE CLASSIFICACIÓ PER CATEGORIA DELS PRODUCTES
set.seed(231678)
mida.total <- nrow(blackFriday)
mida.entrenament <- round(mida.total*0.7)
dades.index <- sample(1:mida.total, size = mida.entrenament)
dades.entrenament <- blackFriday[dades.index, ]
dades.test <- blackFriday[-dades.index, ]

# Model amb totes les variables
model1 <- C5.0(Product_Category_1 ~ Gender + Age + Occupation + City_Category +
               Stay_In_Current_City_Years + Marital_Status + Purchase,
               data = dades.entrenament)
# Model sense la variable Purchase
model2 <- C5.0(Product_Category_1 ~ Gender + Age + Occupation + City_Category +
                Stay_In_Current_City_Years + Marital_Status,
              data = dades.entrenament)

# Evaluació dels models
summary(model1)
summary(model2)
model1
model2

# Prediccions
predict1 <- predict(model1, newdata = dades.test)
taula1 <- table(predict1, dades.test$Product_Category_1)
taula1

predict2 <- predict(model2, newdata = dades.test)
taula2 <- table(predict2, dades.test$Product_Category_1)
taula2


# % Classificats correctament
paste("% Precisió model 1: ", round(100 * sum(diag(taula1)) / sum(taula1),3))
paste("% Precisió model 2: ", round(100 * sum(diag(taula2)) / sum(taula2),3))

