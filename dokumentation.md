# FlutterApp (Team 6)
__Spendeconnect__
## About us
**Spendeconnect** is an innovative platform aimed at bringing trustworthy causes closer to passionate donors. With an intuitive user interface, users can easily create profiles, explore a variety of charitable campaigns, and make donations effortlessly. Each campaign is carefully detailed, providing comprehensive information about its goals, current funding, and deadline. Through real-time analytics, contributors can track the impact of their donations, thereby strengthening trust and commitment to the supported causes. Join us in our mission to make a positive difference in the world, one donation at a time. Together, we can build a better future for communities worldwide.
# User stories
- As a user, I want to create an account to access the application's features.
- As a user, I want to log in to my account to manage my profile and activities.
- As a user, I want to reset my password in case I forget it.
- As a logged-in user, I want to be able to view the details of a donation campaign, including its description, financial goal, and end date.
- As a loged-user, I want to browse through other users' donation requests.
- As a loged-user, I want to create a publication to request financial assistance.
-As a logged-in user, I want to be able to make a donation to a campaign that I find compelling by specifying the amount I want to give
- As a loged-user, I want to be able to see the total funds collected for a specific request.





**1. Einführung / Projektübersicht:**

Das Projekt "SpendeConnect" hat zum Ziel, eine benutzerfreundliche Plattform für den Austausch von Beiträgen und die Vernetzung von Benutzern bereitzustellen. Die Anwendung basiert auf der Verwaltung von Aufgaben, der Authentifizierung von Benutzern und der Nutzung von Firebase für die Datenspeicherung. Sie bietet eine reibungslose und ansprechende Benutzererfahrung.

2. Architektur:
Die Architektur unseres Projekts folgt bewährten Prinzipien für eine klare Trennung von Verantwortlichkeiten und eine effiziente Wartbarkeit. Hier sind die wichtigsten Strukturpunkte:
•	domain/todos/:
•	todo.dart: Definiert das Datenmodell für eine Aufgabe.
•	todo_repository.dart: Stellt die Schnittstelle für das Aufgaben-Repository bereit.
•	todo_use_case.dart: Implementiert die Anwendungsfälle für die Aufgabenverwaltung.
•	data/:
•	local_todo_data_source.dart: Lokale Datenquelle für Aufgaben.
•	firebase_todo_data_source.dart: Firebase-Datenquelle für Aufgaben.
•	todo_repository_impl.dart: Konkrete Implementierung des Aufgaben-Repositorys.
•	presentation/:
•	auth/: Enthält den Bildschirm für die Benutzerauthentifizierung.
•	home/: Enthält den Hauptbildschirm der Anwendung.
•	loading/: Enthält den Ladebildschirm.
•	splash/: Enthält den Begrüßungsbildschirm.
•	create_pub/: Enthält den Bildschirm zur Erstellung von Veröffentlichungen.
•	history/: Enthält den Bildschirm für die Historie.
•	profil/: Enthält den Bildschirm für das Benutzerprofil.
•	services/:
•	authentification.dart: Enthält Authentifizierungsdienste.
•	firebase_options.dart: Enthält Firebase-Optionen.
•	utils/:
•	constants.dart: Datei zur Definition von Konstanten.
•	main.dart: Der Einstiegspunkt der Anwendung.
•	my_app.dart: Die allgemeine Konfiguration der Anwendung.
•	navigator.dart: Die Datei enthält die Klasse "MyApp" und kann bei Bedarf umbenannt werden.
Diese Struktur fördert eine klare Organisation der Anwendungskomponenten und erleichtert die Wartung und Erweiterung des Codes.

### A- AuthentificateScreen
                                                   

Das Widget `AuthentificateScreen` verwaltet die Benutzeroberfläche für die Authentifizierung und Registrierung von Benutzern in der SpendeConnect-Anwendung.

#### Hauptmethoden

1. **toggleView**: Diese Methode ermöglicht das Umschalten zwischen Anmelde- und Registrierungsmodi, indem der Bildschirmzustand geändert wird, um die entsprechenden Felder anzuzeigen.

