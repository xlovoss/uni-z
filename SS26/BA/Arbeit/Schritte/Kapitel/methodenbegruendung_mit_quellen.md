# Methodenbegründung mit Quellen

*Arbeitsgrundlage — Stand 04.08.2026. Alle Quellen wurden verifiziert; Seitenzahlen bitte vor Übernahme selbst prüfen.*

---

## Vorbemerkung: zwei Arten von Begründung

Nicht jeder Schritt braucht denselben Beleg. Unterscheide sauber, das erspart dir Nachfragen:

- **Fachliche Vorgaben** — Score-Stufen, Ausschlusskriterien, Stundenschwelle. Diese belegst du mit dem Praxispartner (Taxonomiedokument, Entscheidungsbaum, E-Mail-Antwort), nicht mit Literatur. Eine wissenschaftliche Quelle kann nicht sagen, ob KEX Volontariate ausschließt.
- **Methodische Entscheidungen** — Architektur, Verfahrenswahl, Evaluationsdesign. Hier brauchst du Literatur.

Wer versucht, eine Praxisvorgabe mit einem Paper zu begründen, argumentiert an der Sache vorbei. Umgekehrt genauso.

---

## 1. Das Drei-Tore-Prinzip

### Was es ist

Statt einem Modell, das in einem Schritt aus dem Anzeigentext eine von vier Klassen vorhersagt, prüft die Pipeline nacheinander drei getrennte Fragen:

```
Tor 1  Fachliche Relevanz    →  nein  →  "nicht relevant"
Tor 2  Lukrativität          →  nein  →  "ausgeschlossen"
Tor 3  Score                 →  hoch / mittel / niedrig
```

Jedes Tor beantwortet **genau eine** Frage, und wer an einem Tor scheitert, wird nicht weiter geprüft.

### Warum, in vier Argumenten

**(a) Es ist die Vorgabe.** Das stärkste Argument und das, mit dem du anfangen solltest: Der Entscheidungsbaum des Betreuers hat exakt diese Struktur. Die Architektur bildet die fachliche Entscheidungslogik ab, statt sie zu überschreiben. Der Betreuer hat schriftlich bestätigt, dass der Entscheidungsbaum gegenüber dem Taxonomiedokument maßgeblich ist.

**(b) Konstruktrennung.** „Fachlich passend" und „wirtschaftlich lukrativ" sind zwei unabhängige Konstrukte. Ein Museumspraktikum ist fachlich einwandfrei und scheitert nur an der Wirtschaftlichkeit. Presst man beides in ein Label, muss das Modell eine Disjunktion zweier unkorrelierter Konzepte lernen, und die Fehleranalyse wird unmöglich — bei einem Fehler weißt du nicht, welches der beiden Konstrukte falsch eingeschätzt wurde.

> **Jacobs, A. Z. & Wallach, H. (2021): Measurement and Fairness.** FAccT '21, S. 375–385.
> https://doi.org/10.1145/3442188.3445901 · Preprint: https://arxiv.org/abs/1912.05511
> *Wofür:* Unbeobachtbare Konstrukte werden über Messmodelle operationalisiert; Abweichungen zwischen theoretischem Konstrukt und Operationalisierung sind systematische Fehlerquellen. Genau dein Fall — „KEX-Fit" ist nicht direkt beobachtbar.

**(c) Hierarchische Klassifikation ist ein etabliertes Muster.** Deine Struktur entspricht dem „local classifier per node"-Ansatz: An jedem Knoten entscheidet ein eigener Klassifikator, und nachgelagerte Knoten sehen nur, was oben durchkam.

> **Silla, C. N. Jr. & Freitas, A. A. (2011): A survey of hierarchical classification across different application domains.** Data Mining and Knowledge Discovery 22(1–2), S. 31–72.
> https://doi.org/10.1007/s10618-010-0175-9
> *Wofür:* Systematik hierarchischer Klassifikationsansätze und ihrer Varianten. Damit kannst du deine Architektur benennen, statt sie zu erfinden.

**(d) Frühe Zurückweisung ist effizient.** Bei 29 Portalen ist die überwältigende Mehrheit der Anzeigen irrelevant. Ein billiges erstes Tor, das den Großteil aussortiert, spart teure Verarbeitung für den Rest.

