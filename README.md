# QuandEX

Application Android native en Kotlin et Jetpack Compose pour surveiller QuandEX / GOLDEX EA PRO et transmettre des commandes à une passerelle MT5 sécurisée.

Version actuelle : `1.51.0`, avec un graphique en chandeliers temps réel, le logo officiel QuandEX agrandi et une navigation compacte sans libellés.

## Fonctions

- Tableau de bord noir et or actualisé automatiquement.
- Fenêtre de chandeliers OHLC temps réel avec sélection tactile.
- EMA 20/50, volume, prix courant, Stop Loss, Take Profit, Order Block et FVG superposés.
- Statut, tendance, signal, spread, balance, equity, profit, win rate, risque et lot.
- Alignement MN1, D1, H4, H1 et M15.
- RSI, ADX, ATR, sessions, news, Order Blocks et Imbalances/FVG.
- Ordres Market, Limit et Stop avec BUY/SELL, SL, TP, lot, grille et trailing.
- Historique des signaux et gestion des positions.
- Confirmation visuelle et signal sonore pour les commandes de trading.
- Navigation téléphone par barre inférieure et navigation tablette par rail latéral.
- Mode démonstration local activé par défaut.
- API REST configurable pour la connexion à GOLDEX EA PRO.

## Ouvrir et compiler

1. Installez Android Studio Ladybug ou plus récent avec Android SDK 35 et JDK 17.
2. Ouvrez le dossier `QuandEX-Android`.
3. Laissez Android Studio synchroniser Gradle.
4. Lancez l’application sur un appareil Android 8.0+ ou un émulateur.
5. Pour générer un APK debug : `./gradlew assembleDebug`.

APK attendu après compilation : `app/build/outputs/apk/debug/app-debug.apk`.

## Compilation automatique GitHub

Le workflow `.github/workflows/android-build.yml` installe Java 17, Android SDK et Gradle 8.9, exécute les tests puis publie `QuandEX-v1.51.0-debug.apk` comme artefact téléchargeable. Importez le projet dans un dépôt GitHub, ouvrez l’onglet **Actions**, choisissez **Build QuandEX Android APK**, puis **Run workflow**.

## Tester sans MT5

Le mode démonstration interne ne nécessite aucun serveur. Pour tester le véritable client HTTP :

```bash
node bridge/mock_server.js
```

Dans une version debug exécutée sur l’émulateur Android, désactivez le mode démonstration et utilisez `http://10.0.2.2:8080`. En production, utilisez exclusivement une URL HTTPS.

## Connexion à MT5

Une application Android ne peut pas appeler directement les fonctions de trading MQL5. Elle utilise donc une passerelle :

`QuandEX → HTTPS → passerelle authentifiée → GOLDEX EA PRO / MT5`

Le contrat JSON complet est décrit dans [`docs/API.md`](docs/API.md). La passerelle de production doit confirmer chaque commande et appliquer les protections de risque côté MT5 avant toute exécution.

## Sécurité

- Aucune clé de courtier n’est incluse dans le projet.
- Le jeton API est saisi par l’utilisateur et stocké dans les préférences privées de l’application.
- Le mode réel est désactivé par défaut.
- Les actions de fermeture demandent confirmation.
- Les champs d’ordre sont validés dans l’application, mais le serveur doit les valider une seconde fois.

Avant toute utilisation réelle, testez l’ensemble application–passerelle–EA dans le Strategy Tester et sur un compte démo.