#### Hauptattribute

- **_auth**: Instanz des Authentifizierungsdienstes, der zum Verwalten von Authentifizierungsvorgängen verwendet wird.
- **_formkey**: Globale Schlüssel für das Formular, der zum Validieren und Zurücksetzen der Formularfelder verwendet wird.
- **error**: Zeichenfolge zur Anzeige möglicher Fehlermeldungen während der Authentifizierung oder Registrierung.
- **loading**: Boolescher Wert, der angibt, ob die Anwendung gerade lädt und der verwendet wird, um einen Ladeindikator während asynchroner Operationen anzuzeigen.
- **usernameController**, **emailController**, **passwordController**: Textfeld-Controller für die Benutzereingaben von Benutzername, E-Mail und Passwort.
- **showSignIn**: Boolescher Wert, der angibt, ob der Benutzer im Anmelde- oder Registrierungsmodus ist.

#### Aufbau-Methode

Die Methode `build` erstellt die Benutzeroberfläche des Authentifizierungsbildschirms basierend auf dem aktuellen Zustand und zeigt die entsprechenden Felder für die Anmeldung oder Registrierung an. Sie verwendet Widgets wie `TextFormField` für die Benutzereingabe und `ElevatedButton` zum Auslösen von Authentifizierungs- oder Registrierungsaktionen.

#### Verwendung von Firestore

Der Authentifizierungsbildschirm verwendet Firestore, um Benutzerinformationen während der Registrierung zu speichern, indem ein neuer Benutzer zur "users"-Sammlung mit den bereitgestellten Anmeldeinformationen hinzugefügt wird.

#### Fehlerbehandlung

Eventuelle Fehler während der Authentifizierung oder Registrierung werden dem Benutzer über das `error`-Feld angezeigt, um eine nahtlose Benutzererfahrung zu gewährleisten.

Diese Klasse bietet eine benutzerfreundliche Benutzeroberfläche, damit Benutzer sich in der SpendeConnect-Anwendung anmelden oder registrieren können, und gewährleistet die Sicherheit und Zuverlässigkeit der durchgeführten Operationen durch die Integration mit Firebase Authentication und Firestore. 



## B- MyApp

Die Klasse `MyApp` ist der Einstiegspunkt der Anwendung und bestimmt die allgemeine Struktur der Benutzeroberfläche.

### Attribute

- **\_CurrentIndex**: Eine Ganzzahl, die den Index des aktuell ausgewählten Elements in der unteren Navigationsleiste darstellt.

### Methoden

- **setCurrentIndex(int index)**: Eine Methode, die den Index des aktuell ausgewählten Elements in der unteren Navigationsleiste entsprechend dem übergebenen Index aktualisiert.

### Aufbau-Methode

Die Methode `build` erstellt die Benutzeroberfläche der Anwendung, indem sie einen `GetMaterialApp`-Widget als Hauptcontainer verwendet. Hier ist eine detaillierte Beschreibung der Hauptkomponenten:

- **Scaffold**: Ein grundlegendes Layout-Widget, das die Benutzeroberfläche mit einer App-Leiste, einem Hauptinhalt und einer unteren Navigationsleiste strukturiert.

- **AppBar**: Die App-Leiste, die den Seitentitel basierend auf dem Index `_CurrentIndex` anzeigt und eine grüne Hintergrundfarbe verwendet.

- **body**: Der Hauptinhalt der Anwendung, der den Inhalt der Seite basierend auf dem Index `_CurrentIndex` anzeigt. Es handelt sich um eine Liste von Bildschirmen wie `HomePage`, `CreatePub`, `HistoryPage` und `ProfilPage`.

- **bottomNavigationBar**: Die untere Navigationsleiste, die es dem Benutzer ermöglicht, zwischen den verschiedenen Abschnitten der Anwendung zu navigieren. Sie enthält Elemente zum Zugriff auf die Startseite, zum Erstellen einer neuen Veröffentlichung, zum Anzeigen von Favoriten und zum Anzeigen von Benutzerinformationen.