> **Viola, P. & Jones, M. (2001): Rapid Object Detection using a Boosted Cascade of Simple Features.** CVPR 2001, Bd. 1, S. 511–518.
> https://doi.org/10.1109/CVPR.2001.990517
> *Wofür:* Klassische Begründung der Kaskadenarchitektur — einfache frühe Stufen verwerfen die meisten Negativen, aufwendige Stufen sehen nur den Rest.
> **Ehrlichkeit:** Das ist eine *Analogie*, keine Übertragung. Viola-Jones lernt seine Stufen und optimiert Rechenzeit bei der Gesichtserkennung. Deine Tore sind fachlich vorgegeben. Zitiere es für das Strukturprinzip, nicht als methodische Grundlage — sonst fragt jemand nach AdaBoost.

### Formulierungsvorschlag

> Die Pipeline folgt einer kaskadierten Architektur mit drei sequenziellen Entscheidungsstufen. Diese Struktur ergibt sich primär aus der fachlichen Vorgabe des Praxispartners, entspricht zugleich aber dem in der Literatur als „local classifier per node" beschriebenen Muster hierarchischer Klassifikation (Silla & Freitas, 2011). Die Trennung von fachlicher Relevanz und wirtschaftlicher Lukrativität in getrennte Stufen ist messtheoretisch motiviert: Beide Stufen operationalisieren unterschiedliche Konstrukte, deren Zusammenfassung in einer Zielvariable die Zuordnung von Fehlern zu Fehlerquellen verhindern würde (Jacobs & Wallach, 2021).

---

## 2. Gazetteer

### Was es ist

Ein Gazetteer ist eine **Liste bekannter Namen oder Begriffe einer Entitätsklasse**. Der Begriff kommt aus der Geografie — ein Gazetteer war ursprünglich ein Ortsnamenverzeichnis. In der Informationsextraktion heißt so jede Nachschlageliste: alle Städtenamen, alle Vornamen, alle Firmennamen. Bei dir: alle Institutionstypen, alle Aufgabenfelder, alle Leitungsbezeichnungen.

Technisch ist es simpel — ein Wörterbuchabgleich. Steht das Wort auf der Liste, wird es als Entität markiert.

### Warum das kein Rückschritt ist

Die naheliegende Kritik lautet: „Das ist doch nur eine Wortliste, kein maschinelles Lernen." Die Literatur ist da differenzierter.

> **Ratinov, L. & Roth, D. (2009): Design Challenges and Misconceptions in Named Entity Recognition.** CoNLL 2009, S. 147–155.
> https://aclanthology.org/W09-1119/ · PDF: https://cogcomp.seas.upenn.edu/papers/RatinovRo09.pdf
> *Wofür:* **Deine zentrale Quelle zu Gazetteers.** Zwei Aussagen, die du brauchst: (1) NER ist eine wissensintensive Aufgabe, und externes Wissen ist entscheidend für die Leistung. (2) Reines Nachschlagen scheitert an Abdeckung und Mehrdeutigkeit — der Nutzen entsteht, wenn Gazetteer-Treffer als *Merkmale* in ein lernendes Modell eingehen.

Das ist exakt dein Argument: Der Gazetteer ist die Baseline und liefert Merkmale, er ersetzt das Modell nicht.

> **Nadeau, D. & Sekine, S. (2007): A Survey of Named Entity Recognition and Classification.** Lingvisticae Investigationes 30(1), S. 3–26.
> https://doi.org/10.1075/li.30.1.03nad · PDF: https://nlp.cs.nyu.edu/sekine/papers/li07.pdf
> *Wofür:* Überblick über die Entwicklung von handgeschriebenen Regeln hin zu lernenden Verfahren. Gut für den einordnenden Absatz, in dem du erklärst, wo dein Ansatz im Feld steht.

### Dein empirischer Beleg — der wertvollste Teil

Du hast selbst gemessen, wo der reine Gazetteer scheitert. Zwei konkrete Fälle aus dem Bestand vom 21.07.:

| Anzeige | Gazetteer enthält | Im Text steht | Problem |
|---|---|---|---|
| Leitung der Stadtbibliothek | „Bibliothek" | „Stadtbibliothek" | Komposition |
| Projektmanager:in, Staatliche Museen Berlin | „Museum" | „Museen" | Flexion |

Beide Fälle wurden nicht erkannt. Das ist ein **selbst erhobener Beleg** für die Abdeckungsgrenze, die Ratinov & Roth beschreiben — und er wiegt in einer Bachelorarbeit mehr als jedes Zitat. Deutsche Komposita und Flexion sind der Grund, warum du Lemmatisierung und Subword-Verfahren brauchst.

