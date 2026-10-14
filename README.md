# ⚡ Pokédex Flutter Application

A modern, responsive, and feature-rich Pokédex mobile application built with **Flutter**, **Riverpod** state management, and **GraphQL** (PokeAPI v1beta).

---

## 🌟 Key Features

* **⚡ GraphQL API Integration**: Asynchronous data fetching powered by `graphql_flutter` connecting directly to PokeAPI GraphQL (`https://beta.pokeapi.co/graphql/v1beta`).
* **✨ Dynamic Debug-to-Prod Splash Morph**:
  * **Debug Mode**: Starts with a technical terminal dark theme (`#0F172A`), wireframe SVG icon (`ic_pokedex_debug.svg`), and `DEBUG BUILD` badge, then smoothly morphs with a cross-fade sequence into the Production Pokéball theme before opening the app.
  * **Release Mode**: Instant clean light theme (`#F6F8FC`), official Pokéball SVG (`ic_pokedex_prod.svg`), and tagline.
* **📱 Adaptive Android Launcher Icon**: Native Android adaptive vector icon (`res/mipmap-anydpi-v26/ic_launcher.xml`) scaled to fit within Android's 66dp safe zone without clipping.
* **🔍 Instant Search & Element Type Filtering**: Search Pokémon by name or `#001` ID, plus a horizontal element type filter carousel (Grass, Fire, Water, Electric, Dragon, Fairy, etc.).
* **📊 Detailed Pokémon View**: Hero artwork animations, physical metrics (Height in meters, Weight in kg), and progress stat bars for HP, ATK, DEF, SATK, SDEF, and SPD.
* **🎯 Material 3 Light Theme**: Styled with a clean off-white background (`#F6F8FC`), white card surfaces (`#FFFFFF`), Pokeball Red accent (`#EE1515`), and dynamic element type color badges.

---

## 🛠 Tech Stack & Dependencies

| Category | Technology / Package | Purpose |
| :--- | :--- | :--- |
| **Framework** | Flutter 3.47+ / Dart 3.13+ | Cross-platform mobile framework |
| **State Management** | `flutter_riverpod` (`^2.6.1`) | Reactive state & query provider management |
| **Networking** | `graphql_flutter` (`^5.3.0`) & `http` | GraphQL API queries & caching |
| **SVG Rendering** | `flutter_svg` (`^2.3.0`) | High-fidelity vector graphics rendering |
| **Image Caching** | `cached_network_image` (`^3.4.1`) | Smooth artwork network caching & placeholders |
| **Icons & Tooling** | `flutter_launcher_icons` (`^0.14.4`) | App launcher icon generation |

---

## 📁 Architecture & Project Structure

The project follows a **Feature-Oriented Clean Architecture** pattern:

```text
lib/
├── main.dart                      # App entry point (ProviderScope & GraphQLProvider)
├── core/
│   ├── graphql/                   # GraphQLClient setup & PokeAPI endpoint
│   └── theme/                     # AppTheme & 18 Element Type color mappings
├── data/
│   ├── models/                    # Pokemon data model & JSON parsing
│   ├── queries/                   # GraphQL query definitions for PokeAPI
│   └── repositories/              # PokemonRepository data layer
└── presentation/
    ├── splash/                    # Environment-aware Animated Splash Screen
    ├── pokedex_list/              # Main screen with Search, Filter & Grid View
    ├── pokemon_detail/            # Detailed stats, metrics & Hero artwork
    ├── providers/                 # Riverpod state providers
    └── widgets/                   # Reusable PokemonCard & TypeBadge widgets
```

---

## 🚀 Getting Started

### Prerequisites

* [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.24.0 or newer)
* [Android SDK](https://developer.android.com/studio) / Android Studio
* Connected Android Device or Emulator

### Installation & Running

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/pokedex.git
   cd pokedex
   ```

2. **Install Flutter dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run static analysis**:
   ```bash
   flutter analyze
   ```

4. **Run unit & widget tests**:
   ```bash
   flutter test
   ```

5. **Build & launch the application**:
   ```bash
   flutter run
   ```

---

## 🎨 Design System & Color Palette

* **Background**: `#F6F8FC`
* **Card Surface**: `#FFFFFF` (with soft elevation shadow)
* **Primary Accent**: `#EE1515` (Pokeball Red)
* **Text Primary**: `#2A2A2A`
* **Type Badges**:
  * **Grass**: `#7AC74C` | **Fire**: `#EE8130` | **Water**: `#6390F0` | **Electric**: `#F7D02C`
  * **Ice**: `#96D9D6` | **Fighting**: `#C22E28` | **Poison**: `#A33EA1` | **Ground**: `#E2BF65`
  * **Flying**: `#A98FF3` | **Psychic**: `#F95587` | **Bug**: `#A6B91A` | **Rock**: `#B6A136`
  * **Ghost**: `#735797` | **Dragon**: `#6F35FC` | **Dark**: `#705746` | **Steel**: `#B7B7CE`
  * **Fairy**: `#D685AD` | **Normal**: `#A8A878`

---

## 📜 Commit Convention (Gitmoji)

This project strictly adheres to Conventional Commits combined with Gitmoji:

* `🏗️ feat(core)`: Project configuration, dependencies, theme & GraphQL setup.
* `📦 feat(data)`: GraphQL queries, models & repository implementations.
* `🧩 feat(presentation)`: Riverpod state providers & reusable UI widgets.
* `📱 feat(ui)`: Screens, splash animations, detail view & entry points.
* `📱 feat(android)`: Native Android launcher icon & manifest configurations.
* `🎨 fix(android)`: Adaptive icon scaling and safe zone alignment.
* `⚡ perf(splash)`: Splash animation speed and transition tuning.
* `✨ feat(splash)`: Debug-to-Prod animated splash morphing.

---

## 📄 License

This project is licensed under the MIT License.
