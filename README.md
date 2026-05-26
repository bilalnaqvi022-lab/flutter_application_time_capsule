# ⏳ Time Capsule — Messages Across Time

> **Seal your thoughts today. Rediscover them when it matters most.**
> A Flutter app to write, lock, and deliver heartfelt messages to your future self or loved ones — unlocked by date, location, or both.

[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B?style=flat-square&logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2?style=flat-square&logo=dart)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

---

## 📖 Description

Time Capsule is a beautifully crafted Flutter app that lets users compose personal messages and seal them inside digital capsules. Each capsule is locked until a chosen date arrives or a specific location is reached — turning ordinary memories into meaningful surprises. Whether writing to a future self, a best friend's wedding day, or a child's graduation, Time Capsule makes time itself part of the message.

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🔐 **Secure Auth** | Email/password sign-in and sign-up with JWT-ready tab UI |
| 🗃️ **Vault** | Browse all capsules filtered by Locked, Unlocked, or Scheduled |
| ✍️ **Create Capsule** | 4-step guided flow — Details, Message, Unlock Condition, Review |
| 📅 **Date Lock** | Capsule unseals on a chosen future date |
| 📍 **Location Lock** | Capsule unseals when the user arrives at a set place |
| 🔒 **Peek / Hide** | Preview a locked message without fully breaking the seal |
| ⏱️ **Countdown Timer** | Live days / hours / minutes countdown to unlock |
| 💌 **Send to Others** | Address a capsule to a friend, family member, or loved one |
| 🌐 **Explore** | Templates (Graduation, Anniversary, New Year) and community stories |
| 👤 **Profile** | Stats, preferences, dark mode toggle, biometric lock, sign out |
| 🌟 **Starfield UI** | Animated twinkling star background across all screens |
| 🎞️ **Polished Animations** | Expanding rings on splash, page slide transitions, animated reveals |

---

## 📱 Screens

### 🌟 Splash
Animated concentric amber rings expand outward around the ⏳ icon, fading into the onboarding flow.

### 🎠 Onboarding (3 pages)
Swipeable pages — *Write to Your Future Self*, *Lock Until the Moment*, *Surprise Your Loved Ones* — with per-page gradient buttons and slide-in animations.

### 🔑 Auth
Tabbed Sign In / Sign Up card with animated tab indicator, password visibility toggle, and "Forgot password?" shortcut.

### 🗃️ Vault
Stat chips (Locked / Open / Scheduled), scrollable filter chips, and capsule cards showing emoji badge, status pill, masked or revealed message preview, recipient, and unlock date.

### 📄 Capsule Detail
Hero card with emoji, title, recipient, created/opens dates, animated countdown timer, unlock condition info card, and a Peek/Hide message toggle with smooth `AnimatedSwitcher`.

### ➕ Create Capsule (4 steps)
1. **Details** — title, recipient toggle (self / friend), emoji picker, color picker
2. **Message** — full-screen text editor, end-to-end encryption badge
3. **Unlock** — Date / Location / Both selector, date picker, location search field
4. **Review** — preview card + immutability warning before sealing

### 🌐 Explore
Horizontal template cards, "How It Works" 3-step card, and community story cards.

### 👤 Profile
Avatar, capsule stats, preferences (notifications, dark mode, language), security (password, biometrics, 2FA), app info, and sign out.

---

## 🏗️ Project Structure

```
lib/
├── models/
│   ├── capsule.dart              # Capsule model, CapsuleStatus, UnlockType enums
│   └── sample_data.dart          # Demo capsules for development
│
├── screens/
│   ├── splash_screen.dart        # Ring animation + starfield
│   ├── onboarding_screen.dart    # 3-page PageView with gradient buttons
│   ├── auth_screen.dart          # Sign in / sign up tabs
│   ├── home_screen.dart          # Bottom nav shell + FAB
│   ├── vault_screen.dart         # Capsule list with filters
│   ├── capsule_detail_screen.dart# Detail view + countdown + peek
│   ├── create_capsule_screen.dart# 4-step capsule creation wizard
│   ├── explore_screen.dart       # Templates + community stories
│   └── profile_screen.dart       # User stats + settings
│
├── widgets/
│   ├── starfield_background.dart # Animated twinkling star canvas
│   ├── capsule_card.dart         # List tile with status, emoji, masked text
│   ├── countdown_widget.dart     # Days / Hrs / Min countdown display
│   ├── stat_chip.dart            # Vault header stat badges
│   └── nav_item.dart             # Bottom navigation tab item
│
├── theme/
│   └── app_colors.dart           # Color palette and text style constants
│
└── main.dart                     # Entry point + MaterialApp
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>= 3.0.0`
- Dart SDK `>= 3.0.0`
- Android SDK or Xcode (for iOS builds)

### Install & Run

```bash
git clone https://github.com/your-username/time-capsule.git
cd time-capsule
flutter pub get
flutter run
```

### Build

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## 🎨 Design System

| Token | Value | Usage |
|-------|-------|-------|
| Background | `#070B18` | App background |
| Surface | `#0F1628` | Cards, input fields |
| Amber | `#E8A94D` | Primary accent, locked state |
| Amber Light | `#F5C842` | Highlights, glow |
| Purple | `#AA84DB` | Scheduled state, onboarding page 2 |
| Rose | `#E8617A` | Unlocked state, onboarding page 3 |
| Teal | `#4ECDC4` | Open state, exploration |
| Cream | `#F5F0E8` | Primary text |
| Text Sub | `#8A93AA` | Secondary / muted text |

---

## 🔒 Capsule States

| Status | Color | Meaning |
|--------|-------|---------|
| 🔒 Locked | Amber | Sealed, unlock date not yet reached |
| 📬 Unlocked | Teal | Open and readable |
| 🕐 Scheduled | Purple | Created, awaiting a future trigger |

---

## 🗺️ Roadmap

- [ ] Firebase Auth + Firestore backend
- [ ] Real GPS-based location unlock via `geolocator`
- [ ] Push notifications when a capsule unlocks
- [ ] Share capsule as a styled image card
- [ ] Biometric lock integration
- [ ] Capsule templates library
- [ ] Multiple language support

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m "Add my feature"`
4. Push to the branch: `git push origin feature/my-feature`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details."# flutter_application_time_capsule" 
