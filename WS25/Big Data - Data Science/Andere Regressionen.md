# Multiple Vs. Multivariable Lineare Regression
## Einfache Regression
Y = alpha + Beta X > Man hat nur ein Beta und ein X um ein Y vorherzusagen

## Multiple Regression

Y = alpha + Beta1 *X1 + ... + BetaN * Xn Man sagt ein Y mit mehreren X hervor

## Multivariable Regression
Y1 = alpha + Beta1 *X1 + ... + BetaN * Xn 
Y2 = alpha + Beta1 *X1 + ... + BetaN * Xn Man SAGT Mehrere Y mit mehreren X hervor

## Paneldaten (Multivariable Regression)
- bisher haben wir immer nur eine Aktie über einen Zeitraum betrachtet
- Wir könnten aber auch 2 Subjekte (Aktien), liefert oft bessere ergebnisse
- Bspw. nimmt man die top 40 im dax, Y als höhe der Wirtschaftsprüfer honorare und X ganz viele Daten über das Unternehmen 
	- Nimmt man nur die Abschlüsse 2023 sind das QUerschnittdaten 
	- nimmt man die historische Daten von einem Unternehmen sind das längsschnittdaten 
	- nimmt man alle Daten von allen Unternehmen hat man **Paneldaten**

## Experimente zu multivariable Regression /Panelmodelle
![[GML_05_01 Oekonometrie.pdf#page=7]]
- yit gibt Unternehmen i zum Zeitpunkt t an
- Jede Firma hat einen eigenen Achsenabschnitt
- Jede Firma hat eigene Beta s
- es kommt dazu das die Störterme der Unternehmen korreliert sind
- bspw. Lufthansa und Airberlin
	- DIe Betas waren jeweils anders
	- aber die Störterme bspw ein Vulkanausbruch führt dazu das die Rendite von Lufthansa und Airberlin sinken
		- es könnte aber muss nicht
	- Durch Hypothesentest kann man rausfinden ob sie korrelieren
- In R kann man korrelierende normal verteile Variable erzeugen lassen #wow
- Wir denken uns wieder 2 Aktien aus mit korrelierenden Störtermen
	- sollen zu 85 % korreliert sein
- Ya = 1 * X +espa
- Yb = 2 * X + espa
	- beta ist hier jeweils 1 und 2
	- esp ist der Störterm
- Jetzt versteckt er ein Ergebnis,
	- Er erhöht die Rendite von A am Tag 30 um 10%
	- Bei B an Tag 40  um 2%
	- er baut sich was was so aussieht
- Yi = Alpha + beta1iX + Beta2i * Di
	- X ist gesamtmarkt
	- Wir hoffen das bei Firma a die Beta1  1 ist und das beta 2 die 10 % sind
### Hier mit 2 getrennten linearen Regressionen
![[GML_05_01 Oekonometrie.pdf#page=10]]

- Hier haben wir seperat, nicht Multivariable geschätzt
- beim linken
	- Beta 1 ist ca. 1 und Nullhypthese wird verworfen
	- Beta 2 ist ca. 20% und H0 verworfen (unter 5%)
	- Alpha ist 0 wurde auch erkannt H0 beibehalten
	- 87,5% wurden erklärt
- beim rechten
	- Beta1 ist ca 2 H0 verworfen
	- Beta2 ist aber 0, hier wird die Hullhypothese angenommen
	- hier wurde also die extrarendite nicht entdeckt
	- aber die war ja in den Daten
	- das ist ja blöd :(
## Jetzt als multivariable Regression (SURE) Methode
![[GML_05_01 Oekonometrie.pdf#page=21]]

- Hier wurde multivariable geschätzt
- Das obere der beiden ist wenn wir getrennt schätzen
- das untere getrennt
- hier hat er die zweite Extrarendite auch gefunden
- das hat die einzelne Betrachtung nicht gemacht, eine Erleuchtung
## Sure Modell
- Seamingly unrelated Regression
	- aber in wirklichkeit gibt es eine Beziehung
	- Simultanes schätzen, führt zu wesentlich kleineren Standardfehlern, wenn Variablen nicht Korreliert (Unsere Dummies waren korreliert, das beta1 aber schon) sind, die Störterme aber stark korreliert sind
	- 2 Simultane regressionen bringen Erleuchtung
	- da die Störterme korreliert sind kann man besser Änderungen erkennen die nicht auf die Störterme zurückzuführen sind 
	- hat man komplett gleiche X bringt das nichts, wir hatten hier ja die verschiedenen Dummies
## Ereignisstudien
 hier waren mit den Dummies eine Ereignisstudie dabei
 man kann damit schaune ob solche Ereignisse wie bspw. Vorstandswechsel die Rendite beeinflussen 


Beispielauswertung:
[[Auswertung Multiple Lineare Regressionen]]