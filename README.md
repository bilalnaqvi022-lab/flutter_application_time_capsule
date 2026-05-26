# ⏳ Time Capsule — Messages Across Time

> **Seal your thoughts today. Rediscover them when it matters most.**
> A Flutter app to write, lock, and deliver heartfelt messages to your future self or loved ones — unlocked by date, location, or both.

[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B?style=flat-square&logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2?style=flat-square&logo=dart)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

---
ScreenShots
<p align="center">
  <img src="https://github.com/user-attachments/assets/77e934a2-f15d-46cb-a5e0-9d9aa61b5f7d" width="220" hspace="10"/>

  <img src="https://github.com/user-attachments/assets/ba4915f2-08de-444c-9a5b-c709568101d1" width="220" hspace="10"/>

  <img src="https://github.com/user-attachments/assets/205fc42f-70b8-452c-858d-0c3f9329069a" width="220" hspace="10"/>
</p>

<br/>

<p align="center">
  <img src="https://github.com/user-attachments/assets/c9089763-f677-4c3a-8ed0-434aec1c2633" width="220" hspace="10"/>

  <img src="https://github.com/user-attachments/assets/1f4d0519-90a7-4666-9a4a-1e9c637e1626" width="220" hspace="10"/>
</p>

<br/>

<p align="center">
  <img src="https://github.com/user-attachments/assets/43db0413-37df-4a71-a242-a7528d691638" width="220" hspace="10"/>

  <img src="https://github.com/user-attachments/assets/261c3e76-7bc3-4abd-853d-3791978722ed" width="220" hspace="10"/>

  <img src="https://github.com/user-attachments/assets/0ad13082-2ee7-47c6-ac71-950d2a557c3d" width="220" hspace="10"/>
</p>



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