> **Bojanowski, P., Grave, E., Joulin, A. & Mikolov, T. (2017): Enriching Word Vectors with Subword Information.** TACL 5, S. 135–146.
> https://doi.org/10.1162/tacl_a_00051 · https://arxiv.org/abs/1607.04606
> *Wofür:* Das fastText-Paper. Wortvektoren aus Zeichen-n-Grammen, dadurch für unbekannte Wörter und morphologische Varianten belastbar — genau dein „Museen/Museum"-Problem. Das ist der Beleg dafür, warum fastText und nicht Word2Vec.

---

## 3. EntityRuler

### Sei hier ehrlich: das ist ein Werkzeug, keine Methode

Der `EntityRuler` ist eine **Komponente der Software-Bibliothek spaCy**. Dafür gibt es keine wissenschaftliche Publikation, und du solltest auch keine erfinden. Er belegt Muster über Tokens und markiert Treffer als Entitäten.

Du zitierst also:

> **Honnibal, M., Montani, I., Van Landeghem, S. & Boyd, A. (2020): spaCy: Industrial-strength Natural Language Processing in Python.**
> https://doi.org/10.5281/zenodo.1212303 · Dokumentation: https://spacy.io/api/entityruler

Das methodische Verfahren dahinter heißt **regelbasierte bzw. wörterbuchbasierte Entitätenerkennung** — und *dafür* gibt es Literatur:

> **Chiticariu, L., Li, Y. & Reiss, F. R. (2013): Rule-Based Information Extraction is Dead! Long Live Rule-Based Information Extraction Systems!** EMNLP 2013, S. 827–832.
> https://aclanthology.org/D13-1079/
> *Wofür:* Dokumentiert die Kluft zwischen Forschung und Praxis — regelbasierte Extraktion dominiert kommerzielle Systeme, gilt in der Wissenschaft aber als überholt. Gründe sind Nachvollziehbarkeit, gezielte Fehlerkorrektur und Wartbarkeit. Das ist dein Hauptbeleg für die Regelschicht.

### Der Wartbarkeitsbeleg kommt aus deinem eigenen Material

Das Taxonomiedokument fordert unter „Pflegehinweise" ausdrücklich, dass die Taxonomie „regelmäßig anhand echter Fehlklassifikationen geschärft" wird. Eine Regeländerung ist ein Eintrag in einer JSON-Datei; dieselbe Änderung an einem feingetunten neuronalen Modell erfordert Neuannotation und Neutraining. **Die Wartbarkeitsanforderung des Praxispartners ist selbst das Argument für die Regelschicht.**

### Formulierungsvorschlag

> Die Signalextraktion erfolgt in einer ersten Stufe wörterbuchbasiert über den EntityRuler der Bibliothek spaCy (Honnibal et al., 2020). Die Wahl eines regelbasierten Verfahrens für die harten Ausschlusskriterien ist nicht als Verzicht auf maschinelles Lernen zu verstehen, sondern folgt der von Chiticariu et al. (2013) beschriebenen Praxisrationalität: Nachvollziehbarkeit und gezielte Korrigierbarkeit sind hier gegenüber marginalen Genauigkeitsgewinnen vorrangig, zumal der Praxispartner die fortlaufende Anpassbarkeit der Kriterien ausdrücklich einfordert.

---

## 4. Vergleich Betreuer-Labels gegen Modellvorhersage

Hier liegen die meisten Fallstricke. Vier Punkte, die du sauber trennen musst.

### 4.1 Es ist kein Goldstandard, es ist ein Silberstandard

Ein Goldstandard setzt mehrere unabhängige Annotatoren und ein berichtetes Übereinstimmungsmaß voraus. Bei dir hat eine Person entschieden, ohne dokumentierte Begründung und ohne Zweitprüfung. Das ist ein **Silberstandard**. Nenne es so — das ist keine Schwäche, sondern Präzision.

> **Artstein, R. & Poesio, M. (2008): Inter-Coder Agreement for Computational Linguistics.** Computational Linguistics 34(4), S. 555–596.
> https://doi.org/10.1162/coli.07-034-R2 · https://aclanthology.org/J08-4004/
> *Wofür:* Die Standardreferenz zu Übereinstimmungsmaßen. Warum reine Übereinstimmungsquoten irreführen, wie Kappa und Krippendorffs Alpha funktionieren, wie man Werte interpretiert.

**Die praktische Konsequenz:** Die Modellgüte ist nach oben durch die Annotationsqualität begrenzt. Ein Modell kann nicht konsistenter sein als die Daten, aus denen es lernt. Deshalb der Vorschlag, 100 Anzeigen selbst blind einzuordnen und die Übereinstimmung zu berechnen — das liefert dir diese Obergrenze als Zahl statt als Vermutung.

