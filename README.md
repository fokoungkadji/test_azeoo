# AZEOO Profile SDK

SDK Flutter pour l'affichage de profil utilisateur, intégrable dans des applications React Native.

## Lancement du projet complet

### Prérequis

- Flutter SDK >= 3.10.0
- Node.js >= 18.0.0
- Android Studio avec un émulateur configuré
- JDK 17

### Étapes de lancement

Depuis la racine du projet (`test_azeoo/`), exécuter les commandes suivantes dans l'ordre :

**Étape 1 : Installer les dépendances Flutter et générer le code**

```bash
cd azeoo_profile_sdk
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

**Étape 2 : Compiler le SDK Flutter en AAR**

```bash
cd azeoo_profile_sdk
flutter build aar
```

**Étape 3 : Installer les dépendances React Native**

```bash
cd AzeooApp
npm install
```

**Étape 4 : Lancer l'émulateur Android**

```bash
emulator -avd <NOM_DE_VOTRE_EMULATEUR>
```

**Étape 5 : Lancer Metro (serveur de développement React Native)**

```bash
cd AzeooApp
npx react-native start
```

**Étape 6 : Installer et lancer l'application (dans un nouveau terminal)**

```bash
cd AzeooApp
npx react-native run-android
```

### Commandes rapides

Si le SDK est déjà compilé :

```bash
cd AzeooApp
npx react-native start &
npx react-native run-android
```

---

## Choix Techniques

### Architecture : Clean Architecture

**Choix** : Clean Architecture avec séparation en 4 couches (Core, Domain, Data, Presentation)

**Justification** :
- **Séparation des responsabilités** : Chaque couche a un rôle précis et bien défini
- **Testabilité** : Les couches sont indépendantes et peuvent être testées isolément avec des mocks
- **Maintenabilité** : Les modifications sont localisées dans une seule couche
- **Évolutivité** : Possibilité de changer l'implémentation (ex: remplacer Hive par SQLite) sans impacter les autres couches
- **Indépendance du framework** : La couche Domain ne dépend d'aucune librairie externe

### State Management : flutter_bloc (Cubit)

**Choix** : `flutter_bloc` avec le pattern Cubit

**Alternatives considérées** :
- `Riverpod` : Plus moderne mais courbe d'apprentissage plus élevée
- `Provider` : Plus simple mais moins structuré pour les cas complexes
- `GetX` : Trop "magique", moins de contrôle explicite

**Justification** :
- Respect de la contrainte du test : pas d'utilisation de `setState`
- Séparation claire entre la logique métier (Cubit) et l'UI (Widgets)
- États explicites et prévisibles (Initial, Loading, Loaded, Error)
- Excellente testabilité avec le package `bloc_test`
- Package mature avec une large communauté et documentation complète

### Navigation : go_router

**Choix** : `go_router`

**Alternative considérée** : `auto_route`

**Justification** :
- Respect de la contrainte du test : pas d'utilisation de `Navigator` built-in
- API déclarative et intuitive
- Moins de code généré qu'`auto_route`
- Maintenu officiellement par l'équipe Flutter
- Suffisant pour les besoins du SDK (navigation simple)

### Gestion d'erreurs : dartz (Either)

**Choix** : `dartz` avec le type `Either<Failure, Success>`

**Justification** :
- Gestion fonctionnelle des erreurs sans utiliser les exceptions
- Distinction claire entre les cas de succès et d'échec
- Pattern matching avec `fold()` pour traiter les deux cas
- Typage fort des erreurs (ServerFailure, NetworkFailure, CacheFailure, etc.)
- Code plus prévisible et plus facile à tester

### Cache : Hive

**Choix** : `hive` + `hive_flutter`

**Alternatives considérées** :
- `shared_preferences` : Trop limité pour des objets complexes
- `sqflite` : Trop lourd pour un simple cache de profils

**Justification** :
- Performances excellentes (base NoSQL optimisée pour Flutter)
- API simple et intuitive
- Pas besoin de schéma de base de données
- Support natif de la sérialisation d'objets
- Persistance locale fiable

### Intégration API : Dio

**Choix** : `dio`

**Justification** :
- Système d'intercepteurs pour ajouter facilement les headers (X-User-Id)
- Gestion d'erreurs typées et détaillées (DioException)
- Support des timeouts et retry automatique
- Transformers pour la sérialisation/désérialisation
- Logging facilité pour le debug

### Injection de dépendances : get_it + injectable

**Choix** : `get_it` avec `injectable`

**Justification** :
- Pattern Service Locator : accès global aux dépendances
- Lazy loading : les services sont instanciés uniquement quand nécessaires
- Facilité de test : remplacement simple des dépendances par des mocks
- Génération automatique du code de configuration avec `injectable`

### Sérialisation : freezed + json_serializable

**Choix** : `freezed` avec `json_serializable`

**Justification** :
- Immutabilité des modèles par défaut
- Génération automatique de `copyWith`, `==`, `hashCode`, `toString`
- Union types pour les états du Cubit (sealed classes)
- Pattern matching avec `when()` et `maybeWhen()`
- Sérialisation JSON automatique

---

## Architecture détaillée

```
lib/
├── main.dart                    # Point d'entrée pour React Native
└── src/
    ├── core/                    # Couche Core (transversale)
    │   ├── cache/               # Gestion du cache (Hive)
    │   ├── di/                  # Injection de dépendances (get_it)
    │   ├── error/               # Exceptions et Failures
    │   ├── network/             # Client API (Dio)
    │   └── platform/            # Communication native (MethodChannel)
    │
    ├── domain/                  # Couche Domain (logique métier pure)
    │   ├── entities/            # Entités métier (User)
    │   ├── repositories/        # Contrats des repositories
    │   └── usecases/            # Cas d'utilisation (GetUserProfile)
    │
    ├── data/                    # Couche Data (accès aux données)
    │   ├── datasources/         # Sources de données (API, Cache)
    │   ├── models/              # Modèles de données (UserModel)
    │   └── repositories/        # Implémentations des repositories
    │
    └── presentation/            # Couche Presentation (UI)
        ├── bloc/                # Cubit et états
        ├── pages/               # Pages (ProfilePage)
        ├── widgets/             # Widgets réutilisables
        └── router/              # Configuration de navigation
```

## Tests

### Lancer les tests

```bash
cd azeoo_profile_sdk
flutter test
```

### Tests Implémentés (52 tests)

| Catégorie | Fichier | Nombre |
|-----------|---------|--------|
| Core | failures_test.dart | 14 |
| Data - Models | user_model_test.dart | 15 |
| Data - Repositories | user_repository_impl_test.dart | 7 |
| Domain - Use Cases | get_user_profile_test.dart | 7 |
| Presentation - Bloc | profile_cubit_test.dart | 8 |
| **Total** | | **52** |

### Couverture des tests

- **Failures** : Égalité, propriétés, héritage, messages par défaut
- **UserModel** : Sérialisation JSON, conversion vers entité, gestion des valeurs null
- **UserRepositoryImpl** : Cache valide, forceRefresh, cache vide, exceptions
- **GetUserProfile** : Appel au repository, passage des paramètres, gestion des échecs
- **ProfileCubit** : États initial/loading/loaded/error, updateUserId, refreshProfile
