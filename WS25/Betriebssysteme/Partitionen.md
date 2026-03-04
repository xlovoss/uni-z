[[Vorlesung 8]]

Heißt wir teilen den physischen Datenträger in Verschiedene Laufwerke ein

![[Betriebssysteme 4.pdf#page=27]]
Offset ist hier der Beginn der Partizipation
Innerhalb einer Partition steht jetzt drin wie 

![[Betriebssysteme 4.pdf#page=29]]

Habe eine Datei A die 4 Blöcke Groß ist die 16 kb (4 * 4) auf dem Datenträger belegt
Brauche das um zu definieren innerhalb des Blockes anzukündigen wo denn Schluss ist, jeder Block auszuwerten ist viel zu Anstrengend.
Blöcke nur nach dem  Prozess neu zu legen, Logik die man auf Bandlaufwerke hat 

Datein werden vorher sortiert und dann zusammengelegt und in einem Schwub weggeschickt


![[Betriebssysteme 4.pdf#page=30]]
Dateien werden nicht mit Startpunkt gespeichert sondern in Form einer verketteten Liste

Immer hin und herspringen ist sehr Anstrengend
Die meisten Festplatten haben nicht 2 
Man muss von der 4 auf die 7 springen
Man muss erst den ersten Block einlesen

Wegen den Nachteilen:

![[Betriebssysteme 4.pdf#page=32]]

Wo geht denn diese Datei hin
Ich muss nur hergehen und mir diese Tabelle anschauen
==FAT==  Startblock haben wo es losgeht die Infos
Gesamter Block zur Festplatte zu Daten in Verfügung
512 das ist so klein 
Wahl ist Frei
Man indexiert jeden Block in der Festplatte -> führt dazu das man zu viele Einträge bekommt bei zu kleiner Blockgröße