- **Theme**: Das Design der Anwendung, das die in den Dateien `lightMode.dart` und `darkMode.dart` definierten hellen und dunklen Modi verwendet.



### C- ProfilPage

Die Klasse `ProfilPage` ist verantwortlich für die Anzeige des Benutzerprofils in der Anwendung.

#### Attribute

- **\_auth**: Eine Instanz des `AuthentificationService`, die für die Authentifizierung des Benutzers verwendet wird.
- **username**: Eine Zeichenfolge, die den Benutzernamen des angemeldeten Benutzers enthält.
- **email**: Eine Zeichenfolge, die die E-Mail-Adresse des angemeldeten Benutzers enthält.

#### Methoden

- **initState()**: Eine Methode, die beim Initialisieren des Widgets aufgerufen wird und die Benutzerdaten aus Firestore abruft.
- **fetchUserData()**: Eine Methode, die die Benutzerdaten aus Firestore abruft und den Zustand der Klasse aktualisiert.
- **getCollectionData(String collectionName)**: Eine Methode, die Daten aus einer Firestore-Sammlung abruft.

#### Aufbau-Methode

Die Methode `build` erstellt die Benutzeroberfläche der Profilseite mit den folgenden Hauptkomponenten:

- **Scaffold**: Ein grundlegendes Layout-Widget, das die Benutzeroberfläche strukturiert.
- **SingleChildScrollView**: Ein Widget, das einen Bildlauf in einer Richtung ermöglicht, wenn der Inhalt größer als der sichtbare Bereich ist.
- **Padding**: Ein Widget, das Inhalt mit einem Innenabstand versieht.
- **Column**: Ein Widget, das seine Kinder in einer vertikalen Anordnung anordnet.
- **CircleAvatar**: Ein kreisförmiges Widget zur Anzeige des Benutzerprofils.
- **itemProfile**: Ein benutzerdefiniertes Widget zur Anzeige von Profilinformationen wie Benutzername und E-Mail.
- **ElevatedButton**: Ein erhabener Schaltflächen-Widget zum Ausloggen des Benutzers.
- **FloatingActionButton**: Eine schwebende Aktionsschaltfläche zum Zugriff auf die Supportseite.

#### Verwendung

Die `ProfilPage`-Klasse wird verwendet, um dem Benutzer sein Profil anzuzeigen und die Möglichkeit zum Ausloggen oder zum Zugriff auf die Supportseite über die schwebende Aktionsschaltfläche zu bieten.



### D-  SupportPage

Die `SupportPage`-Klasse ist für die Anzeige der Supportseite in der Anwendung verantwortlich.

#### Attribute

- **username**: Eine Zeichenfolge, die den Benutzernamen des aktuellen Benutzers enthält.
- **email**: Eine Zeichenfolge, die die E-Mail-Adresse des aktuellen Benutzers enthält.

#### Aufbau-Methode

Die Methode `build` erstellt die Benutzeroberfläche der Supportseite mit den folgenden Hauptkomponenten:

- **Scaffold**: Ein grundlegendes Layout-Widget, das die Benutzeroberfläche strukturiert.
- **AppBar**: Eine App-Leiste zur Anzeige des Titels der Seite.
- **Tawk**: Ein Widget zur Integration des Tawk.to-Chat-Widgets in die Anwendung.
  - **directChatLink**: Der direkte Chat-Link für den Tawk.to-Chat.
  - **visitor**: Ein Objekt, das die Besucherinformationen für den Chat enthält, einschließlich Benutzername und E-Mail.
  - **onLoad**: Eine Funktion, die aufgerufen wird, wenn der Chat geladen wird.
  - **onLinkTap**: Eine Funktion, die aufgerufen wird, wenn ein Link im Chat getippt wird.
  - **placeholder**: Ein Widget, das angezeigt wird, während der Chat geladen wird.

#### Verwendung

Die `SupportPage`-Klasse wird verwendet, um dem Benutzer Zugriff auf den Support-Chat über die Tawk.to-Plattform zu geben. Sie ermöglicht es Benutzern, Unterstützung zu erhalten und Fragen direkt über die Anwendung zu stellen.