[[Vorlesung 9 - Praxis]]

Paging  #klausur 
Kommt auf jeden Fall dran

![[Betriebssysteme 4.pdf#page=32]]


Zuordnungseinheit muss größer werden
Interne vs. Externe Fragmentierung

Sogenannte I-Nodes 
![[Betriebssysteme 4.pdf#page=34]]

Wo liegt die Datei 
Im Plattenblock 0 steht drin das da Adresse 4 ist (Pointer)
Wir zeigen auf einen I-Node 

Wie groß kann so eine Datei sein
8 Blöcke * 4 kB = 32 kB

Letzter Block  zeigt auf eine Adresse die auf einen neuen Block zeigen
Einstufige Adressierung 
Der neue Block kann 1024 Einträge habe, die alle 4 kb groß sein können
Also insgesamt 4128

Ich setze einen pointer auf Liste von Pointern die auf eine Liste von Pointern die auf dann die Datengröße Zeigt

Also 
1024* 1024* 4kB  = 4GB
Deswegen sind das die Maximale Größe von Daten