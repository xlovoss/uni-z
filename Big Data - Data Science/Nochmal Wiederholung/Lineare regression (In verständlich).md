[[2te Vorlesung]]

Was wollen wir heraus finden
Wir wollen wissen ob die Rendite der Baubranche vo  der Rendite des Gesamtmarktes abhängt, Dazu nutzen wir lineare regression.
In der Form
- (w) Das wahre Modell sei: y = a + bx +e 
	- a b und e sind die echten Werte
- (g) Das geschätzte Modell sei: y = _𝛼_ + _𝛽_𝑥 + 𝑢
	- Alpha Beta und u sind die von der regression geschätzt werden

### Lineare Regression in R

```
#adjust this section!!!====================================================
Y = data_table$constrrf #xcess return for a sub-index of industrials, cap weighted like dax
X = data_table$rmrf #xcess for broad CRSP index
reg = lm(Y~X) #play here if u want
summary(reg)
> #adjust this section!!!====================================================
> Y = data_table$constrrf #xcess return for a sub-index of industrials, cap weighted like dax
> X = data_table$rmrf #xcess for broad CRSP index
> reg = lm(Y~X) #play here if u want
> summary(reg)
Call:
lm(formula = Y ~ X)

Residuals:
    Min      1Q  Median      3Q     Max 
-12.879  -1.641  -0.115   1.520  11.725 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) -0.07259    0.11542  -0.629     0.53    
X            1.16817    0.02549  45.837   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.837 on 608 degrees of freedom
Multiple R-squared:  0.7756,	Adjusted R-squared:  0.7752 
F-statistic:  2101 on 1 and 608 DF,  p-value: < 2.2e-16
```

y ist die Baubranche
x ist der Markt
ist x > 1 ist die Aktie Agressive,  unter 1 Defensiv
Das R^2 sagt wie viele die Abweichung erklärt wird
-> hier werden 78 % erklärt, schonmal sehr gut
Laut der Ausgaben ist Alpha -0.07 und Beta 1.16 aber wird das getraut ? 

**Erklärung von Gemini:**
Der **Beta** Wert deutet darauf hin das der markt volatiler ist als der Markt. Wenn der Markt um 1 % steigt, steigt die Branche um 1,17 % (Deswegen Agrressive Aktie)
Das **Alpha** sagt das der Baubranchen-Subindex im durschnitt schlechter abschneidet als die Rendite die vorgesehen war 

#Signifikanzniveau Gültigkeit von Hypothesen zu bewerten ob sie signifikant ist, oder nur durch Zufall entstanden sind

#p-wert Beträgt hier 0,53, also eine Wahrscheinlichkeit von 53% das der Wert hier Alpha Beträgt oder eine größere und kleinere Zahl ist 
#r-quadrat beschreibt wie gut die erstellenten Regressionsmodell die Daten beschreiben - misst die Prozentsatz der Streuung 

# Herleitung / Experiment mit ausgedachter Aktie
### Code von stumpfer linearer Regression

````
> set.seed(2023)
> eps = rnorm(length(X),0,2.5)
> Y_made_up = 0.5*X+eps
> reg_hide_n_seek = lm(Y_made_up~X) #play here if u want
> summary(reg_hide_n_seek)
Call:
lm(formula = Y_made_up ~ X)

Residuals:
   Min     1Q Median     3Q    Max 
-8.124 -1.722  0.016  1.673 11.436 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  0.02729    0.10056   0.271    0.786    
X            0.47541    0.02220  21.412   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.472 on 608 degrees of freedom
Multiple R-squared:  0.4299,	Adjusted R-squared:  0.429 
F-statistic: 458.5 on 1 and 608 DF,  p-value: < 2.2e-16
````

- Herleiten das es klappt
- Wir denken uns eine Fake Aktie aus 
- Y_made_up = 0.5*X+eps sagt das Y immer die Hälfte von X macht 
- x ist der Markt, Y unsere Aktie
- Dazu kommt eps ein zufälliger Störterm
- 0.47541 ist unser Beta Wert, was schon Nahe an b = 0,5 ist (was der festgelegt beta Wert ist)
- -> Erkenntnis -> lineare Regression bringen einem in die Nähe sind aber nicht perfekt 
- Die Werte sind Normalverteilt
- Übung zeigt uns wie krass das Tool ist das trotz Rauschen wir ziemlich nahe am eigentlich Ergebnis ankommen 

