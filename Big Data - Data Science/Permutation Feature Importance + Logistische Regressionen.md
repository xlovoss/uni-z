
[[Big Data - Data Science/6te Vorlesung|6te Vorlesung]]

![[PYTPRA_02_01_PyTorch.pdf#page=54]]

Der Charm ist das wir die Architektur so lasse nur das wir die Daten Würfeln



![[PYTPRA_03_01_Logit.pdf#page=3]]


Wow endlich das
Wir wollen rausfinden wann es der Punkt ist, das Leute den Ferrari kaufen 

Wir schätzen mit Maximum Likelyhood

Wie habe cih den Konfidenzintervall für die Schätzer gerechnet 
Standardabweichung

![[PYTPRA_03_01_Logit.pdf#page=6]]

![[PYTPRA_03_01_Logit.pdf#page=7]]

True Negeativ

Benchmarkmodell ist das Modell wogegen wir in unserer Übung antreten 


## Beispiel
![[PYTPRA_03_01_Logit.pdf#page=45]]

EBIT - Gewinn vor Steuern
Leverage ist der Hebel 
Wir haben in INVGRADE den mean genommen und das sind 47 Prozent 
Wir fokusieren uns auf die 5 Attribute 

![[PYTPRA_03_01_Logit.pdf#page=47]]

Welcher davon ist maßgeblich von Null verschieben, alle sind maßgeblich verschieden 

Perfekte #klausur Frage

![[Pasted image 20251014145447.png]]

Das log ändert sich, wie ändert sich das andere 
Im Kontext des logistisches Regressionsmodells des Firmenkundenrating
-> Hier Ausfallrisiko vorherzusagen
Logit Transformationen des Ausfallrisikos
hierbei ist 

## Logistische Regression

aus unabhängigen Variablen da ist die Abhängige Variable eine dichotome Variable (EIne Variable mit nur zwei Ausprägungen)

-> Entweder kauft jemand das Produkt oder nicht
-> Entweder ist eine Krankheit vorhanden oder nicht 

Wahrscheinlichkeit das Merkmale geschätzt werden oder nicht

Wir geben aus Alter Geschlecht und Raucherstatus eine Krankheit an und schauen wie wichtig die einzelnen Faktoren sind

###### Warum nehmen wir nicht einfach eine lineare Funktion?
Wenn wir immer noch Null oder eins haben wollen, macht der uns eine Gerade Linie und keine Simoide Funktion
Wir wollen also nur eine Funktion haben die nur Null und eins animmt 