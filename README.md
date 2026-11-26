# SOFI — Nordic & Japandi Furniture App

Aplikasi katalog furnitur bergaya **Nordic & Japandi** (*"Kenyamanan Ruang, Dimulai dari Sini"*) yang dibangun menggunakan **Flutter** dengan penerapan **Clean Architecture**, **Separation of Concerns (SoC)**, dan **State Management BLoC / Cubit**.

---

## 🎥 Demo Aplikasi (Google Drive)

Silakan akses video demo, file APK, atau dokumentasi visual aplikasi melalui tautan Google Drive di bawah ini:

> **[🔗 Link Demo Google Drive — SOFI App](https://drive.google.com/drive/folders/MASUKKAN_LINK_FOLDER_GOOGLE_DRIVE_ANDA_DI_SINI)**

*(Ganti URL placeholder di atas dengan tautan folder atau video Google Drive Anda, dan pastikan akses berbagi sudah diatur ke **"Anyone with the link / Siapa saja yang memiliki link"**).*

---

## 🏛️ Arsitektur Proyek (Clean Architecture & Separation of Concerns)

Proyek ini memisahkan kode berdasarkan fitur (*feature-first*) dan tanggung jawab lapisan (*layer-based*) agar mudah dipelihara, diskalakan, dan diuji (*testable*):

```text
Presentation Layer (UI & Cubit)
        │  memanggil
        ▼
Domain Layer (Entities, UseCases, Repository Contracts)  ◄── Independen dari framework/datasource
        ▲  mengimplementasikan
        │
Data Layer (Models, DataSources, Repository Impl)
```

### Struktur Direktori

```text
lib/
├── core/                                      # Konfigurasi global aplikasi
│   ├── constants/
│   │   ├── app_colors.dart                    # Token palet warna Japandi & Terracotta
│   │   ├── app_strings.dart                   # Konstanta teks & metadata aplikasi
│   │   └── app_typography.dart                # Tipografi berbasis Plus Jakarta Sans
│   └── theme/
│       └── app_theme.dart                     # Pengaturan Material 3 ThemeData
│
├── features/
│   ├── splash/                                # Fitur Splash Screen
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── splash_config.dart         # Entity konfigurasi splash
│   │   │   ├── repositories/
│   │   │   │   └── splash_repository.dart     # Kontrak abstrak repository splash
│   │   │   └── usecases/
│   │   │       ├── get_splash_config_usecase.dart
│   │   │       └── initialize_app_usecase.dart
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── splash_local_datasource.dart   # Simulasi stream progress inisialisasi
│   │   │   ├── models/
│   │   │   │   └── splash_config_model.dart
│   │   │   └── repositories/
│   │   │       └── splash_repository_impl.dart
│   │   └── presentation/
│   │       ├── cubit/
│   │       │   ├── splash_cubit.dart          # Pengelola state loading & interaksi aura
│   │       │   └── splash_state.dart
│   │       ├── pages/
│   │       │   └── splash_page.dart           # Halaman utama splash + DI factory
│   │       └── widgets/                       # Komponen UI terpisah (SoC)
│   │           ├── ambient_aura_background.dart
│   │           ├── brand_identity_view.dart
│   │           ├── editorial_tags_view.dart
│   │           ├── fluid_progress_bar.dart
│   │           ├── sofa_icon_painter.dart     # CustomPainter vektor ikon sofa
│   │           └── top_indicator_bar.dart
│   │
│   └── home/                                  # Fitur Katalog / Landing Page
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── product_category.dart      # Entity kategori produk
│       │   │   ├── product_item.dart          # Entity item sofa
│       │   │   └── promo_banner.dart          # Entity banner promo
│       │   ├── repositories/
│       │   │   └── home_repository.dart       # Kontrak abstrak katalog
│       │   └── usecases/
│       │       ├── get_categories_usecase.dart
│       │       ├── get_products_usecase.dart
│       │       ├── get_promo_banner_usecase.dart
│       │       └── search_products_usecase.dart
│       ├── data/
│       │   ├── datasources/
│       │   │   └── home_local_datasource.dart # Seed data katalog & pencarian
│       │   ├── models/
│       │   │   └── product_item_model.dart
│       │   └── repositories/
│       │       └── home_repository_impl.dart
│       └── presentation/
│           ├── cubit/
│           │   ├── home_cubit.dart            # Pengelola filter, search, favorit & keranjang
│           │   └── home_state.dart            # State immutable + kalkulasi total harga
│           ├── pages/
│           │   └── home_page.dart             # Halaman katalog + floating order bar
│           └── widgets/                       # Komponen UI modular
│               ├── category_filter_row.dart
│               ├── floating_order_bar.dart
│               ├── home_header_bar.dart
│               ├── product_card.dart
│               ├── promo_banner_card.dart
│               └── search_filter_bar.dart
│
└── main.dart                                  # Entry point & navigasi transisi Fade
```

---

## ⚡ State Management: BLoC / Cubit (`flutter_bloc`)

Aplikasi ini menggunakan pola **Cubit** dari `flutter_bloc` untuk memisahkan *business logic* dan *UI state* secara reaktif dan prediktabel (*unidirectional data flow*):

1. **`SplashCubit` & `SplashState`**
   - Mengelola siklus inisialisasi aplikasi (`SplashStatus.initial`, `loading`, `completed`, `failure`).
   - Memantau *stream* progres pemuatan (`progress` dari `0.35` hingga `1.0`) untuk menggerakkan `FluidProgressBar` dan memicu navigasi otomatis ke `HomePage`.
   - Menangani interaksi sentuhan pada logo (`setAuraExpanded`) untuk memberikan efek *tactile breathing aura*.

2. **`HomeCubit` & `HomeState`**
   - Memuat data awal secara paralel menggunakan `Future.wait` (`GetCategoriesUseCase`, `GetPromoBannerUseCase`, `GetProductsUseCase`).
   - Mengelola penyaringan kategori (`selectCategory`), pencarian real-time (`search`), status favorit (`toggleFavorite`), serta manajemen keranjang (`addToCart`, `removeFromCart`, `clearCart`).
   - Menghitung total item (`cartCount`) dan memformat total nominal rupiah (`formattedCartTotal`) langsung di dalam *immutable state* sehingga UI tetap ringan dan deklaratif.

---

## ✨ Fitur Utama

- **Splash Screen Interaktif**
  - Latar belakang organik *ambient blur aura* dengan animasi *breathing* halus.
  - Ilustrasi ikon sofa vektor presisi menggunakan `CustomPainter` (`SofaIconPainter`).
  - Micro-progress bar bergradasi terracotta dan transisi `FadeTransition` menuju katalog.
- **Katalog / Landing Page (`HomePage`)**
  - Header modern dengan badge keranjang dinamis.
  - Pencarian produk real-time dan filter kategori horizontal (*Semua, Minimalis, Sofa Bed, L-Shape, Velvet, 2-Seater*).
  - Banner promo dan grid katalog 2 kolom yang mendukung tampilan gambar di **Web & Mobile** (`Image.network` lengkap dengan *loading* dan *error fallback*).
  - Toggle tombol favorit pada tiap produk dan *Floating Order Summary Bar* animatif dengan modal konfirmasi pesanan.

---

## 🛠️ Tech Stack & Dependensi

- **Flutter** & **Dart SDK** (`^3.9.2`)
- [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) (`^9.1.1`) — State Management (Cubit)
- [`google_fonts`](https://pub.dev/packages/google_fonts) (`^8.1.0`) — Tipografi `Plus Jakarta Sans`
- `cupertino_icons` (`^1.0.8`)

---

## 🚀 Cara Menjalankan & Pengujian

1. **Install dependensi**
   ```bash
   flutter pub get
   ```

2. **Jalankan di Mobile / Emulator atau Web (Chrome)**
   ```bash
   # Menjalankan di perangkat / emulator default
   flutter run

   # Menjalankan di browser Chrome (Web)
   flutter run -d chrome
   ```

3. **Analisis Kode & Jalankan Unit/Widget Test**
   ```bash
   flutter analyze
   flutter test
   ```
   Pengujian tersedia di:
   - `test/features/splash/cubit_test.dart`
   - `test/widget_test.dart`
