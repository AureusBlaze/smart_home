# 🏠 Smart Home IoT Controller & Management App

A modern, reactive cross-platform **Flutter** application designed for controlling and monitoring connected home IoT devices in real time. Built with sleek **Neumorphic UI** design principles (tactile drop-shadows, responsive power toggles, and high-contrast night modes) and powered by **Supabase** for cloud authentication and real-time database synchronization.

---

## 📌 Badges

<p align="left">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Supabase-Database%20%26%20Auth-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white" alt="Supabase" />
  <img src="https://img.shields.io/badge/UI_Style-Neumorphic-333333?style=for-the-badge" alt="Neumorphic UI" />
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="License" />
</p>

---

## ✨ Key Features

- **🎨 Neumorphic Design System**: Custom soft-shadow surfaces (`BoxShadow` ambient lighting with dual offsets) that visually transform between dark and light states when devices are toggled.
- **🔐 Cloud Authentication**: Secure user registration and login powered by **Supabase Auth**, managed reactively via a persistent `AuthGate` session stream (`onAuthStateChange`).
- **⚡ Real-Time Device CRUD**: Direct PostgreSQL database synchronization via Supabase Realtime streams (`.stream(primaryKey: ['id'])`) allowing instant additions, updates, and deletions without manual refresh.
- **🎛️ Appliance Control Modules**:
  - **Smart Lights**: Dynamic brightness slider ranging from 0 to 100 Lumens with instant value readout.
  - **Smart AC**: Climate control interface for managing ambient temperature and fan speeds.
  - **Smart TV**: Dedicated entertainment display controls and power management.
  - **Smart Speaker**: Audio system controls with live output status.
- **📱 Clean Navigation Flow**: Dark-themed side navigation drawer, centralized `Approutes` table, and authenticated profile screen with quick session logout.

---

## 📐 System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                       Flutter Client                        │
├─────────────────────────────────────────────────────────────┤
│  ┌────────────────────────┐     ┌────────────────────────┐  │
│  │   Presentation Layer   │     │   State & Navigation   │  │
│  │ • HomePage (Grid)      │     │ • AuthGate (Stream)    │  │
│  │ • Appliance Detail UIs │◄───►│ • AppRoutes            │  │
│  │ • Neumorphic Cards     │     │ • Device Controllers   │  │
│  └───────────┬────────────┘     └───────────┬────────────┘  │
│              │                              │               │
│              ▼                              ▼               │
│  ┌───────────────────────────────────────────────────────┐  │
│  │                     Data Services                     │  │
│  │  • AuthService (Supabase Auth Client)                 │  │
│  │  • DeviceDatabase (Supabase Realtime Stream & CRUD)   │  │
│  └───────────────────────────┬───────────────────────────┘  │
└──────────────────────────────┼──────────────────────────────┘
                               │ HTTPS / WebSockets
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                    Supabase Cloud Backend                   │
├──────────────────────────────┬──────────────────────────────┤
│        Supabase Auth         │     PostgreSQL Database      │
│   (JWT Session Management)   │  (`devices` Realtime Table)  │
└──────────────────────────────┴──────────────────────────────┘
```

---

## 📁 Repository Structure

```
smart-home-flutter/
├── .gitattributes                  # GitHub Linguist rules & runner vendoring
├── .gitignore                      # Flutter, Dart, OS & Gradle build ignore rules
├── LICENSE                         # MIT License
├── README.md                       # Architecture & documentation
├── analysis_options.yaml           # Flutter lint configurations
├── pubspec.yaml                    # Project dependencies & asset declarations
├── lib/
│   ├── main.dart                   # Application entrypoint & Supabase init
│   ├── approutes.dart              # Named route registry
│   ├── assets/                     # Custom icons and vector graphics
│   │   ├── icons/                  # Smart device icons (AC, TV, bulb, speaker)
│   │   └── images/                 # Onboarding & hero graphic assets
│   ├── auth/                       # Authentication flow
│   │   ├── auth_gate.dart          # Reactive session stream router
│   │   └── auth_service.dart       # Supabase signIn, signUp, and signOut methods
│   ├── Database/                   # Cloud data persistence
│   │   ├── device.dart             # Device model & serialization logic
│   │   └── device_database.dart    # Supabase PostgreSQL Realtime CRUD operations
│   ├── pages/                      # Application screens
│   │   ├── home_page.dart          # Main Neumorphic dashboard with device grid
│   │   ├── all_devices_page.dart   # Realtime device manager & dialog modals
│   │   ├── locks_page.dart         # Security locks overview
│   │   ├── profile_page.dart       # User details & session management
│   │   ├── register_page.dart      # Account creation screen
│   │   ├── sign_in_page.dart       # Email & password authentication
│   │   └── Devices/                # Dedicated appliance controllers
│   │       ├── smart_ac_page.dart
│   │       ├── smart_lights_page.dart
│   │       ├── smart_speaker_page.dart
│   │       └── smart_tv_page.dart
│   └── util/                       # Reusable UI widgets
│       ├── basic_custom_drawer.dart# Dark-themed drawer navigation
│       ├── device_card.dart        # Realtime device list card with edit/delete
│       ├── my_textfield.dart       # Styled authentication text inputs
│       ├── sign_in_button.dart     # Primary action buttons
│       ├── smart_device_box.dart   # Neumorphic tile with rotated iOS switch
│       └── square_tile.dart        # Third-party auth provider buttons
└── test/
    └── widget_test.dart            # Flutter widget test suite
```

---

## 🛠️ Database Setup (Supabase)

To enable cloud device persistence, create the `devices` table in your Supabase project's SQL editor:

```sql
CREATE TABLE public.devices (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    content TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable Row Level Security (RLS)
ALTER TABLE public.devices ENABLE ROW LEVEL SECURITY;

-- Allow authenticated users to perform CRUD operations
CREATE POLICY "Enable read access for all users" ON public.devices
    FOR SELECT USING (true);

CREATE POLICY "Enable insert access for authenticated users" ON public.devices
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Enable update access for authenticated users" ON public.devices
    FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable delete access for authenticated users" ON public.devices
    FOR DELETE USING (auth.role() = 'authenticated');
```

---

## 🚀 Quick Start

### 1. Prerequisites
- **Flutter SDK**: `>= 3.8.1` ([Install Flutter](https://docs.flutter.dev/get-started/install))
- **Dart SDK**: Included with Flutter
- A configured **Supabase** project (URL and Anon Public Key)

### 2. Clone the Repository
```bash
git clone https://github.com/AureusBlaze/smart_home.git
cd smart_home
```

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Configure Supabase Credentials
Ensure your Supabase URL and anonymous key in `lib/main.dart` match your project:

```dart
await Supabase.initialize(
  url: 'YOUR_SUPABASE_PROJECT_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
);
```

### 5. Run the Application
Launch on your connected mobile device, emulator, or desktop runner:
```bash
flutter run
```

---

## 📜 License

Distributed under the **MIT License**. See `LICENSE` for full details.

Developed by [Omar Sami Niyazi Al-maqtari](https://github.com/AureusBlaze).
