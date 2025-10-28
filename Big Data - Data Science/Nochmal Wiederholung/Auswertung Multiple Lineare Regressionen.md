## Multiple lineare Regressionen
Die Anforderungen sind genauso wie bei Linearer Regression, aber es kommt noch dazu das sie nicht Multikorrelationen haben dürfen
Die einzelnen Werte sollen nicht abhängig voneinander sein, weil wir sonst die Regressionskoeffizienten nicht bestimmen können, da wir so nicht den Einfluss von den Unabhängigen Variablen auf die abhängige Variablen nicht nachvollziehen können.

Um herauszufinden ob die einzelnen Werte abhängig voneinander sind setzen wir sie an den Anfang der Gleichung und Testen sie auf den R Wert. Hoher R Wert sagt hohe Wahrscheinlichkeit darauf das sie Abhängig voneinander sind. Oder das sie Überflüssig ist, weil sie von den anderen Erklärt werden können

Hier kommt VIF (Various Inflation Factor) und Toleranz (T) ins Spiel
Wenn T = 1- R^2
	T< 0.1 mögliche Multikollinearität  
Wenn VIF > 10 (1/(1-R^2))
Auch Multikollinearität

Beheben kann man das indem man die Variablen addiert und Durchschnitt berechnest, oder unwichtige Variablen entfernst

## Beispiel

![[Pasted image 20251010134428.png]]

Mit dem Tool von denen eine Tabelle erstellen, Koeffiziententabelle  ist dann das hier

![[Pasted image 20251010134838.png]]

Der Standardisierte Koeffizient sagt uns die realtive Bedeutung von den unabhängigen Variablen, nachdem alle Variablen Standardisiert wurden. Macht die Werte Vergleichbarer miteinander. 
Wenn man das Alter in Tage angeben würde, könnte man so den Koeffizienten größer machen und es wirkt so als ob es ein viel größeren Einfluss auf die Werte Nimmt als ein anderer. Der Standardisiert bleibt Konstant egal, welcher Einfluss die Einheit hat. Wir sehen der Cholesterinspiegel kann am besten die Abweichungen erklären, weil größter Wert

Die Werte kann man dann so Lustig bestimmen und mit Standardwerten füllen

![[Pasted image 20251010134957.png]]

P-Wert sagt ob die Werte einen EInfluss haben oder nicht. In Unserem Fall sind alle Werte kleiner als 0.05, haben also einen Signifikanten Einfluss. Die Nullhypothese wurde abgelehnt

R bezieht sich auf den Unterschied von den Tatsächlichen Daten und den Vorhergesagten
Angepasste R^2 bezieht die Anzahl der Variablen ein um eine überschätzung zu vermeiden
Standardschätzfehler sagt uns um wie viel unsere Werte im Schnitt von den geschätzen Werten Abweichen