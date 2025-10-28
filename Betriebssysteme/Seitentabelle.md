![[Betriebssysteme 3.pdf#page=27]]
[[Vorlesung 7]]
32 Gb Ram / 4kb Page Size  = 8 * 2^20
-> 2^3 * 2^23 -> 23 Bit Rahmennummer die man für die Identifikation genutzt wird  

Caching Bit: Ob Zugriffe gespeichert werden dürfen
### Protectionsbits
Worauf schreibend zugegriffen wird und wo nicht, also lesend und schreibend
Bei 3 Bits
Lesend, Schreibend, Ausführen
##### M-Bit
Dirty Bit, Seite mit einem modified Bit gelöscht wird, muss sie zwingend gesichert werden, ansonsten können die Sachen einfach überschrieben werden
##### R-Bit
Referenc Bit
- Für das auslagern
- gibt an ob es in letzter Zeit genutzt wurde 
- Wird von der Betriebsystem ab und zu zurück gesetzt

### Paging beschleunigen
will man den Rahmen einer Page haben muss man einmal im Ram nachfragen wo der Frame ist
Durch Cachen?

Aber auch Translation Lookaside Buffer (TLB)
- Hardwar-Cache für wenige, häufig benutzte Seiten 
- man kann gültig und page in einem kombinieren und mit einer Suche beides Abfragen und dann nach Rechts weiter gehen+
![[Betriebssysteme 3.pdf#page=29]]


## Jetzt sind wir dran 
![[Betriebssysteme 3.pdf#page=30]]

- Virtuell 32 Bit
- physikalisch 24 Bit 
- Blockgröße von 16 KB

4 byte + 10 bit = 14
Virtuelle Adresse mit einer Blockgröße von 2^14 Byte 
2^32 - 2^14 = 2^18
Seitentabelle benötigt als 2^18 Einträge
Jede Seitentabelle enthält eine physikalische Seitenadresse 

physikalische Adresse ist 24 Bit groß, dabei ist die Blockgröße
24 -14 
also die Frame Nummer ist 10 Bit


32 Bit Adresse kommt an 
bestehen aus Seitennummer und Offset (Bestimmt Position relativ auf der Seite, relativ zu dem Rahmen) **Absolute Position wird im Rahmennummer/Seitenummer**
Das Offset reichen wir durch
-> 18 Bit Seitennummer + Offset (14 Bit auf die Blockgröße)
Da indexiert ist braucht man 2^18 Einträge in der Tabelle
Tabelle muss in den Hauptspeicher da die MMU dadrin nachschaut

Jeder eintrag in der Tabelle ist 32 Bit groß
2^18 * 32 Bit
2°18 * 2^2 Byte
2^20 Byte 
also 1 MB so groß ist die Seitenrahmtabelle

![[Betriebssysteme 3.pdf#page=31]]

Seitetabelle ist 4 Byte groß genau so wie oben (Bei weniger offset, mehr seitentabelle und somit mehr Platz wird weggenommen)
- 16 Bit Adressraum: 2^2* 4Byte  = 64 Byte
- 32 Bit Adressraum: 4 Mb
- 64 Bit Adressraum: 16 Petabyte 
Wir nutzen in der Praxis meist 48 Bit 


### Wir wollen Speicher flexibel haben 
Die meisten davon sind aber Leer  

![[Betriebssysteme 3.pdf#page=32]]

man nimmt den ersten Zack weg 
und nimmt 10 Bits zur Zuordnung
-> Die sagen welche Adresse in der ersten Indextabelle man nehmen 
	Der Verweißt einen auf die nächste Indextabelle
Die nächsten 10 Bits sagen einem welche innerhalb der Tabelle man nehmen soll
die restliche Bits sind offset
In der zweiten Tabelle wird dann auf dem Rahmen verwiesen
2^10 ein der ersten dann in 3 zweiten Tabelle je 2^10 -> 4kB  = 16 KB die man braucht