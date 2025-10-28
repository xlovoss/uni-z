![[Betriebssysteme 3.pdf#page=19]]

a) First Fit: Immer in die erste stelle die Frei ist
b) Best Fit: läuft so lange durch bis er den besten Platz findet
c) Worst Fit: Die größte Fläche die Frei ist und setzt sich rein, wenigster Verschleiß
Wenn es nicht passt:
- warten
- swapping 
- Lücke breiter machen, verschieben 
d) Next Fit: nächste passende Lücke (ausgehend von der letzten
Lücke)



## Virtueller Speicher
![[Betriebssysteme 3.pdf#page=21]]

Eigene Adressräume für jeden Prozess
Auslagern ist Swapping
Rechenzentren sind i/o intensiv

Speicher werden immer größer
Bei 32 Bit denkt der Speicher er hat 4 Gb Adressräumern

### physischer Speicher vs. virtueller Speicher
Programm denkt nur für sich, bei 64 Bit Programm 64 Bit Adressieren
Mithilfe einer Zuordnungstabelle wird der Übergang in den physischer Speicher ermöglicht 
Alles läuft mithilfe des Datenbus 
![[Betriebssysteme 3.pdf#page=23]]
MMu hat eigene Leitung
Wie viele Bits brauche ich um 64 kb adressieren = 16 Bit insgesamt


Platz den ich für ein Prozess brauche massiv geschrumpft 
für jede neuen Prozess muss die Seitentabelle neu berechnet werden
Seitentabelle liegt im Hauptspeicher am Anfang, 
MMU macht das Heutzutage, Daten liegen aber immer noch im Hauptspeicher
MMU initiiert sagt im RAM was sie haben will 



![[WhatsApp Image 2025-09-19 at 14.03.09.jpeg]]

![[Betriebssysteme 3.pdf#page=25]]

Hier hat er sehr lange drüber gesprochen, muss ich nacharbeiten 
Weniger Hauptspeicher als logischen Speicher habe
keiner hat 64 Bit Speicher heutzutage 

![[Betriebssysteme 3.pdf#page=26]]

 Hier hat er wieder viel erzählt 
 Ob die EInträge gültig sind oder nicht 
 Present und Absent Bits sind wichtig zur Identifikation, ist davor also löschen einfach das auf 0 setzen  