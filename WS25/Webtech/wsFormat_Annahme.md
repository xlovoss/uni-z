
## Funktionsweise

- Server Kommuniziert mit Envelops über Websockts an uns
- Dabei werden die Websocktes als einzige Verbindungszweig stattfinden
- State ist Single-Source-of-True (Wissen zentralisiert) 


## Aufbau

### 1 Schicht Netzwerkannahme 
Wandelt Websocket Events in interne Events um
Hier werden die JSON verschickt / empfangen

Wenn JSON reinkommt:
1. TransactionID, Type, MSG prüfen 
2. einteilen -> (anhand von Transaction ID) -> 
3. Weiterleiten(-> Kontroller) oder auch Benachrichtigen 

### 2 Schicht Kontroller (Logik)
Er kennt die Regeln (Oder weiß wer sie kennt) Er verbindet Netzwerk, State und das Süßi Pixi
Type ausschlaggebend -> 
train.create -> Store.addTrain() aufrufen und dann (Ich Schicht 4 Renderer.updateZuch  rendern)

Use Case:
- User klickt auf die Karte.
- View meldet Klick an Controller.
- Controller baut JSON Envelope (`rail.create`).
- Controller gibt Envelope an **Schicht 1 (Netzwerk)** zum Senden.
- (Optional) Controller zeigt Lade-Animation an, bis `game.reply`(Jannis sagt so geht das nicht) kommt.

### 3 Schicht State (Hier wird gespeichert) -> Datenbank im Frontend
Hier sind letztlich die Datenstrukturen gespeichert (Wissen, reine Daten)

So wird es aussehen:
// GameState.js
export const gameState = {
    // 1. Züge: Wir speichern sie in einer Map für schnellen Zugriff per ID
    // Key: Zug-ID (z.B. 5), Value: Daten-Objekt
    trains: new Map(), 

    // 2. Die Karte: Zugriff über Koordinaten "x,y,z"
    // Key: "10,5,0", Value: { type: "rail", variant: "curve" }
    mapData: new Map(),

    // 3. Blockierte Kacheln (schnelles Nachschlagen)
    blockedTiles: new Set(), // Enthält Strings wie "10,5,0"

    // 4. Metadaten (optional)
    myPlayerId: null,
    isConnected: false,

    // --- Methoden um Daten zu ändern ---
    
    addTrain(id, data) {
        this.trains.set(id, data);
    },

    getTrain(id) {
        return this.trains.get(id);
    },

    updateMap(x, y, z, data) {
        const key = `${x},${y},${z}`;
        this.mapData.set(key, data);
    }
};
### 4 Schicht View 
Visualisierung & Inpute Abfangen
Macht die Anfragen in Pixi Application und Staged diese
Wird nur aufgerufen um Bilder hinzuzufügen/entfernen/ verschieben

Fängt Mausklicks ab und meldet sie Schicht 2 und daran wird entschieden
## Was wir laut Artikel noch brauchen 
https://entwickler.de/webentwicklung/die-sache-mit-dem-state

Einteilung von:
- Original-Daten(State):
	- Tile-Grid (x.y)
	- Zug-Liste (ID,Position,...)
	- Geld
- Abgeleitete Dates:
	- Sprites
	- Pixel Daten (Wird im Frontend berechnet)
	- jegliche Form von Animationen
## Bisher nicht beachtet 

Was passiert wenn ein neuer Spieler nach 10 Minuten noch dazu kommt?

nach jetzigen Stand werden wir von 100 Baudinger vollgeschickt werden, was die andere Spieler bisher gebaut haben


Was meinst du mit game.rply JANNIS? Nach meiner Recherche ist das normale Use Case bei so einer State gesteuerten?

-> Optimistic UI war der Plan

