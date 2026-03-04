[[Vorlesung 7]]
Erklärung: [[Seitentabelle]]
![[Betriebssysteme 3.pdf#page=33]]

Virtuelle 32 Bit Adresse
physikalsiche 24 Bit Adresse
Blockgröße von 16 KB

einstüfige Adresse :
4 byte + 10 bit = 14 Bit 
Virtuelle Adresse mit einer Blockgröße von 2^14 Byte 
2^32 - 2^14 = 2^18
Seitentabelle benötigt als 2^18 Einträge
Jede Seitentabelle enthält eine physikalische Seitenadresse 

Zweistufig:
9 Bit + 9 Bit 
 2^9* 4 Byte = 2^11 Byte = 2 kb * 2 weil 2 Tabelle
 
  ## Wie viel RAM?
 es gibt Rahmen in RAM
 Das hat 16 kb und ist danach voll, passt nicht mehr rein 
 Wir packen nur 2 kb rein und es immer danach voll, somit ein verschnitt von 14 kb 

Was 
![[Pasted image 20250922145419.png]]



![[Betriebssysteme 3.pdf#page=40]]

Erklärung auf [[Seitenersetzungsalgorithmen]]

FIFO 3
NRU 2
LRU 1 (da 265 zuletzt genutzt wurde )
Second Chance (FIFO ergänzt zuletzt benutzt also 2)

Dabei wird NRU am meisten und Second Chance auch genutzt

![[Betriebssysteme 3.pdf#page=47]]

# a)
Seiten werden ineffizient gespeichert
Seitentabelle wird so groß das wir es nicht mehr in den Speicher legen können
Indexiert über Adressbereich des Speichers 
1 Seite inhaltsübersicht
Dort später liegen dann die Kapitel drin
Insgesamt spart man Speicherplatz, Inhaltstabelle wird aufgeteilt

zweistufig ist eigentlich nur x+y
x sagt dir auf einer Seite die in y ist, die wieder auf einen Rahmen in einem Projektspeicher verweist


# b) #klausur
virtuelle 38 Bit  (ist interessant)
physische 32 Bit (Ist eigentlich egal)
Seitengröße von 14 Bit (Adresse ist so groß und hinter jeder Adresse steht ein Byte )
(Das es 4 Byte sind müssen wir wissen auf der ersten Seite)

Rechnung:
38 Bit virtuell zusammengesetzt aus der Seitennummer und das Offset 
Offset braucht 14 Bit aus 16 Kb Seite (Sollte bekannt sein)
38 - 14 Bit sind 24 Bit 

Die Frage ist wie viele interne Fragmentierung habe ich 

Von der ersten haben wir immer nur eine es würde sich hier lohnen 
 16kbyte/4Byte = 4k = 2 bit +10Bit = 12 Bit für die zweite Seite 

Eine Zweistufige Tabelle ergibt nur Sinn wenn es effizienter gespeichert wird die Lesegeschwindigkeit
Und wird von der MMU ausgewertet 
TLB wichtig sehhhhhhhr  wichtig für Klausur !!!!!!! :)

Das Betriebssystem gaukelt uns vor das wir alles von den 4gb wirklich nutzen 




