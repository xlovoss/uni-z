### Phase 1: Problem Identification and Motivation

- **Der Ist-Zustand:** Darstellung der Basisprozesse (Automatisierter Quellenabruf via Power Automate, regelbasierte Filter).
    
- **Das Problem (Aktuelle Limitationen):** Das aktuelle Stellenmonitoring skaliert schlecht. Statische Keyword-Filter erzeugen False Positives/Negatives. Harte Ausschlusslogiken sind blind für semantischen Kontext. Die Dublettenprüfung erkennt keine "Near-Duplicates" (z. B. auf verschiedenen Portalen leicht umformulierte Stellen).
    
- **Motivation:** Warum muss das besser werden? (Zeitersparnis, bessere Matching-Qualität, Wettbewerbsvorteil beim Recruiting).
    

### Phase 2: Define Objectives for a Solution

_Hier leitest du aus den Problemen die Forschungsziele und deine Metriken ab._

- **Forschungslücken schließen:** Ziel ist die Ablösung der statischen Logik durch KI-gestützte Ansätze (NLP-Klassifikation, Embeddings).
    
- **Quantitative Zielvorgaben (Deine Evaluationsmetriken!):**
    
    1. _Relevanz:_ Steigerung von Precision/Recall/F1 um +20% gegenüber dem alten regelbasierten System.
        
    2. _Dubletten:_ Erreichen einer Accuracy von >90% bei der Near-Duplicate-Erkennung.
        
    3. _Scoring:_ Erreichen einer Spearman-Rangkorrelation von >0.8 im Vergleich zu menschlichen Experten.
        
    4. _Performance:_ Laufzeit unter 5 Sekunden pro Job-Posting (damit es im Power Automate Flow praxistauglich bleibt).
        

### Phase 3: Design and Development

_Das ist der Kern deiner praktischen Arbeit. Hier greift **CRISP-DM** als Methode für die Modellentwicklung._

- **Business & Data Understanding:** Analyse der aktuellen Stellenanzeigen-Daten, die über Power Automate reinkommen.
    
- **Data Preparation:** Textbereinigung der Job-Postings.
    
- **Modeling (Das Artefakt entsteht):** Hier baust du deine drei Kernkomponenten:
    
    1. _KI-basierte Relevanzprüfung:_ Einsatz von GermanBERT zur Klassifikation. Nutzung von Embeddings zur semantischen Kontextanalyse.
        
    2. _Semantische Dublettenerkennung:_ Berechnung von Vektor-Ähnlichkeiten (z.B. Cosine Similarity auf Embeddings), um Near-Duplicates zu finden.
        
    3. _Lernende Scoring-Modelle:_ Aufbau einer Logik, die Profilfit, Hierarchie und Institution gewichtet und priorisiert.
        
- **Deployment-Konzept:** Wie wird das fertige Modell (z.B. als API) wieder an die Power Automate-Umgebung angebunden?
    

### Phase 4: Demonstration

_Hier zeigst du, dass dein gebautes Artefakt das Problem im Prinzip lösen kann._

- **Proof of Concept:** Du führst exemplarisch einen Datensatz (z. B. 100 Job-Postings) durch dein neues System.
    
- Du demonstrierst den Flow: _Raw Job Posting -> Relevanz-Check (BERT) -> Dubletten-Check (Embeddings) -> Scoring._
    

### Phase 5: Evaluation

_Hier wird gnadenlos abgerechnet, ob du die Ziele aus Phase 2 erreicht hast._

- **Vergleichstest:** Du lässt den alten regelbasierten Ansatz gegen dein neues KI-Modell auf einem Testdatensatz laufen.
    
- **Auswertung der Metriken:**
    
    - Hast du die +20% im F1-Score erreicht?
        
    - Liegt die Near-Duplicate Accuracy über 90%?
        
    - Korreliert dein KI-Score stark (>0.8 Spearman) mit dem, was ein HR-Experte manuell bewertet hätte?
        
    - Bleibt das System unter 5 Sekunden Laufzeit?
        

### Phase 6: Communication

_Dies ist formal die Verschriftlichung deiner Thesis und die Präsentation der Ergebnisse._

- Diskussion der Ergebnisse: Warum hat GermanBERT gut/schlecht funktioniert? Was waren die Herausforderungen bei der Power Automate Anbindung?
    
- Fazit und Management Summary.
    

### Was du jetzt konkret tun solltest (Deine nächsten Schritte):

Da dein Konzept inhaltlich jetzt zu 95 % steht, solltest du dich auf die **Machbarkeit (Daten & Infrastruktur)** konzentrieren:

1. **Datenbeschaffung:** Exportiere dir als Erstes einen Datensatz aus dem aktuellen System (z. B. 1.000 oder 5.000 bisherige Stellenanzeigen). Du brauchst diese historischen Daten (idealerweise gelabelt: _relevant / nicht relevant_ bzw. _Dublette ja/nein_), um GermanBERT trainieren/evaluieren zu können.
    
2. **Menschliche Baseline (Ground Truth) sichern:** Für die _Spearman-Rangkorrelation (>0.8)_ brauchst du zwingend Daten, die von einem Menschen manuell gescort wurden. Kläre ab: Gibt es diese manuellen Bewertungen schon im System, oder musst du mit Kollegen/Experten ein Sample von z.B. 100 Stellenanzeigen händisch von 1-10 bewerten, um dein Modell dagegen testen zu können?
    
3. **Technik-Stack klären:** Hast du Zugang zu ausreichend Rechenleistung für HuggingFace/GermanBERT? Wo läuft das Python-Skript später, das von Power Automate aufgerufen wird? (z.B. Azure Functions, AWS Lambda, lokaler Server?).