### 4.2 Du hast nur Positivbeispiele — das hat einen Namen

Max' Listen enthalten ausschließlich übernommene Stellen. Die verworfenen wurden nie festgehalten. Das ist keine Randnotiz, sondern eine eigene Lernsituation mit eigener Literatur:

> **Bekker, J. & Davis, J. (2020): Learning from positive and unlabeled data: a survey.** Machine Learning 109(4), S. 719–760.
> https://doi.org/10.1007/s10994-020-05877-5 · https://arxiv.org/abs/1811.04820
> *Wofür:* Systematischer Überblick über PU-Learning. Wichtig für dich ist vor allem die **SCAR-Annahme** (selected completely at random): Die Standardverfahren setzen voraus, dass die beobachteten Positiven zufällig aus allen Positiven gezogen wurden. Bei dir gilt das nachweislich **nicht** — die Sichtung erfolgte spartenspezifisch und wurde laut Betreuer „meist vernachlässigt".

> **Elkan, C. & Noto, K. (2008): Learning classifiers from only positive and unlabeled data.** KDD '08, S. 213–220.
> https://doi.org/10.1145/1401890.1401920
> *Wofür:* Grundlegendes Verfahren, um aus PU-Daten kalibrierte Wahrscheinlichkeiten zu gewinnen.

Nach dem Nachscrapen bist du formal im PU-Fall: bekannte Positive plus eine große unbeschriftete Menge, die überwiegend, aber nicht ausschließlich negativ ist. Diesen Umstand offen zu benennen, ist deutlich stärker, als so zu tun, als hättest du saubere Negativbeispiele.

### 4.3 Die Regelschicht ist deine Baseline, und sie muss ernst genommen werden

Wenn du in Schritt 5 ein gelerntes Modell einsetzt, musst du zeigen, dass es der Regelschicht überlegen ist. Sonst hat der Aufwand keinen belegten Nutzen.

> **Ferrari Dacrema, M., Cremonesi, P. & Jannach, D. (2019): Are We Really Making Much Progress? A Worrying Analysis of Recent Neural Recommendation Approaches.** RecSys '19, S. 101–109.
> https://doi.org/10.1145/3298689.3347058 · https://arxiv.org/abs/1907.06902
> *Wofür:* Zeigt, dass ein großer Teil publizierter neuronaler Verfahren von sorgfältig abgestimmten einfachen Baselines geschlagen wird. Der beste verfügbare Beleg dafür, warum eine starke Baseline methodisch unverzichtbar ist — und warum es kein Makel wäre, wenn deine Regelschicht gewinnt.

### 4.4 Metrikwahl bei starkem Ungleichgewicht

Bei neun relevanten Stellen auf vielleicht zweitausend Anzeigen ist Accuracy wertlos — ein Modell, das immer „nicht relevant" sagt, käme auf über 99 Prozent.

> **Saito, T. & Rehmsmeier, M. (2015): The Precision-Recall Plot Is More Informative than the ROC Plot When Evaluating Binary Classifiers on Imbalanced Datasets.** PLoS ONE 10(3): e0118432.
> https://doi.org/10.1371/journal.pone.0118432
> *Wofür:* **Direkt einschlägig für deine Randnotiz zu Gini und AUC-ROC.** ROC-Kurven wirken bei stark unausgewogenen Daten optimistisch, weil die große Zahl echter Negativer die Falsch-Positiv-Rate dämpft. Precision-Recall-Kurven bilden die Leistung auf der seltenen Klasse realistischer ab. Berichte beides und begründe mit dieser Quelle.

Für die ordinale Score-Stufe:

> **Cohen, J. (1968): Weighted kappa: Nominal scale agreement with provision for scaled disagreement or partial credit.** Psychological Bulletin 70(4), S. 213–220.
> https://doi.org/10.1037/h0026256
> *Wofür:* Gewichtetes Kappa. In quadratischer Gewichtung (Quadratic Weighted Kappa) das Standardmaß für ordinale Skalen — es bestraft die Verwechslung „hoch ↔ niedrig" stärker als „hoch ↔ mittel".

### 4.5 Datenqualität als Projektrisiko

