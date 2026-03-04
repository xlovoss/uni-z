
[[Vorlesung 7]]
Nur dann eine Relevanz wenn mein Hauptspeicher nicht mehr 

![[Betriebssysteme 3.pdf#page=34]]


Was wenn eine Seite nur sich selber verweist
- Der optimale Algorithmus wählt die Seite, deren Aufruf am weitesten in der Zukunft liegt.
Eigentlich möchte ich ein Rausschmeißen 
## Strategien
- First in First out 
- Second Chance Algorithmus
- -> Die Geladene Seite werden mit einem Zeit Stempel des Einlagerungszeitpunkts in einer FIFO Datenstruktur gespeichert (Sind nach dem Zeitpunkten gespeichert)
Prüfung des R-Bits
0: ist alt und gammelige und wird entfernt
1: das R-Bit wird auf 0 gesetzt und an das Ende verschoben


- Net Recently USed Algorithmus
![[Betriebssysteme 3.pdf#page=37]]

Ich schemeiß die letzten raus die ich die letzten 20 Sekunden benutzt habe 

![[Betriebssysteme 3.pdf#page=39]]

Wir schreiben bei jeder Nutzung rein