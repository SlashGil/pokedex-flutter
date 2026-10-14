# ⚡ Pokédex Flutter Application

A modern, responsive, and feature-rich Pokédex application built with **Flutter**, **Riverpod** state management, and **GraphQL** (PokeAPI v1beta).

---

## 📸 Overview & Key Features

* **⚡ GraphQL Network Integration**: Asynchronous data fetching powered by `graphql_flutter` connecting directly to PokeAPI GraphQL (`https://beta.pokeapi.co/graphql/v1beta`).
* **🎨 Environment-Aware Splash Screen**: Animated splash screen that automatically detects build environment (`kDebugMode`):
  * **Debug Mode**: Uses dark terminal theme (`#0F172A`), technical wireframe icon (`ic_pokedex_debug.svg`), and a `DEBUG BUILD` tag.
  * **Production Mode**: Uses clean light theme (`#F6F8FC`), official Pokéball icon (`ic_pokedex_prod.svg`), and tagline.
* **📱 Responsive Pokédex Grid View**: Displays formatted IDs (e.g. `#001`), capitalized names, high-resolution official artwork sprites, and element type badges.
* **🔍 Instant Search & Dynamic Type Filtering**: Search Pokémon by name or ID `#001`, plus horizontal element type pill filters (Grass, Fire, Water, Electric, Dragon, Fairy, etc.).
* **📊 Comprehensive Pokémon Stats View**: Hero artwork animations, physical metrics (Height in meters, Weight in kg), and progress stat bars for HP, ATK, DEF, SATK, SDEF, and SPD.
* **🎯 Modern Material 3 Light Theme**: Styled with a clean off-white background (`#F6F8FC`), white card surfaces (`#FFFFFF`), Pokeball Red accent (`#EE1515`), and dynamic color palettes based on Pokémon element types.

---

## 🛠 Tech Stack & Dependencies

| Category | Technology / Package | Purpose |
| :--- | :--- | :--- |
| **Framework** | Flutter 3.47+ / Dart 3.13+ | Cross-platform mobile development |
| **State Management** | `flutter_riverpod` (`^2.6.1`) | Reactive state & query provider management |
| **Networking** | `graphql_flutter` (`^5.3.0`) & `http` | GraphQL API client & caching |
| **SVG Rendering** | `flutter_svg` (`^2.3.0`) | High-fidelity vector graphics rendering |
| **Image Caching** | `cached_network_image` (`^3.4.1`) | Smooth artwork network caching & placeholders |
| **Typography** | `google_fonts` (`^6.3.3`) | Modern typography |

---

## 📁 Architecture & Project Structure

The project follows a **Feature-Oriented Clean Architecture** pattern:

```text
lib/
├── main.dart                      # Entry point (ProviderScope & GraphQLProvider)
├── core/
│   ├── graphql/                   # GraphQLClient setup & PokeAPI endpoint
│   └── theme/                     # AppTheme & 18 Element Type color mappings
├── data/
│   ├── models/                    # Pokemon model & JSON deserialization
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
* Device or Emulator for running the app

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

5. **Launch the application**:
   ```bash
   flutter run
   ```

---

## 🎨 Design System & Colors

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

## 📄 License

This project is licensed under the MIT License.
