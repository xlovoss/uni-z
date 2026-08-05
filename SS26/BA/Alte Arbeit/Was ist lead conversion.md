Ganz einfach und auf den Punkt gebracht: **"Lead Conversion" (auf Deutsch etwa: Lead-Umwandlung oder Angebotsannahme) beschreibt im Vertrieb exakt den Moment, in dem aus einem potenziellen Interessenten ein echter, kaufender Kunde wird.**

Ein "Lead" ist im Marketing- und Vertriebsjargon eine Person oder ein Unternehmen, das grundsätzliches Interesse an einer Leistung gezeigt hat. "Conversion" (Umwandlung) ist die erfolgreiche Aktion, die du erreichen willst.

**Was das für deinen konkreten Job im Projektmanagement bedeutet:**

- **Der Lead / Die Opportunity:** Das ist ein Kunde, mit dem du gerade in Kontakt stehst und für den du ein Angebot in eurem internen System anlegst. Das Angebot "schwebt" quasi im Raum.
    
- **Die Conversion:** Das ist der erfolgreiche Abschluss. Der Kunde sagt: "Ja, das Angebot nehmen wir an!" Er unterschreibt den Vertrag oder erteilt die Freigabe, und das Projekt kann starten.
    

**Was das für dein KI-Modell (den TFT) bedeutet:**

Aus der Sicht eines Data Scientists oder für deine Bachelorarbeit machst du aus dieser Situation ein klassisches mathematisches Problem. "Lead Conversion" ist deine Zielvariable (in der Fachsprache "Target Variable" oder "Label" genannt). Es gibt für historische Angebote in deinem System in der Regel nur zwei Ausgänge:

- **0 (Keine Conversion):** Das Angebot wurde abgelehnt, der Kunde hat sich nicht mehr gemeldet oder ist zur Konkurrenz gegangen (Lost Deal).
    
- **1 (Conversion):** Das Angebot wurde akzeptiert (Won Deal).
    

Dein TFT-Modell soll am Ende für ein _neues_ Angebot anhand der Vergangenheit einen Prozentwert ausspucken, zum Beispiel: _"Die Wahrscheinlichkeit für eine Conversion (also dass das Angebot angenommen wird) liegt bei 82%."_

Wenn du in wissenschaftlichen Papern also von "Win Prediction" oder "Lead Conversion" liest, geht es immer genau um diese Frage: **Wird der Kunde kaufen oder nicht?**

Da du ja bald das Gespräch mit deiner Betreuerin hast und danach dein einseitiges Exposé schreiben musst: Wollen wir jetzt einmal auflisten, welche konkreten Daten (z.B. Kundenalter, Preis, Datum des letzten Kontakts) du in eurem internen System hast, um sie gedanklich schon mal in das TFT-Modell einzusortieren?