
![[GML_06_01 ML.pdf#page=84]]

Die Neuronale waren anfänglich eine relative Enttäuschung in der Geschichte
Wir testen an künstlichen Gehirnen, dabei wechselt das oft von inaktiv in aktiv
und das heißt dann #Sigmuid = logistische

#### sein Job, Problem der feature Selection
Er sollte entscheiden ob der DAX gekauft oder verkauft werden sollen
Dabei waren alle Größen wichtig 
Er hat 236 potentielle Inputs gefunden
konnte sie auf 18 Inputs durch 9 Informationen runter brechen

Hatte am ende 3 gute Modelle, die gleichwertig waren
er hat denjenigen genommen mit den wenigsten Parametern
Das sagt dann so, wenn Japan positiv ist, dann wird Europa auch positiv sein werden 

Wir transferieren die y Werte auf 0 bis 1 
Der Gewichtsvektor wird in die Sigmuide Funktion

![[GML_06_01 ML.pdf#page=88]]
ein Neuronales Netz basiert auf eine Abfolge von Linearen und Sigmuiden Funktionen 

Neuronen sind auf der X versteck und das nennt man hidden layer 

Kann ich mit der einfacher Netzarchitekur was Reisen?
Japp ziemlich gut, wenn sie unstetig ist, brauche ich eine zweite hidden Schicht 
Modelform heißt einfach das was raus kommt
Wir fangen einfach an mit einem hidden neuron (normales neuron, das von inaktiv auf aktiv springen kann, nichts anderes als die logistische Funktion)
Beim gewichtet entsteht ein Skalarprodukt

![[GML_06_01 ML.pdf#page=94]]

Hier erklärt er viel
Die Residuen quadrate werden noch halbiert
Machen die erste 

![[GML_06_01 ML.pdf#page=95]]Hier rechnen wir nach nur ein single hidden neuron
Prozess heißt feedforward 

![[GML_06_01 ML.pdf#page=103]]

So sieht das dann aus 
Funktion mit drei parametern wobei man nur den median von x2 und x3 nimmt, dann komme sowas wie wir bei x1 sehen (genauso wie bei den anderen)
Es hat erkannt das x3 für die Mülltonne ist 

![[GML_06_01 ML.pdf#page=105]]

Das empfielt er uns zu kennen, er weiß jetzt das x quadratisch ist, bei MLP finden Spezifikationen und Schätzungen simultan statt. 
### Doch ein Theorem

![[GML_06_01 ML.pdf#page=107]]

DGP = Daten genierter Prozess
uiv = unabhängig und identisch verteilt 
wahre Gewicht W
Welche Annehmen müssen wir machen um uns an dem Theorem zu erfreuen
Mit mehr hidden neuronen wird es wieder schlechter 

![[GML_06_01 ML.pdf#page=118]]

Wenn die MLP vom Rauschen mitlernen ist es Overfitting 

y = f(x,w) + e 
w ist hierbei eine Gewichtsmatrix zur parametrisierung x 

![[GML_06_01 ML.pdf#page=119]]

Ist auch die Lösung von links nach rechts 

wenn man sich zwischen Underfitting und Overfitting entscheidet ist es wie zwischen Pest und Cholera entscheiden 
Daten die wir beobachten x und y ist
Underfitting =  Gewichtsmatrix w zu knapp wähle 
Overfitting = Wenn die realisation der Störterme mitlernen, bei 20 hidden neuronen um jeden Punkt in der Vergangenheit zu lernen (Dann lernt das Modell nur auswendig, wenn zu viele Modellparametern hat)


