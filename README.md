# Quick Budget Tracker

A cross-platform Flutter application for tracking expenses and income, designed with a clean, user-friendly interface and local data persistence using Hive. Built to demonstrate proficiency in mobile app development, modular design, and data management, this app is ideal for personal finance tracking.

## Features

- **Real-Time Balance Tracking**: Add income and expense transactions to monitor your current balance instantly.
- **Expense Analysis**: Visualize expense distribution by category with percentage breakdowns and progress bars.
- **Currency Selection**: Choose from multiple currencies (₹, $, €, £) to customize display, persisted using Hive.
- **Data Management**: Reset transaction data with a confirmation dialog for user control.
- **Responsive UI**: Designed with Material Design principles, featuring rounded cards, custom widgets, and a cohesive color scheme (grey background, blue-grey accents).

## Tech Stack

- **Languages**: Dart
- **Framework**: Flutter (Cross-Platform Mobile Development)
- **Database**: Hive (NoSQL, local persistence)
- **Tools**: Git, VS Code, Android Studio
- **Libraries**: `intl` for date formatting, `hive_flutter` for data storage

## Screenshots

![Home Page](screenshots/home_page.png)
![Stats Page](screenshots/stats_page.png)


## Getting Started

### Prerequisites

- Flutter SDK (version 3.24.x or later)
- Dart
- Android Studio or VS Code
- Android/iOS emulator or physical device

###Project Structure
expense_tracker/


dependencies:
  flutter:
    sdk: flutter
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  intl: ^0.19.0
### Installation

 **Clone the Repository**:
   ```bash
   git clone https://github.com/Pradeep1234566/expense_tracker.git
   cd expense_tracker
   flutter pub get
   flutter run

**Dependencies**
├── lib/
│   ├── models/
│   │   └── transaction_model.dart  # Transaction data model with Hive adapter
│   ├── pages/
│   │   ├── home_page.dart          # Main page for balance and transactions
│   │   ├── stats_page.dart         # Expense visualization
│   │   ├── settings_page.dart      # Currency and data reset settings
│   │   └── common_page.dart        # Transaction input page
│   ├── widget/
│   │   ├── button.dart             # Custom button widget
│   │   └── transaction_tile.dart   # Transaction display widget
│   └── main.dart                   # App entry point
├── screenshots/                    # Screenshots for README
└── pubspec.yaml                    # Dependencies

'''

