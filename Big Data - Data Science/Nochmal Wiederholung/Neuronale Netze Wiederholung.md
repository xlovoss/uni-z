Basieren auf Natürliche Neuronale Netze wie unsere Gehirne
Besteht aus Neuronen die zusammen ganz viel können


Neuronale Netze Networks haben ein typisches y = mx +b umzu funktionieren
Wir passen die Funktion so lange an bis wir die Parameter haben so ahben das es uns das Ergebnis liefert das wir brauchen

Das lernen funktioniert durch Gradient decent

Kanonen schießt 20 Mal mit unterschiedlichen Energien
mehr Energie = fliegt weiter

Also haben wir den unsere Echten Daten und dann haben wir noch unsere geschätzten Werte von der Maschine

Das Neuron merkt sich die Nummer des Parameters, was wir Gewicht nennen und einem initialen Wert von 1 und den Input den wir nehmen
![[Pasted image 20251014183110.png]]
Die gerade Linie ist von dem Neuronalen Netz und das Orangene sind die eigentlichen Daten

Jetzt wollen wir die Distanz anhand der Energie bestimmen 
Wir nehmen:
1. Irgendeine Energie aussuchen
2. Haben das Neuron was es bestimmt und einen Schätzwert raus gibt
3. Dann schießen wir mit der Kanone
4. Berechnen den Fehler 
5. Dann passen wir das Gewicht an (mehr oder weniger was die Lernrate ist)
Und lassen ihn sehr lange laufen bis wir eine Funktion haben die der Realität ähnelt


Falls sich unsere Kanone verschieben würde hätten wir ein neuronales Netz was die Anpassungen nicht lernen könnte, es könnte keine Funktion erstellen die passt, deswegen passen machen wir noch ein Bias hinzu

Den passen wir genauso an wie die die Gewichte an und wir kommen nicht an die Realität an weil wir es immer so wechseln das es beide gleichzeitig ändert

Wir denken jetzt das der Fehler eine Funktion des Gewichtes ist
Wobei wir es genauso anpassen wie bisher bevor
Problem ist nur bei mehr Energie, müssen wir mehr Anpassen. Deswegen beziehen wir den Anstieg mit ein an dem Punkt um es etwas ins Gleichgewicht zu bringen

Wir passen Bias und Gewicht anhand der Ableitung des Fehlers an. Die Fehler Grafik wir dann drei Dimensional und wir zur Fehler Landschaft

![[Pasted image 20251014190236.png]]

Jetzt läuft das so durch

Und dann suchen wir das Absolute Fehlergrafik

### Jetzt an Mangos
Wir wollen die Mangos anhand ihrer Länge bestimmen und sie dann zuordnen
![[Pasted image 20251014191356.png]]

Wir sammeln die Daten die wir haben
und dann Loopen wir es wieder
1. Suchen uns einen Datenpunkt
2. Lassen das Neuron es vorhersehen
3. Berechnen das Verlorene
4. Und passen den Parameter an
Zuerst schauen wir ob es TOmmy Mangos sind dann ist es 1 wenn nicht 0

Wir geben es den Anfang ein Gewicht und ein Bias 
Wir füttern es eine Länge und eine Sorte der Mangos kommt raus (1 oder 0)

Müssen es noch mit den Sigmoiden Funktionen skalieren und es verständigen machen 
![[Pasted image 20251014192006.png]]Du gibt der Funktion eine 2 und es spukt dir eine 0.88 aus

Dann machen wir wieder eine Fehlerfunktion mit einer Fehlerebene 
Mit 120000 Eingaben gibt  es dir zum ersten Mal eine Methode darauf zu kommen