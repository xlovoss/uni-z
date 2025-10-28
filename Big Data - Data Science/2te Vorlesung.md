Tieferes Verstehen

GML-2.0 Excel
![[Pasted image 20250930123952.png]]

Januar erster Tag des Monats 
Wie hängt die Rendite der Aktie A zusammen mit der Aktie des Gesamtmarktes 
Mithilfe der Lineare Regression

y = f(x) + e
e Ist der Störfaktor
Funktionale Form 

```
#==========================================================================

#now we construct stock returns ourselves

set.seed(2023) (Wichtig das wir alle den gleichen Seed setzen
da es ein random seed generator ist)

eps = rnorm(length(X),0,2.5)
  
Y_made_up = 0.5*X+eps

reg_hide_n_seek = lm(Y_made_up~X) #play here if u want
summary(reg_hide_n_seek)

#beta = q?
q=0.45
t_made_up = (reg_hide_n_seek$coefficients[2]-q)/0.02220
t_made_up

#==========================================================================
```

Wir setzen das das Rauschen im seed anders


![[GML_02_01 Oekonometrie.pdf#page=22]]
Wir sehen Daten die wir schätzen müssen
Und rausfinden welche Qualität diese Werte haben

Wir trainieren anhand der Daten um den Wahren Wert herauszufinden

Standardabweichung quadriert ist die Varianz 
Wahrscheinlichkeit das es Außerhalb liegt
Signifikanzniveau

Beta = covarianz (y,x) / Var(x)

```
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) -0.12246    0.12031  -1.018    0.309    
X            1.16683    0.02548  45.797   <2e-16 ***
D_january    0.60354    0.41494   1.455    0.146
```

Wenn das Value im Raum -2 bis 2 

#klausur 
![[GML_02_01 Oekonometrie.pdf#page=44]]

a. 
Gauss Markov

b. 
B Eigenschaft, mit kleinesten QUadrate hat man die kleinstmögliche Abstände
U Eigenschaft, Im Mittel treffe ich die Wahrheit

c.
Wir sagen das ein Beta signifikant von 0 verschieden sind 
Alter hat einen Signifikanten Einfluss weil es Größer ist als -2 bis 2

d.
Geschlecht ist auch größer, null wird abgelehnt, also wird Sexuell Diskriminiert

e.
Ausführung des Reset testets
Prüfung auf Heteroskedasticity ()
Prüfung auf Korrelation in den Residuen 


>lm(formula = Y ~ X + D_january)
>
Müssen wir auch erklären können

Das Beibehalten einer Nullhypothese ist nicht ihr Beweis

#### RESET - TEST
- Richtige Funktionale -Form
- Alle x sind da

![[GML_02_01 Oekonometrie.pdf#page=32]]

Letzter Satz den wir wissen müssen

Autokorrelation - WIe sin die Residuen korreliert 

Signifikanz - bedeutsam oder aussagekräftig ein Ergebnis ist 

## Realität ist nicht Gaus Markov 