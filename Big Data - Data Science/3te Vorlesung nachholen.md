# Klausur

- im Skript steht viel mehr Drinne als wir in der Vorlesung machen, _auch nur das ist Klausur relevant_
- für Wissenschaftliche arbeiten erwartet er immer von grund auf zu starten

# Fahrplan
- lineare regression und kleinste quadrate will er fertig machen
- dann neuronale netze
- Jupyter notebooks ausführen können + PyTorch (anaconda?)
- er testet immer erst einmal ob die funktionieren
# Wiederholung
- wir machen lineare regressionen mit Hypothesentests und diagnostik
- LR einsetzen, immer mit Prognose fehler und Abweichungen von der gerade
- Risiduen Fehler bei Regressions Diagnostik
- wird bei neuronalen Netzen genauso benötigt
- wir wollten wissen ob lineare regressionen funktionieren
    - eigene Aktie
- wir machen hier _metrische_ Y (also zahlen werte)
- Kategorielle kommen später nach Neuronen
- CAPM ist Linearen Zusammenhang von Aktien schätzen lassen (Capital Asset Pricing Modell)
- Schätzer die kleinste quadrate methode schätzen sind normalverteilt
- Summary gibt Hypothesentest für H0 das der jeweilige Parameter 0 ist
- Beibehalten einer Hypothese ist kein bewerf
- Strukturbruch haben wir erstmal nicht #nichtKlausur
- Januar effekt haben wir uns angeschaut (den gibts gar nicht), dafür brauchen wir unser wissen das wir schauen können das man H0 auch verwirft
- zum Nachlesen sollte man wirklich bei manu Veerberg
- das man sich der Warheit nähert hat mit den eigenschaften von Gauss und Markov zutun
    - #klausur wie nennt man die eigenschaft das E(beta) = b
        - durch die unverzerrtheit
        - und sie ist so schmal wie möglich, also die beste, => kleinste varianz
    - aber der satz hat annahmen a0 bis a5
    - aber die waren nicht alle erfüllt
        - die homoskedaszität war hier verletzt, am ende ist die varianz größer
        - _Leptokurtic_ => haben wir nicht beachtet
            - Aktienrenditen sind typischerweise
                - Heteroskedaszität => mal schwingt es mehr manchmal weniger
                - Leptokuritc => entsprechen nicht einer normalverteilung, extreme sind wahrscheinlicher
    - Gausmarkov fordert _keine_ normalverteilte Residuen
- Aber #Heteroskedaszität kommt oft vor
    - und autokorrelation auch
    - dadurch ist man nichtmehr erwartungstreu aber konsistent (je mehr daten desto wahrscheinlicher treffe ich die wahrheit)
    - => deswegen kann man aber nicht mehr die die normale Summary benutzen können
    - man muss eine nehmen die Autokorrelation und heteroskedaszität mit rein nimmt
- Spuriosities => Verdächtigkeiten
    - Teils zeigt einem die lineare regression an das man eine korrelation hat
    - _immer nach Heteroskeszität autokorrelation schauen_
    - verhidnert das man Falsche regressionen (die die Nullhypothese verwerfen) für wahr hält, durch Diagnostik kann man aber sich bspw. die autokorrelation anschauen und sehen das der satz von gaus markov und der andere nicht wirken
- Folie 43 scheint das nochmal zu zeigen?
- bisher hatten wir immer die kleisnten quadrate methode, jetzt machen wir die nächste
- Man muss erstmal die gerade schätzen, dann kann man die residuen mit der regressions diagnostik überprüfen und schauen ob das passt (heteroskedaszität und autokorrelation...)
    - wenn man merkt das Gauss markov nicht passt muss man die werte für Newey West nehmen, die schätzwerte bleiben gleich, nur die standardfehler ändern sich
- Wir hatten auch multiple lineare regression

# Themen

- [[Maximum Likelihood]]
- [[Andere Regressionen]]