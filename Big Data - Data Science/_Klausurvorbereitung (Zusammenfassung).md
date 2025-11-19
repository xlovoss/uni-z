# Lineare regressionen

## einfache

ein x ein y

## multiple

mehrere x ein y

## multivariable

mehrere x mehrere y die x müssen nicht bei jedem y die gleichen sein

# Schätzmethoden?

## Kleinste quadrate

man will die residuen minimieren 

## Maximum likelyhood

Chance maximieren das auskommen in der Stichprobe zu haben
braucht Gaus Markov und Normalverteilte Störterme
kann auch nicht lineares
-> Man will die Wahrscheinlichkeit das die beobachten Daten unter den gewählten Parametern auftreten maximieren

# Sätze / Theoreme

## Gaus Markov (für KQ)

1. Erwartungswert e = 0
2. e und x unabhängig
3. Homoskedastizität 
4. keine Auto Korrelation
5. keine linearen Abhängigkeiten => Besten (kleinste Varianz) Linearen Unverzerrten (Erwartungswert = echterwert) estimates => gibt die besten aber annahmen unrealistisch braucht keine normal Verteilung
    

## Newey west (für Kleinste Quadrate)

Lockerer Gaus Markov
hier ist Homoskedastizität(Varianz der Störterme ist konstant) egal, kann auch Hetero sein
etwas Auto Korrelation ist auch fine => Konsistente Schätzer => man muss die t-werte nehmen für die Standardabweichung (die aus Koeffizient und Rauschen berechnet wird, 2 ist gut )

Dabei BLUE - Best bedeutet kleinste Varianz unter allen linearen unverzerrten Schätzern(Blue bezieht sich auf mehr Effizienz)

Was ist der entscheidender Vorteil wenn Heteroskedastizität oder Autokorrelation vorliegen bei Newey West?
->er liefert korrigierte Standardfehler (t-werte), damit die Test gültig bleiben, obwohl der KQ schon konsistent sind. Im Mittel treffen die Fehler die Standards. GLS korrigiert diese Standardfehler damit Hetero und Auto berücksichtigen

## SURE Methode (für KQ)

Seamingly unrelated Regression Estimator (Scheinbar unverbundene Regressionen)
nutzt die Korrelation der Fehlerterme wenn die x nicht korreliert sind
gibt einfach bessere Werte wenn man alle zusammen schätzt

## Theorem Maximum Likelihood Schätzung (für MLE)

Voraussetzungen:

- Richtige Linkfunktion (also richtige latente funktion bei logistischen)
- keine Auto Korrelation
- keine heteroskedaszität
- keine abhängigkeiten zwischen störtermen und regressorf
- alle wichtigen regressoren vorhanden
- dann sind Schätzer die durch maximum likelihood entstanden sind
- konsistent
- Asymptotisch effizient (also kleinste Varianz)
- Asymptotisch normalverteilt (jedoch sehr viele Werte um Eigenschaften entfalten zu könne )

# Regressionsdiagnostik und Tests

H0 bei p unter 5% verwerfen

## Reset Test

H0 => alle wichtigen Regressoren vorhanden + richtige funktionsform

## Breusch Pagan test

H0 => Homoskedaszität
Braucht Normalverteilung

## Autokorrelation

plotten und schauen ob residuals vs fittet eine form ergibt

## White test

H0 => Homoskedastizität

Braut keine normalverteilung

## Varianz Inflations Faktoren

VIF = 1/1-Rk²

man macht eine regression auf jeden der regressanten, und schautzu wie viel er durch andere regressanten erklärt wird

alles über meist so 5 kann eigentlich weg

## Durbin Watson Test (unwichtig)

H0 => keine autocorrelation

# Begriffe

## Skew / Schiefe

ist die verteilung assymetrisch?

## Leptokurtose

sind die ränder größer als normalverteilung

gibts auch mit kleiner

# Vorgehensweise

## CRISP

Cross industry standard process for data mining

1. Business understanding
     
2. Data understanding
    was hab ich überhaupt / was fehlt mir
    
3. Data preparation
    
    müssen nett vorbereitet sein
    
4. Modelling
    
    eigentliches modell bauen
    
5. Evaluation
    
    ist das modell überhaupt gut
    
    hab ich alternativen die ich abwägen muss
    
6. Deployment
    
    Modell zum einsatz bringen
    

# modellarten

## Explain

Hohes R² als ziel