> **Sambasivan, N., Kapania, S., Highfill, H., Akrong, D., Paritosh, P. & Aroyo, L. M. (2021): "Everyone wants to do the model work, not the data work": Data Cascades in High-Stakes AI.** CHI '21, Artikel 39.
> https://doi.org/10.1145/3411764.3445518
> *Wofür:* Datenqualitätsprobleme am Anfang einer Pipeline verstärken sich stromabwärts und werden spät und teuer sichtbar. Passt exakt auf deine Situation — fehlende Negativbeispiele, undokumentierte Ausschlussgründe, unregelmäßige Sichtung.

---

## 5. Für den deutschen Sprachraum

> **Gnehm, A.-S., Bühlmann, E. & Clematide, S. (2022): Evaluation of Transfer Learning and Domain Adaptation for Analyzing German-Speaking Job Advertisements.** LREC 2022, S. 3892–3901.
> https://aclanthology.org/2022.lrec-1.414/
> *Wofür:* Die einschlägigste Arbeit für dein Vorhaben. Domänenadaptierte Modelle generalisieren nachweislich besser auf abweichenden Daten als nicht adaptierte Transformer — bei 29 heterogenen Portalen dein Hauptargument für weiteres MLM-Pretraining auf unbeschrifteten Stellenanzeigen.

Für die Einordnung ins internationale Feld:

> **Zhang, M., Jensen, K. N., Sonniks, S. D. & Plank, B. (2022): SkillSpan: Hard and Soft Skill Extraction from English Job Postings.** NAACL 2022.
> https://aclanthology.org/2022.naacl-main.366/

> **Zhang, M., van der Goot, R. & Plank, B. (2023): ESCOXLM-R: Multilingual Taxonomy-driven Pre-training for the Job Market Domain.** ACL 2023.
> https://arxiv.org/abs/2305.12092
> *Nützliche Zahl:* Der Stand der Technik auf SkillSpan liegt bei rund 62 F1. Damit kannst du Erwartungen kalibrieren — Extraktion aus Stellenanzeigen ist auch für Spitzenmodelle schwer.

---

## 6. Zuordnungstabelle für dein Methodikkapitel

| Schritt | Art der Begründung | Beleg |
|---|---|---|
| Drei-Tore-Architektur | Vorgabe + Methode | Entscheidungsbaum; Silla & Freitas 2011; Jacobs & Wallach 2021 |
| Trennung Relevanz / Lukrativität | Methode | Jacobs & Wallach 2021 |
| Frühe Zurückweisung | Methode (Analogie) | Viola & Jones 2001 |
| Minimale Vorverarbeitung vor NER | Methode | Ratinov & Roth 2009 (Wissensintensität, Merkmalserhalt) |
| Gazetteer als Baseline | Methode | Ratinov & Roth 2009; Nadeau & Sekine 2007 |
| Regelschicht für harte Kriterien | Methode + Vorgabe | Chiticariu et al. 2013; Pflegehinweise der Taxonomie |
| fastText statt Word2Vec | Methode | Bojanowski et al. 2017; eigene Fehlerfälle |
| Domänenadaption GBERT | Methode | Gnehm et al. 2022 |
| Silberstandard, Kappa | Methode | Artstein & Poesio 2008 |
| Umgang mit Positiv-only-Daten | Methode | Bekker & Davis 2020; Elkan & Noto 2008 |
| Baseline-Vergleich | Methode | Ferrari Dacrema et al. 2019 |
| PR-AUC statt nur ROC-AUC | Methode | Saito & Rehmsmeier 2015 |
| Ordinale Bewertung | Methode | Cohen 1968 |
| Datenqualität als Limitation | Methode | Sambasivan et al. 2021 |
| Score-Stufen, Ausschlusskriterien, 25-h-Schwelle | reine Vorgabe | Taxonomiedokument, Entscheidungsbaum, E-Mail 08/2026 |

---

## 7. Drei Dinge, die du nicht belegen kannst — und offen sagen solltest

1. **Die Score-Schwellen** („mindestens 3 von 4 Dimensionen") sind aus den zehn Beispielen in Tabelle 7 rückwärts kalibriert. Keine Theorie dahinter. Als empirisch zu validierende Startwerte deklarieren.
2. **Der Konformitätstest mit 14/14** prüft die Übereinstimmung von Implementierung und Spezifikation, nicht die Leistung. Als Regressionstest benennen, nicht als Ergebnis.
3. **Die 9/9 auf den echten Anzeigen** sind nach Anpassung der Wortliste entstanden. Der belastbare Messwert war 7/9. Beide Zahlen nennen und den Unterschied erklären — das ist ein Qualitätsmerkmal, kein Eingeständnis.
