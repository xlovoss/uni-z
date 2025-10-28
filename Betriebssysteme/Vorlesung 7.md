#betryb

## Widerholung 
## Virtueller Speicher und Paging
- Paging
	- nur gewisse Teile des Hauptspeicher werden wirklich eingeladen+
	- Ein und Auslagern von den einzelnes Pages (ähnlich zu swapping)
	- nicht komplette Prozesse
	- bspw.
		- Adressraum
		- Mehr vom Prozess adressieren können als wir Speicher haben
		- Kann 64 Kb verwalten dynamisch und skalierbar
		- 2^12
		- Soll ich wissen was drüber steht
		- -> Interne Fragmentierung 
	- Adresse aufgeteilt 
		- Ersten paar Bits -> gibt page an, wird in Frame umgerechnet und ist auch danach oft kürzer
		- der Rest gibt an welche adresse in der Page/ Frame die bleiben einfach da 
		- In der Umwandlungstabelle ist der Index die page, wert der frame und es gibt noch Gültigkeits bit
		- Datenbus liefert dann den Frame und die CU ist Happy
[[Seitentabelle]]

[[Probeaufgabe]]

[[Seitenersetzungsalgorithmen]]


