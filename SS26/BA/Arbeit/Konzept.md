Was und warum das und nichts anderes





Mithilfe NLP (Regex oder ML) [[Input]] bekommen -> Entity Matching für Rechtschreibfehler-> Relevanz-Scoring beim Matching -> Dubletten-Check -> Scoring -> Output in form von X Datei



**1. Input-Extraktion & Systematisches Data Cleansing**

- **Zweck:** Rohdaten aus 29 Stellenbörsen einlesen und für die maschinelle Verarbeitung standardisieren.
    
- **Methode:** Zunächst werden strukturierte Felder (Gehalt, Ort) via Regex extrahiert. Der unstrukturierte Freitext (Jobbeschreibung) durchläuft eine strikte NLP-Bereinigungspipeline:
    
    1. Entfernung von HTML-Tags.
    2. Entfernung von Non-ASCII-Sonderzeichen und Satzzeichen.
    3. Transformation in Kleinbuchstaben (Lower Casing).
    4. Herausfiltern bedeutungsloser Stoppwörter.

### 2. Named Entity Recognition (NER) & Normalisierung

**Zweck.** Extraktion der vier Bewertungsdimensionen der KEX-Taxonomie aus dem Anzeigentext: Institutionstyp, Aufgabenprofil, Fachrichtung sowie Seniorität/Beschäftigungsumfang. Abweichend vom ursprünglichen Entwurf ist das Ziel nicht die Extraktion von Skills im Sinne einer Kompetenztaxonomie (z. B. ESCO). Die gelieferte Taxonomie ist eine Entscheidungsrubrik, keine Entitätenliste. Das NER-Ergebnis ist daher kein Endergebnis, sondern der Merkmalsvektor für die Relevanzentscheidung in Schritt 5.

**Vorverarbeitung.** Für die NER-Stufe erfolgt nur eine minimale Bereinigung: Entfernung von HTML-Tags, unsichtbaren Trennzeichen (Soft Hyphens, in Portalen für den Blocksatz verbreitet) und Whitespace-Normalisierung. Kein Lowercasing, keine Stoppwort- oder Satzzeichenentfernung — die Großschreibung ist im Deutschen das stärkste Substantivmerkmal, der Satzkontext ist für kontextuelle Modelle notwendig. Die aggressive Bereinigung aus Schritt 1 gilt ausschließlich für die Bag-of-Words-Repräsentation in Schritt 5.

**Trennung zweier Teilaufgaben.** Die Extraktion (Span Detection: wo steht eine Entität) wird von der Normalisierung (Entity Linking: welchem Taxonomiebegriff entspricht sie) getrennt. Diese Unterscheidung entspricht der in der Literatur üblichen Trennung von _skill extraction_ und _skill classification_.

**Methode, dreistufig.**

1. _Gazetteer-Baseline._ Wörterbuchbasierte Erkennung über den EntityRuler von spaCy mit einer aus der Taxonomie abgeleiteten Begriffsliste. Liefert den Referenzwert, gegen den das gelernte Modell antreten muss. Regelbasierte Extraktion ist in der Praxis wegen Nachvollziehbarkeit und Wartbarkeit dominant (Chiticariu et al., 2013); die Pflegehinweise der Taxonomie fordern genau diese Anpassbarkeit.
2. _Trainiertes NER._ Eigenes Labelset im BIO-Schema, Annotation von 300–500 Anzeigen, Feintuning eines deutschsprachigen Transformers (GBERT) statt des spaCy-Standardmodells, dessen Entitätenklassen (PER/LOC/ORG/MISC) für die Aufgabe ungeeignet sind. Externes Wissen ist für NER leistungsentscheidend, reines Nachschlagen scheitert an Abdeckung und Mehrdeutigkeit (Ratinov & Roth, 2009).
3. _Domänenadaption._ Optional weiteres MLM-Pretraining auf unbeschrifteten Stellenanzeigen. Domänenadaptierte Modelle generalisieren bei heterogenen Quellen nachweislich besser (Gnehm et al., 2022).

