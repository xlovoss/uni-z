4 hauptsächlich in [[CRSIP]]

![[GML_06_01 ML.pdf#page=48]]

Wir erstellen 50 Beispielwerte
y = x1^2 plus Rauschen

x1 und x2 verwerfen wir, da wir die Nullhypothese anehmen

RESET Test gibt uns den Hinweis das was Faul ist

Es geht weiter im BIG DATA
![[GML_06_01 ML.pdf#page=57]]

Wir setzen es auf 10000 Werte 
x2 und x3 haben einen Signifikanten Einfluss 
Wenn ich ohne Gehirn mit einer linearen Regression durch die Welt laufe, fahre ich in die Wand

### Großer Datensatz = Signifikanzniveau runter
Er hat mal das Signifikanzniveau auf 10 % gesetzt weil sonst komplett irrelevantes wird als relevant markiert

![[GML_06_01 ML.pdf#page=61]]

#feature_selection
Bei Drei Regressoren haben wir 8 Möglichkeiten
xn sind die Regressoren

Regularisierung Technik besteht darin die 
Wir nehmen die Lasso Strategie
minimieren Summenzeichen(y-alpha+betax))^2 + lamda * (Beta)

![[GML_06_01 ML.pdf#page=66]]

Wenn wir die Bestrafung absenken 
Die Lassotechnik findet raus das x3 überflüssig ist 

## Regressionsbäume

![[GML_06_01 ML.pdf#page=71]]

Wenn der Wert größer als das angegebene ist, wird es Stufenartig der nächste Schritt 

![[GML_06_01 ML.pdf#page=79]]

Jetzt ist es die Transformierte Variable ist jetzt der Player x2 interessiert keiner mehr 
Wir suchen eine Lösung die es löst ohne zu plotten

[[Neuronale Netze]]

