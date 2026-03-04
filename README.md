# Bold Beauty Lounge (MVP)

Application mobile pour un salon de spa construite avec Flutter.
Ce projet est développé en suivant l'architecture Clean Architecture et permet de :
- Consulter les services proposés
- Voir les détails d'un service (prix, durée, description)
- Simuler la réservation d'un créneau

## Spécifications Techniques
- **Flutter** : ^3.10.0 (Développé initialement sur la plupart des versions récentes >3.0.0)
- **Architecture** : Clean Architecture (Layered : Domain, Data, Presentation)
- **State Management** : BLoC (`flutter_bloc`)
- **Routing** : `go_router`
- **Injection de Dépendances** : `get_it`

## Commandes pour lancer le projet

1. Récupérer les dépendances :
   ```bash
   flutter pub get
   ```

2. Lancer l'application :
   ```bash
   flutter run
   ```

3. Générer l'APK Android (comme demandé) :
   ```bash
   flutter build apk
   ```

## Points d'attention
- Cette application est un Minimum Viable Product (MVP).
- Les données des services sont mockées localement via la couche repository Data (`mock_services_repository.dart`) afin de simuler un environnement réel sans backend.
- Aucune API réelle ni gestion d'authentification complète n'est intégrée dans l'implémentation actuelle, suivant les consignes du test.