**Normalisierung.** Word2Vec wird verworfen. Statische Wortvektoren besitzen kein Subword-Wissen; Schreibvarianten und Tippfehler sind Out-of-Vocabulary und erhalten keinen Vektor. Stattdessen fastText, dessen Zeichen-n-Gramm-Vektoren morphologische Varianten und unbekannte Wörter abdecken (Bojanowski et al., 2017), ergänzt um Satz-Embeddings (SBERT) für semantische Synonyme. Die Kosinus-Ähnlichkeit aus Schritt 3 wird auf diesen Vektoren berechnet.

**Empirischer Zwischenstand.** Die Gazetteer-Baseline erkannte 7 von 9 real übernommenen Stellen des Vergleichsblocks vom 21.07. Die beiden Fehlschläge sind diagnostisch aufschlussreich: „Stadtbibliothek" wurde nicht erkannt, da die Liste „Bibliothek" enthält (Kompositionsproblem); „Museen" nicht, da die Liste „Museum" enthält (Flexionsproblem). Beides sind Belege für die Abdeckungsgrenze wörterbuchbasierter Verfahren im Deutschen und begründen den Übergang zu Lemmatisierung und Subword-Verfahren. Nach Ergänzung der Wortformen liegt der Wert bei 9/9; belastbar ist jedoch der Ausgangswert von 7/9, da die Anpassung an derselben Stichprobe erfolgte.
[[NER und MEHR]]
Sowie [[methodenbegruendung_mit_quellen]]

Überführe in in eine Maschine Lesbaren code

**3. Relevanz-Konfidenz beim Matching (Konfidenz)** 

- **Zweck:** Validierung, ob das durch NER identifizierte Wort tatsächlich dem Standardbegriff der Taxonomie entspricht (Rauschunterdrückung).
    
- **Methode:** Berechnung der **Cosinus-Ähnlichkeit (Cosine Similarity)** zwischen dem Vektor des gefundenen Wortes und dem Vektor des Zielbegriffs aus der Taxonomie.
    
- **Filter:** Nur Matches, die einen empirisch validierten Ähnlichkeits-Schwellenwert überschreiten, werden für den weiteren Prozess behalten.
    
Dadurch die Dubletten besser scoren, Fuzzy matching, das mit der höcvhten wahrscheinlick ausgiubt
Was genau ist das beste aus der Literautur

**4. Dubletten-Check (Kandidatenreduktion)** welche modell 

- **Zweck:** Vermeidung der Mehrfachverarbeitung derselben Anzeige über die 29 Börsen hinweg.
    
- **Methode:** Blocking-Verfahren (Vorfilterung nach Firma/Ort) gefolgt von einem Machine-Learning-gestützten Ähnlichkeitsabgleich (z. B. Levenshtein auf Dokumentenebene), um redundante Anzeigen zu mergen oder zu löschen.
warum lievinsthein, bastände gemessen 
    

**5. Finales Scoring & Klassifikation (Die Business Logic)**

- **Zweck:** Die inhaltliche Bewertung der nun fehlerfreien, normalisierten Stellenanzeige und deren Zuordnung in vorgegebene Zielkategorien (die Taxonomie des Betreuers).
    
- **Methode:** Anwendung eines Supervised Learning Modells (oder Few-Shot/Fine-Tuned LLMs, je nach Implementierungsentscheidung), welches basierend auf den normalisierten Skills die Stellenanzeige bewertet und klassifiziert.

Welches Modell
Label in dem Modell, Ground truth, modell das mna kopierren braucht

**6. Kennzahlengestützte Evaluation & Output**

- **Zweck:** Wissenschaftliche Validierung der Pipeline-Performance und Export der Daten.
    
- **Evaluation:** Die Vorhersagen des Modells aus Schritt 5 werden gegen einen manuell gelabelten Goldstandard (Testdaten) geprüft. Die Ergebnisse werden in einer **Confusion Matrix** visualisiert, um Fehlerquellen (z. B. systematische Verwechslungen von verwandten Jobprofilen) aufzudecken. Zur Quantifizierung der Leistung werden **Accuracy, Precision, Recall und der F1-Score**  berechnet.
    gini und AU-ROG - wissen was das ist
- **Output:** Speicherung der aufbereiteten und bewerteten Job-Profile als strukturierte JSON-Datei CSV für Folgeanwendungen.