welche Faktoren haben welche Einfluss

## Predict

korrekte Empfehlungen wichtiger als hohes R^2
-> Hier zählen die Ergebnisse nicht die statistische Schönheit (R^2)
bspw. Kaufempfehlung ausgesprochen und es geht nachher aber 100% anstatt 10% ist nicht so schlimm wie -10% vorhersagen obwohl es ja eigentlich näher dran ist

# Feature Selection

welche X sind eigentlich relevant
ganz stumpf alle Kombinationen aus, und schaut was am besten ist

## regsubset

brute force (stumpf probiert alles )
forward => langsam X hinzufügen
backward => wegnehmen
probiert alles aus und sagt was am besten war

## Regularisierung

Modell wird bestraft für hohe Beta werte
alles was nicht 0 ist kostet
also werden (hoffentlich) möglichst wenig Betas genommen
Methode innerhalb der Formel, man addiert einen Straf Term für jedes Gewicht das nicht 0 ist das Modell versucht selber die Gewichte klein zu halten
## Visualisierung

man lässt es sich einfach mal plotten

geht halt nur für einfaches

# Linearisierung

bspw. daten eig. Parabel aber wir haben ja eine lineare regression

die regression kann nicht selber x^2 oder so rechnen

also fügt man x^2 als input bei

# Neuronale Netze

## Theoreme

### Universal approximation Theorem

Ohne Hidden Layer ist es Lineare Funktion

1 hidden schicht => jede stetige funktion anzunähern

2 hidden schichten => jede nicht stetige

### Güte der Schätzer Theorem

geschätzte gewichte nähern sich wahren gewichten mit zunehmendem n an, wenn

Störterme gaus markov erfüllen

identisch und unabhängigverteilte störterme

nur die wichtigen regressoren da

minimales netz

## Probleme

## Aktivierungsfunktionen

### Die normale linearea

joa

### Sigmoid

alle werte von 0 bis 1

S

ab -5 bzw. +5 quasi 0 bzw 1

## Gradientenabstieg

Gradient => Vektor aus allen partiellen Ableitungen

und man will ja den Fehler abhängig davon minimieren

man schaut sich die Steigung des Fehlers an und ändert die Gewicht so das er weniger wird

beim sgd nimmt man nur ein paar werte und nicht alle

## Hyperparameter optimierung

HPO

parameter wie lernrate, anzahl an neuronen, iterationen, aktivierungsfunktion müssen ja auch gut gesetzt werden

aber woher weiß ich eigentlich was da gut wär

Verfahren

Random search

man probiert random werte in einem bestimmten interval und schaut was das beste war

Grid search

man gibt für a lle betroffenen parameter ein paar konkrete werte an und es wird jede komination der werte ausprobiert um hoffentlich die besten zu finden

Evolutionär

gutes wird übernommen und immer wieder abgewandelt

mag er aber nicht so

## Diagnostik und Tests

### Permutation feature importance

welches X ist eigentlich wie wichtig?

man setzt alle werte eines X auf zufällige werte und schaut wie das R^2 sich verhält

# Logistische Regressionen

besser für kategoriale werte

Latente Variable (Agitation) ai = c+ b xi + eps i im hitnergrund

man berechnet quasie normal einen wert

alles unter 0 ist nein, alles drüber ist ja

durch die sigmuide funktion wird das dann auf den bereich von 0 bis 1 gequetscht

dann stellt es die wahrscheinlichkeit dar mit der fall 1 eintritt

### Konfusionsmatrix
Tool zur Diagnose 
matrix mit vorhersage ja nein und real ja nein
kann man schön sehen was gut und nicht gut läuft
"Wie oft habe ich Ja gesagt obwohl es Nein war "

### Interpretation der Koeffizienzen

sagen an sich nicits

müssen e^x genommen werden um aussagekräftig zu sein

### Cross Entropie loss / log loss

hohe zahlen bei höheren abständen

sieht recht kompliziert aus

bspw. 0 richtig, 0.99999 vorhergesagt => loss von ca. 6

### Logit vs probit

sind wohl nur leicht unterschiedliche verteilungen????

logit nutzt die logistische funktion

probit die normalverteilung

logit ist netter zu interpretieren

aber ergebniss ist meist recht ähnlich

---

Soll ich Ihnen eine Definition oder Erklärung zu einem der Begriffe geben, die in der Zusammenfassung genannt sind?