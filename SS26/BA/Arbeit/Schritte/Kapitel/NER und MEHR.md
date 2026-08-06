von  [[Konzept]]

**2a — Vorverarbeitung (NER-spezifisch)**  
Nur HTML-Strip und Whitespace-Normalisierung. Casing, Satzzeichen und Satzgrenzen bleiben erhalten. Begründung: Transformer-basiertes NER nutzt Subword-Tokenisierung und Kontext; Lowercasing entfernt im Deutschen das Hauptmerkmal für Substantive.

**2b — Labelschema & Goldstandard**  
Labelset (`SKILL_HARD`, `SKILL_SOFT`, `JOBTITLE`, `TOOL`, `DEGREE`, `EXPERIENCE`), BIO-Annotation von n Anzeigen, Annotationsrichtlinie, Inter-Annotator-Agreement (Cohens κ) auf einer Teilmenge.

**2c — Modellwahl & Training**  
Baseline: EntityRuler/Gazetteer auf ESCO. Hauptmodell: GBERT, feingetunt für Token Classification. Optional Ausbaustufe: Domain-adaptives MLM-Pretraining auf dem unlabelten Korpus (Gnehm et al.), plus Distant Supervision aus ESCO als Silver Labels.

**2d — Normalisierung / Entity Linking**  
Extrahierte Spans → Taxonomie-Begriff. fastText (Subword, fängt Tippfehler) + SBERT (Semantik/Synonyme). Das Scoring dazu ist dein Punkt 3.