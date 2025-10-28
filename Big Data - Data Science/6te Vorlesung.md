## Klären erstmal ein paar Begriffe die liegen geblieben sind

Sigmuide Funktione haben alles was wir zum Lebne brauchen
Konvex und Konkav und Linear 

**Feed Forward** - zufällig gewählten gewichte und liegen im neuronalen Netz meilenweit daneben 
-> "Gewichte, wie groß seid ihr gerade"
Gegeben es netz, steck x rein und schaue was für y raus kommen 

Numerische Minimierung einer Funktion

Funktion soll schrittweise maximiniert werden, durch Ableitung in der Tangente
Gradient ist der Vektor der ersten Ableitungen
![[Pasted image 20251014092122.png]]

Partizielle Ableitung
Geht darum das Maximum zu finden, weil wir die Funktion noch nicht kennen
Wir leiten nach den Gewichten ab und wollen das größte X finden

min die gewichte der Residuenquadrate  anhand der Summe aller Gewichte = [y i-F(xi,w)^2]

-> min Some of Squared Errors
Ich gehe nicht in die Mitte der Ableitungen wir brauchen den Gradienten dieser Funktion nach den Gewichten und daran passen wir die Funktion an

#klausur leiten die Gewichte ab nach der Funktionen
![[Pasted image 20251014093029.png]]Mithilfe der Verkettungen(Kettenregel) der 
Innere Ableitung * äußere Ableitung 
Summe zwei mal Residuen 
Innere Ableitung = f abgeleitet nach w 

Man bildet einen Gradienten über ein Teil der Datensätze und somit ein Teil der Gradientenabstieg 

Wir teilen den wirklichen Gradienten stochastischen 
Beispiel:
Wir haben 100 Datensätze
Davon eine echte Teilmenge von den Datensätzen
Wenn eine Gradiente dir Plus anzeigt, machen wir genau das Gegenteil 
ein Stochastiker Gradientenabstieg

Unter Schwachen der Gradienten
Sagt nochmal das Goodfellow wichtig ist

Zurück zum MLP

![[GML_06_01 ML.pdf#page=96]]

Je weniger Summanden wir haben, desto einfacher sollte es werden

![[GML_06_01 ML.pdf#page=99]]
Probleme:
Lokales Minimum finden und dann
Wir arbeiten immer mit dem Stochastiken Gradientenabstieg 
![[Pasted image 20251014095452.png]]

Das Orangene sin die Fehler der Trainingsdaten, wenn es wieder Ansteigt gehen wir zurück wo es 
- nicht mehr so viele Fehler sind
- Nach x Schritten lernt der Störterme Auswendig, dann sagt man eben 10 Davor

![[PYTPRA_02_01_PyTorch.pdf#page=2]]

Welche Verfahren kennen wir neben kleinste Quadrate:
Maximum Likelyhood

Warum Pytorch?
Mit zwei Zeilen ist man auf der CPU

Er erklärt jetzt wie man Pytorch machen kann 


![[PYTPRA_02_01_PyTorch.pdf#page=9]]


![[PYTPRA_02_01_PyTorch.pdf#page=11]]

Hier fügen wir das Durschnitssrauschen hinzu

![[Pasted image 20251014104936.png]]

Das was er merkiert hat: so definiert man Netze in Pytorch 
Lineares funktion mit Sigmoide Funktion
Ein einziges Neuron 
Genaue FUnktioen des Gradientenabstiegs
Squared Errors beduetet Residuen Quadrete 
Verlustfunktion wird minimiert


![[Pasted image 20251014110334.png]]

Sehr Gutes Lernverhalten es wurde kein Rauschen auswenig gelernt
Wenn nur ein Neuron vorhanden ist, kann er kein Rauschen auswendig lernen

Underfitting beugen wir vor indem wir eine Funktion hat die konvex, konkav und linaer ist 


Diagnostik 

![[PYTPRA_02_01_PyTorch.pdf#page=31]]



![[PYTPRA_02_01_PyTorch.pdf#page=45]]

Was spricht dagegen 200 Millionen hidden Neuronen zu nehmen
- viele Ressourcen
- Angst vor overfitting