## Kleinste Quadrat Methode
![[GML_02_01 Oekonometrie.pdf#page=23]]

Wir stellen 5 Bedingungen auf, sind diese Erfüllt gelten die unteren Aussagen, auch BLUE genannt.
Das meint wenn die Störterme die Bedingung erfüllen wissen wir das unsere Schätzung Alpha und Beta die bestmögliche lineare Unverzerrten Schätzer sind.
### Bedingungen für Gaus Markov
- (a1) 𝐸 [ 𝑒 𝑖 ] = 0 , i = 1 , … , n )
    - Die Summer aller Störterme ist Null
    - Die Störterme gleichen sich aus
- (a2) e und x sind unabhängig
    - Die Störterme hängen nicht von X ab, also bspw. vom der Rendite des Gesamtmarkts
    - x ist Exogen
- (a3) 𝑉 𝑎 𝑟 [ 𝑒 𝑖 ] = 𝜎 2
    - auch _Homoskedastizität_ genannt
    - Die Varianz aller Störterme ist gleich
    - Die Störterme weichen nicht anfangs weniger ab als am ende oder so, machen Finanzmärkte gerne mal
- (a4) 𝐶 𝑜 𝑣 [ 𝑒 𝑖 , 𝑒 𝑗 ] = 0 , 𝑖 ≠ 𝑗
    - Keine _Autokorrelation_ in den Störtermen
    - Die Störterme bedingen sich nicht gegenseitig
- (a5) bei _multiplen_ lineare regressionen, keien linearen abhängigkeiten von X
    - kommt später Wir kennen nur leider den störterm selber nicht, also müssen wir anhand der Daten prüfen ob dieser die vorrausetzungen erfüllt

## Eigenschaften von Schätzen die Gaus Markov erfüllen (BLUE)
es sind die
- Besten 
	- die kleinste Varianz
- Linearen
	- unter den linearen Schätzern 
- Unverzerten
	- Sie sind Erwartungstrue
	- Der Erwartungswert der Schätzung ist der reale Wert von a oder b Schätzer
### Nullhypothese
Die Nullhypothese ist das der jeweiligen Koeffizient einfach 0 ist wenn die wahrscheinlichkeit kleiner als 5% (Signifikanzniveau) ist verwerfen wir die Nullhypothese, nehmen also unsere Geschätzten Werte an 
#### Summary ausgabe
```
Call:
lm(formula = Y ~ X)

Residuals:
    Min      1Q  Median      3Q     Max 
-12.879  -1.641  -0.115   1.520  11.725 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) -0.07259    0.11542  -0.629     0.53    
X            1.16817    0.02549  45.837   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.837 on 608 degrees of freedom
Multiple R-squared:  0.7756,	Adjusted R-squared:  0.7752 
F-statistic:  2101 on 1 and 608 DF,  p-value: < 2.2e-16
```
#wichtig
- Koeffizienten
	- gibt die einzelnen Variablen an, basierend auf Methode der kleinsten Quadrate ,wie genau man die berechnet brauchen wir nicht
	- wir hatten bisher Alpha (Interceptor) und Beta(X), können aber auch mehr werden
- Estimate
	- Der geschätzte Wert basierend auf auf Methode der kleinsten Quadrate 
- Std. Error ist die Standardabweicheung
	- Standardabweichung ist die Wurzel der Varianz
- t-wert
	- berechnet mit Estimate /std. Error
	- man teilt durch die Standardabweichung damit alles auf die Standardnormalverteilung bei 0 passt (die Werte unabhängig von den estimates verglichen werden können)
- P-Wert
	- Wahrscheinlichkeit das die Nullhypothese wahr ist
	- ist die über 5% (Signifikanzniveau) gehen wir davon aus das der Koeffizient einfach 0 ist 
### Leitfrage vom Anfang beantworten
Wie reagiert die Aktie auf den Gesamtmarkt, siehe Ausgaben da drüber 
- Beta ist 1.16 
	- Wahrscheinlichkeit ist 2e-16 also qausi null
- Alpha ist Null
	- Wahrscheinlichkeit der Nullhypothese > 5% also nehmen wir H0 an
- Multiple R^2 ist 77%
	- Größtenteil der Abweichungen wird erklärt


## Jetzt 2 x Werten
```
D_january = data_table$jan
reg_jan = lm(Y~X+D_january) 
summary(reg_jan)

Call:
lm(formula = Y ~ X + D_january)

Residuals:
     Min       1Q   Median       3Q      Max 
-12.8203  -1.6622  -0.0673   1.5535  11.7772 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) -0.12246    0.12031  -1.018    0.309    
X            1.16683    0.02548  45.797   <2e-16 ***
D_january    0.60354    0.41494   1.455    0.146    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.835 on 607 degrees of freedom
Multiple R-squared:  0.7763,	Adjusted R-squared:  0.7756 
F-statistic:  1054 on 2 and 607 DF,  p-value: < 2.2e-16
```

## Regressions Diagnostik / Herleitung des nächsten Satzes
Man will prüfen ob das Überhaupt Sinn macht, dazu die folgenden Schritte 
## Reset Test

```
> resettest(reg)#H0 No spec error
	RESET test

data:  reg
RESET = 4.5204, df1 = 2, df2 = 606, p-value = 0.01125
```
- Methode um zu überprüfen ob unsere Regression richtig spezifiziert ist 
- Ist die Richtige Form (Linear) vorhanden?
- sind alle wichtigen X vorhanden
- Hier ist H0 das alles richtig spezifiziert ist 
- Der P-Wert ist aber 0,01 also P < 0,05 also verwerfen wir die Nullhypothese 
- Durch einen Plot kann man erkenne das linear eigentlich ganz gut passt
- => es fehlen wohl noch x 
## Wir testen die Bedingungen für Gaus Markov für die 2 X 

- a1 und a2 könne wir über Residuen nicht überprüfen hier müssen wir darauf vertrauen das wir den richtigen Ansatz gewählt haben
	- a1 (erwartungswert der Störterme = 0)
	- a2 (Unabhängigkeit der Störtermen und X)
- a3 (Homoskedastizität) immer die gleiche Varianz
	- dazu lassen wir uns einmal die ganzen Residiuals malen
	- -> Die Störterme haben keine Homeskedastizität
	- Bedingung ist verletzt also gelten die Eigenschaften nach Gaus Markov nicht für die Störterme
- a4 Autokorrelation
	- `acf(coredata(residuals(reg)), ci = 0.95, lag.max = 20)`
	- damit lassen wir uns die autokorelation darstellen 


P wert kleiner 5 Prozent = Verwerfen