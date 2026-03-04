
wir haben uns Windows Server
und Virtual Box sowie das extension Pack runter geladen

## Arbeitsgruppe vs Domäne
**Arbeitsgruppe:**
ein Rechner mit vielen Usern 
Auch wenn der Benutzer gleich heißt und das gleiche Passwort hat , ist es nicht der gleiche Nutzer


Dient dazu Nutzern auf meinem Rechner unterschiedliche Rechte zuzuweisen 

Wenn wir 10 Rechner haben, kann sich Meier an 10 Rechnern anmelden, aber wir brauchen 10 neue Meier
![[Pasted image 20251007110600.png]]Lokale einzenle Nutzer die auf den beiden PCs die Nutzer sind und gleichzeitig die Admins auf jeweils einem

Ein Domain Controller(DC) hat die Passwörter und die PCS sind Mitglieder der Domäne
Mit den Zugangsdaten der DC um an den beiden Rechnern sich anzumelden
Nach einem Jahr sollte man seine Passwörter ändern
Wenn das geändert wird wird das an allen Rechnern in der Domäne eingegriffen
Ich möchte für den Nutzer ein Server gespeichertes Profil erstellen und das wird dann an auf den allen PC's angeleckt. Man kann sich also immer an allen PCs dann immer dort anmelden

Immer wenn man sich anmeldet wird nachgefragt ob die Infos so stimmen. Man zieht sich alles was auf dem Profil in Server liegt

Eine Domäne ist eine **zentralisierte Verwaltungseinheit** für Netzwerke.

Arbeitsgruppen (Workgroups) sind **dezentrale Verwaltungseinheiten** in einem Netzwerk.

---

### Domäne vs. Arbeitsgruppe

- **Domäne:** Eine Domäne ist eine **zentrale Verwaltungseinheit**. Alle Computer und Benutzer werden von einem zentralen Server (dem Domänencontroller) verwaltet. Dies vereinfacht die Verwaltung von Zugriffsrechten, Benutzern und Ressourcen in großen Netzwerken.
    
- **Arbeitsgruppe:** Eine Arbeitsgruppe ist eine **dezentrale Verwaltungseinheit**. Jeder Computer in der Arbeitsgruppe verwaltet seine eigenen Benutzer, Zugriffsrechte und Ressourcen. Es gibt keinen zentralen Server. Dies ist ideal für kleine Netzwerke, in denen die Computer direkt miteinander kommunizieren. ()

-> Auch Verwaltungskonzept
Er hat den Server noch eingerichtet mit verschiedenen Rollen
