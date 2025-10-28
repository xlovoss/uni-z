---
tags:
  - betrisys
---
[[WS25/Betriebssysteme/1. Vorlesung|1. Vorlesung]]
[[Historie Betriebssystem]]

## Von Neumann Architektur
5 Komponente
- Speicherwerk(bspw. ROM/PROM)
- Rechenwerk (CU / Control Unit )
- BUS (Verbindung)
- I/O Unit - Eingabe/Ausgabewerk
- Rechenwerk (ALU - Arithmetische Logik Unit)
![[Von-Neumann_Architektur.svg.png]]

#### Bus
-> Leitungen die verschiedene Haltstellen hält
Parameter wird als Bit angegeben 
- Datenbus  (Parallelisierung von x Bits bei, je breiter desto Schneller und gleichbleibenden Takt)+
	- Ist Bidirektional
- Steuerbus
- Adressbus (in bit Anzahl an Adressen die ich ansprechen kann )
	- Unidirektional -> Chef sagt ist so dann ist so 

Betriebssysteme von 64 ist schon Absurd groß  2^2 x 2^60 Byte 
cache

### 5 Merkmale 
1. Universalmerkmale (aufbau)
2. binäre Zahlendarstellung
3. Struktur ist unabhängig von de zu bearbeiten Darstellung
4. Programme und Daten liegen im gleichem Speicher
	bei Harvard sind die getrennt, man kann iht gleichzeitig einlesen und auslesen
5. Befehle geben nur die Speicheradresse an, wo die Daten abgelegt sind 



Beim Start wird Programmzähler erstmal resettet 
DAs wird zum Bus geschickt und der lädt das in den Speicher auf der Speicherstelle 0
Die Daten werden dann auf den Datenbus gehauen, das geht dann ins Befehlsregister im Befehlsregister
Das muss erstmal dekodiert werden im Befehlsprozessor
IDA 202 geht an Adressbuch Speicher und an die stelle 202
Die Daten gehen auf den Datenbus und das schreibt man in den Akkumulator im Datenprozessor

ALU(Arithmetische Logical Unit) kann nichts selber 
![[Betriebssysteme 1.pdf#page=27]]


wir stellen in der ALU ein was wir machen wollen 

![[Betriebssysteme 1.pdf#page=33]]



