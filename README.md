# Car Market App

A dark-themed car marketplace app built with Flutter. A buyer browses cars, makes an offer to the seller, negotiates over chat, checks out, pays with a wallet or card, tracks the delivery and leaves a review.

Built with **Flutter**, **Provider** and **Firebase**, following the **MVVM** architecture.

---

## Table of Contents

1. [Features](#features)
2. [Screens](#screens)
3. [Tech Stack](#tech-stack)
4. [Architecture (MVVM)](#architecture-mvvm)
5. [Project Structure](#project-structure)
6. [Getting Started](#getting-started)
7. [Firebase Setup](#firebase-setup)
8. [Data Model](#data-model)
9. [Navigation](#navigation)
10. [Development Roadmap](#development-roadmap)
11. [Testing](#testing)
12. [Build and Release](#build-and-release)
13. [Coding Guidelines](#coding-guidelines)
14. [Roadmap Status](#roadmap-status)
15. [Future Improvements](#future-improvements)
16. [Author](#author)

---

## Features

**Browse and discover**
- Car listing with search
- Car detail page with price, specs and photos
- Store reviews with rating summary and star filters

**Offer system**
- Enter your own price with a custom numpad
- Quick-amount chips for fast offers
- Offer states: processing, accepted, rejected
- Retry with a new offer after a rejection

**Checkout**
- Choose from saved shipping addresses or add a new one
- Choose a shipping method (truck, train, container ship, plane), each with its own price
- Live price breakdown: amount + shipping + tax = total

**Payment**
- Multiple payment methods: wallet, PayPal, Google Pay, Apple Pay, card
- Review summary before paying
- 4-digit PIN confirmation
- Success popup with links to the order and the receipt

**Orders**
- Active and completed tabs
- Step-by-step order tracking timeline
- Leave a review with star rating and comment after delivery
- Empty state when there are no orders

**Chat and calls**
- Inbox with chats and calls tabs
- Real-time chat with dealers, image sharing
- Call screen with mute, speaker and end controls

**E-Wallet**
- Balance card and transaction history
- Top up with amount entry, payment method and PIN
- Pay for orders straight from the wallet balance

---

## Screens

The UI follows a 30-screen dark design kit, grouped into these flows:

| Flow | Screens |
|---|---|
| Reviews | Reviews list |
| Offer | Make an Offer, Processing, Accepted, Rejected |
| Checkout | Checkout, Shipping Address, Choose Shipping, Review Summary |
| Payment | Payment Methods, Enter PIN, Order Successful |
| Orders | My Orders (active/completed), Track Order, Leave a Review |
| Chat | Inbox, Chat, Voice Call |
| Wallet | My E-Wallet, Top Up, Enter PIN, Top Up Successful |

Add screenshots to `assets/screenshots/` and link them here once the UI is built.

---

## Tech Stack

| Area | Technology |
|---|---|
| Framework | Flutter (Dart 3.3+) |
| State management | Provider (`ChangeNotifier`) |
| Navigation | go_router |
| Backend | Firebase (Auth, Cloud Firestore, Storage, Cloud Messaging) |
| Fonts | google_fonts (Urbanist) |
| Images | cached_network_image |
| Ratings | flutter_rating_bar |
| Formatting | intl |
| Secure storage | flutter_secure_storage (for the PIN) |

---

## Architecture (MVVM)

The code is split into layers. Each layer has one job and only talks to the layer directly below it.

```
View  ->  ViewModel  ->  Repository  ->  Service  ->  Firebase
```

| Layer | Location | Responsibility |
|---|---|---|
| View | `features/*/view/` | Draws the UI. Reads state with `context.watch`. No business logic. |
| ViewModel | `features/*/viewmodel/` | Holds screen state and logic. Extends `ChangeNotifier`. |
| Repository | `data/repositories/` | Abstracts where data comes from. Has a mock and a Firebase version. |
| Service | `data/services/` | Direct Firebase and API calls. |
| Model | `data/models/` | Plain Dart classes with `fromMap` and `toMap`. |

**Why this way**
- Views stay simple and easy to change.
- ViewModels can be unit tested without Firebase.
- Switching from mock data to Firebase needs no change in views or ViewModels, only the repository implementation is swapped.

---

## Project Structure

```
car_market_app/
├── assets/
│   ├── images/
│   ├── icons/
│   └── screenshots/
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── theme/
│   │   │   └── app_theme.dart
│   │   ├── router/
│   │   │   └── app_router.dart
│   │   ├── widgets/
│   │   │   ├── num_pad.dart
│   │   │   ├── pin_dots.dart
│   │   │   └── primary_button.dart
│   │   ├── constants/
│   │   │   └── app_constants.dart
│   │   └── utils/
│   │       └── formatters.dart
│   ├── data/
│   │   ├── models/
│   │   │   ├── car.dart
│   │   │   ├── offer.dart
│   │   │   ├── order.dart
│   │   │   ├── chat_message.dart
│   │   │   ├── wallet_transaction.dart
│   │   │   ├── review.dart
│   │   │   └── address.dart
│   │   ├── repositories/
│   │   │   ├── car_repository.dart
│   │   │   ├── offer_repository.dart
│   │   │   ├── order_repository.dart
│   │   │   ├── chat_repository.dart
│   │   │   ├── wallet_repository.dart
│   │   │   └── review_repository.dart
│   │   └── services/
│   │       ├── firestore_service.dart
│   │       └── auth_service.dart
│   └── features/
│       ├── offer/
│       │   ├── view/
│       │   ├── viewmodel/
│       │   └── widgets/
│       ├── checkout/
│       ├── payment/
│       ├── orders/
│       ├── reviews/
│       ├── chat/
│       ├── wallet/
│       ├── home/       (planned)
│       ├── auth/       (planned)
│       └── profile/    (planned)
├── test/
├── pubspec.yaml
└── README.md
```

Each feature folder has the same three subfolders: `view/`, `viewmodel/` and `widgets/`.

| Folder | Purpose |
|---|---|
| `core/` | Things shared by the whole app: theme, router, reusable widgets, constants, helpers |
| `data/` | Models, repositories and services. No UI code here |
| `features/` | One folder per feature, each with its own views, ViewModel and small widgets |
| `test/` | Unit and widget tests, mirroring the `lib/` structure |

---

## Getting Started

### Prerequisites

- Flutter SDK 3.19 or newer ([install guide](https://docs.flutter.dev/get-started/install))
- Dart 3.3 or newer (comes with Flutter)
- Android Studio or VS Code with the Flutter extension
- An Android emulator or a physical device
- A Firebase account (only needed from the backend phase onwards)

Check your setup:

```bash
flutter doctor
```

### Installation

```bash
# clone the repository
git clone <your-repo-url>
cd car_market_app

# install packages
flutter pub get

# run the app
flutter run
```

If you are starting from the folder structure only (no platform folders yet), run this once inside the project folder:

```bash
flutter create .
```

This generates the `android/` and `ios/` folders and leaves `lib/` untouched.

### Running with mock data

The app starts with mock repositories, so it runs without any backend. Mock data includes sample cars, orders, chats and transactions. This is the default while the UI is being built.

---

## Firebase Setup

Do this when you move from mock data to the real backend.

1. Create a project in the [Firebase console](https://console.firebase.google.com).
2. Install the tools:
   ```bash
   dart pub global activate flutterfire_cli
   ```
3. Link the app:
   ```bash
   flutterfire configure
   ```
4. Add the packages:
   ```bash
   flutter pub add firebase_core firebase_auth cloud_firestore firebase_storage firebase_messaging
   ```
5. Initialise Firebase in `main.dart`:
   ```dart
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
     runApp(const CarMarketApp());
   }
   ```
6. Enable **Email/Password** sign-in under Authentication.
7. Create the Firestore database and add the security rules below.
8. Replace each `MockXRepository` with its `FirebaseXRepository` in the provider setup.

### Firestore collections

| Collection | Contents |
|---|---|
| `users/{userId}` | Profile, saved addresses, wallet balance |
| `users/{userId}/transactions` | Wallet history |
| `cars/{carId}` | Listings |
| `offers/{offerId}` | Offers with buyer, car, amount and status |
| `orders/{orderId}` | Orders with amounts, shipping and status |
| `chats/{chatId}/messages/{messageId}` | Chat messages |
| `reviews/{reviewId}` | Ratings and comments |

### Security rules (starting point)

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /cars/{carId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
    match /offers/{offerId} {
      allow read, write: if request.auth != null;
    }
    match /orders/{orderId} {
      allow read, write: if request.auth != null;
    }
    match /chats/{chatId}/messages/{messageId} {
      allow read, write: if request.auth != null;
    }
    match /reviews/{reviewId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

Tighten these before release. For example, only the buyer and the seller of an offer should be able to read it.

**Do not commit** `google-services.json`, `GoogleService-Info.plist` or any API keys. Keep them in `.gitignore`.

---

## Data Model

| Model | Main fields |
|---|---|
| `Car` | id, name, brand, price, imageUrls, specs, sellerId |
| `Offer` | id, carId, buyerId, amount, status (processing / accepted / rejected), createdAt |
| `CarOrder` | id, carId, address, shippingType, amount, shipping, tax, status (verified / packing / inTransit / delivered), total |
| `ChatMessage` | id, text, senderId, time, images |
| `WalletTransaction` | id, title, amount, date, isTopUp |
| `Review` | id, userName, rating, comment, createdAt, likes |
| `Address` | id, label, fullAddress, isDefault |

The order total is a getter on the model (`amount + shipping + tax`). It is never calculated inside a widget.

---

## Navigation

Routing uses `go_router`. The bottom navigation bar is built with a `ShellRoute` so the tabs keep their state.

| Tab | Route |
|---|---|
| Home | `/home` |
| Orders | `/orders` |
| Inbox | `/inbox` |
| Wallet | `/wallet` |
| Profile | `/profile` |

Flow routes:

```
/make-offer -> /offer-processing -> /offer-accepted -> /checkout
/checkout -> /shipping-address, /choose-shipping -> /review-summary
/review-summary -> /payment-methods -> /enter-pin -> /order-success
/orders -> /track-order -> /leave-review
/inbox -> /chat -> /call
/wallet -> /top-up -> /enter-pin -> /top-up-success
```

---

## Development Roadmap

| Phase | Work | Time |
|---|---|---|
| 0 | Foundation: theme, core widgets, models, router, `MultiProvider` | 1-2 days |
| 1 | Mock repositories and sample data, ViewModel injection | 1 day |
| 2 | Home, car detail, login and register screens | 1-2 days |
| 3 | Offer flow | 2 days |
| 4 | Checkout flow | 2 days |
| 5 | Payment flow (MVP milestone) | 2 days |
| 6 | Orders, tracking and reviews | 2-3 days |
| 7 | Chat and call UI | 3-4 days |
| 8 | E-Wallet | 2 days |
| 9 | Firebase backend | 3-4 days |
| 10 | Polish: loading, empty and error states, validation, animations, notifications | 2-3 days |
| 11 | Testing | 2 days |
| 12 | Release | 1-2 days |

Estimated total: 4-5 weeks at 3-4 hours a day. The MVP (phases 0-5) takes about 2 weeks.

Work on one feature at a time and finish it before starting the next. Commit after every phase.

---

## Testing

Run all tests:

```bash
flutter test
```

What to cover:

| Test | Checks |
|---|---|
| `checkout_viewmodel_test` | Total updates when the shipping method changes |
| `offer_viewmodel_test` | Digit entry, backspace, empty amount is rejected |
| `payment_viewmodel_test` | Wrong PIN is rejected, correct PIN is accepted |
| `num_pad_test` | Key taps fire the callback |

Because ViewModels depend on repository interfaces, tests use the mock repositories and need no Firebase connection.

---

## Build and Release

**App icon and splash**

```bash
flutter pub add --dev flutter_launcher_icons flutter_native_splash
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

**Android release build**

```bash
flutter build apk --release        # APK for direct install
flutter build appbundle --release  # AAB for Play Store
```

Before the Play Store build:
- Set a unique package name (`applicationId`) in `android/app/build.gradle`
- Update the version in `pubspec.yaml`
- Create a signing key and keep it safe. Never commit the keystore or its passwords.
- Prepare screenshots, description and a privacy policy

---

## Coding Guidelines

**Naming**
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Screens end with `_screen`, bottom sheets with `_sheet`
- ViewModels: `xyz_viewmodel.dart` with class `XyzViewModel`
- Repositories: abstract `OfferRepository`, implementations `MockOfferRepository` and `FirebaseOfferRepository`
- One main class per file

**Rules**
1. Views contain no business logic.
2. ViewModels never call Firebase directly. They go through a repository.
3. A widget used by two or more features goes in `core/widgets/`.
4. Colors, font sizes and spacing come from the theme or constants, never hard-coded in a screen.
5. Every screen handles loading, empty and error states.
6. Never store the PIN in plain text.

**Where does a new file go?**

| It is... | Put it in |
|---|---|
| UI for one feature | `features/<feature>/view/` or `widgets/` |
| UI shared across features | `core/widgets/` |
| State or logic | `features/<feature>/viewmodel/` |
| A data shape | `data/models/` |
| A data source decision | `data/repositories/` |
| A Firebase or API call | `data/services/` |
| Colors, fonts, spacing | `core/theme/` or `core/constants/` |

---

## Roadmap Status

- [x] Folder structure (MVVM)
- [ ] Phase 0: Foundation
- [ ] Phase 1: Mock data layer
- [ ] Phase 2: Home, detail, auth
- [ ] Phase 3: Offer flow
- [ ] Phase 4: Checkout
- [ ] Phase 5: Payment
- [ ] Phase 6: Orders and reviews
- [ ] Phase 7: Chat and call
- [ ] Phase 8: E-Wallet
- [ ] Phase 9: Firebase backend
- [ ] Phase 10: Polish
- [ ] Phase 11: Testing
- [ ] Phase 12: Release

Tick these off as you go.

---

## Future Improvements

- Real voice and video calls (Agora or WebRTC)
- Seller dashboard to list cars and accept or reject offers
- Push notifications for offer and order updates
- Real payment gateway integration (Stripe or Razorpay)
- Wishlist and saved searches
- Car comparison
- Light theme
- Multi-language support

---

## Author

Built by **Aman**.

Feedback and suggestions are welcome. Open an issue or send a pull request.