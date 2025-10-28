[[Pipelining]]

Pogramm vs Prozess
	Programm -> läuft nicht, ist nur das Rezept
	Prozesse -> werden ausgeführt, wie es das Rezept vorschreibt
	ein Programm hat mind. ein Prozess
![[Betriebssysteme 1.pdf#page=42]]

Multiprogrammiersys -> verschiedene Prozesse zwischen den man Wechselt, immer nur ein gleichzeitig
Multiprozessorsysteme -> eng vs lose gekoppelt [[Aufbau von Computersystem]]

## Prozesse 
Softwar ist eine Menge von sequentiellen Prozessen 
ein Kern kann immer nur ein Prozess gleichzeitig

## Wie geht das
Irgendwie muss man ja wissen welche Adressen und Daten zu welchen Prozess gehören 
-> Man merkt sich eine prozessID um jeden Prozess zu identifizieren
Leerlaufprozess läuft immer wenn gerade nichts zu tun ist 

## Beispiel
Heuser spielt mit 8 Leuten gleichzeitig Schach, jeder Schachzug ist ein Prozess den er Abläuft 
Gibt nur einen mit dem er aktiv spielt 
Ein Prozess ist im 
- start (Brett ist aufgebaut)
-  ready (wartet auf die CPU)
- running (man macht sein Zug)
- blocked (nur aus dem running aus ansteuerbar und geht in ready zurück)
- terminated  

Ich merke mir wer sitzt wo (PIT)
## PCB
Stellt virtuell einen Kern da
- PID
- Prozesszustand
- Befehlszähler
- Registerinhalte 
- Zugriffsrecht
- belegte Betriebsmittel
- Belegung der Variablen


Premptive Multitasking
- man hat einen Prozess der Zeugs koordiniert damit kein deadlock zustande kommt
- sagt wann man weg muss un dwer aus der Wartschlange nachrückt, ist nicht immer first come first serve

#### interrupt
bspw. der prozess ist blocked da man auf den user input wartet wie kriegt er den Tastendruck mit 

-> drückt auf die Tastatur schickt diese einen interrupt an die CPU 
-> CPU beendet die Arbeit(speichert alles gescheid ) umgehend
-> CPU liest tastatur daten und speichert sie ab
-> Prozess wird auf ready gesetzt 
-> ist der Prozess wieder dran arbeitet die CPU weiter 
Interrupts laufen außerhalb diesen Zustands 
Interrupts geben Bescheid wann Ressourcen auf dem gewartet wurde bereits stehen und geht damit von blocked auf ready

Interrupts Service Route 
sorft dafür das ein Prozess der running ist nach der interrupt bearbeitung wieder wie vor weiter laufen kann
-> Speicher alle zustände ab und stellt sie nachher wieder her 
![[OIP.jpg]]