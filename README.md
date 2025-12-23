# 🛒 TechStore

## 📱 Description du Projet

**TechStore** est une application mobile e-commerce moderne développée avec Flutter, spécialisée dans la vente de produits technologiques (smartphones, laptops, consoles de jeux, accessoires tech). L'application offre une expérience utilisateur fluide et intuitive avec un design moderne et des fonctionnalités complètes de shopping en ligne.

### ✨ Fonctionnalités Principales

- 🏠 **Page d'accueil** avec carousel promotionnel et meilleures ventes
- 🔍 **Recherche de produits** avec barre de recherche personnalisée
- 📦 **Catalogue complet** avec catégories (Casques, Laptops, Téléphones, Consoles, etc.)
- 🛍️ **Système de panier** avec gestion des quantités et calcul automatique du total
- 📄 **Pages détails produits** avec caractéristiques, avis et système de notation
- 👤 **Authentification utilisateur** (Inscription, Connexion)
- 🎨 **Interface moderne** avec animations et transitions fluides
- 📱 **Navigation intuitive** avec barre de navigation personnalisée

## 🛠️ Technologies Utilisées

- **Framework**: Flutter 3.x
- **Langage**: Dart
- **State Management**: GetX
- **API Backend**: Laravel (RESTful API)
- **HTTP Client**: Dio
- **Stockage local**: GetStorage
- **Architecture**: Clean Architecture (Presentation, Domain, Data)

## 👥 Équipe de Développement

| Membre | Rôle / Travail Effectué | GitHub Username |
|--------|------------------------|-----------------|
| **MOUTOUAMA Thérance** | UI/UX Design, Pages : Catalogue, Profil, Panier, Amélioration de l'UI | @Therax1 |
| **AHOADI Emmanuel** | Pages : Accueil, OTP, Mot de passe Oublié, Intégration API Backend | @MagmusTop |
| **AHOHOUINDO Ursule** | UI/UX, Splash Screen, OnBoarding, Page Connexion/Inscription | @Ursulee |

## 📂 Structure du Projet

```
lib/
├── data/              # Couche de données (API, cache, repositories)
│   ├── cache/
│   └── repo/
├── domain/            # Logique métier
│   ├── models/
│   └── services/
│       └── ApiService.dart
├── presentation/      # Interface utilisateur
│   └── pages/
│       ├── auth/      # Pages d'authentification
│       ├── home/      # Page d'accueil
│       ├── cart/      # Page panier
│       ├── catalogue/ # Page catalogue
│       └── profil/    # Page profil
├── utils/             # Composants réutilisables
│   ├── product_card.dart
│   ├── custom_search_bar.dart
│   ├── custom_bottom_navbar.dart
│   └── custom_text_field.dart
├── navigation.dart    # Configuration des routes
└── main.dart          # Point d'entrée de l'application
```

## 🚀 Installation et Lancement

### Prérequis
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Backend Laravel lancé sur `http://localhost:8000`

### Étapes d'installation

1. **Cloner le repository**
   ```bash
   git clone https://github.com/votre-username/TechStore.git
   cd TechStore
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Configurer l'API**
   - Assurez-vous que le backend Laravel est lancé
   - Modifiez l'URL de l'API dans `lib/domain/services/ApiService.dart` si nécessaire
   ```dart
   baseUrl: 'http://10.0.2.2:8000/api/', // Pour émulateur Android
   // OU
   baseUrl: 'http://localhost:8000/api/', // Pour Chrome/Web
   ```

4. **Lancer l'application**
   ```bash
   flutter run
   ```

## 📦 Dépendances Principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6              # State management
  dio: ^5.4.0              # HTTP client
  get_storage: ^2.1.1      # Local storage
```

## 🎨 Palette de Couleurs

- **Primaire**: `#5B67FF` (Bleu)
- **Secondaire**: `#251CD9` (Bleu foncé)
- **Succès**: `#4CAF50` (Vert)
- **Background**: `#F5F5F5` (Gris clair)

## 📸 Captures d'écran

![SplashScreen](/design/Splash.png "TechStore") 

## 🔐 Configuration Backend

L'application nécessite un backend Laravel avec les endpoints suivants :

- `POST /api/auth/register` - Inscription utilisateur
- `POST /api/auth/login` - Connexion utilisateur

## 🐛 Résolution des Problèmes
### Problèmes de build
```bash
flutter clean
flutter pub get
flutter run
```
**Made with ❤️ by TechStore Team**
