 <h1>Savify 💰</h1>

A modern Flutter finance tracker app powered by AI agents for intelligent financial management and insights.

## Features ✨

### Core Functionality
- **Transaction Management**: Track income and expenses with detailed categorization
- **Real-time Balance**: Monitor your total balance, income, and expenses at a glance
- **Category-based Tracking**: Organize transactions across multiple categories (Food, Transport, Shopping, Bills, etc.)
- **Visual Analytics**: Interactive pie charts showing spending distribution by category

### AI-Powered Features 🤖
- **Smart Insights**: AI agent automatically analyzes your spending patterns and provides personalized insights
- **Financial Advice**: Ask the AI assistant questions about budgeting, saving, and investing
- **Spending Alerts**: Get warned when expenses are too high relative to income
- **Category Analysis**: AI identifies your highest spending categories and suggests optimizations
- **Savings Recommendations**: Receive suggestions for how to allocate your savings

### User Experience
- **Material Design 3**: Modern, beautiful UI with light and dark theme support
- **Intuitive Navigation**: Bottom navigation bar for easy access to all features
- **Quick Actions**: Swipe to delete transactions
- **Date Selection**: Choose transaction dates with an integrated date picker
- **Real-time Updates**: All changes reflect immediately across the app

## Screenshots 📱

The app includes three main screens:

1. **Home Screen**: Overview of your balance, quick stats, and recent transactions
2. **Transactions Screen**: Complete list of all transactions with filtering options
3. **AI Insights Screen**: AI-generated insights and an interactive AI assistant

## Technology Stack 🛠️

- **Framework**: Flutter 3.0+
- **State Management**: Provider
- **Local Storage**: SharedPreferences
- **Charts**: FL Chart
- **AI Integration**: Google Generative AI (Gemini)
- **UI/UX**: Material Design 3, Google Fonts

## Getting Started 🚀

### Prerequisites
- Flutter SDK 3.0 or higher
- Dart SDK 3.0 or higher

### Installation

1. Clone the repository:
```bash
git clone https://github.com/nidhisingh5958/Savify.git
cd Savify
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure 📁

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── transaction.dart
│   ├── budget.dart
│   └── ai_insight.dart
├── providers/                # State management
│   ├── transaction_provider.dart
│   └── ai_agent_provider.dart
├── screens/                  # App screens
│   ├── home_screen.dart
│   ├── transactions_screen.dart
│   ├── ai_insights_screen.dart
│   └── add_transaction_screen.dart
├── widgets/                  # Reusable widgets
│   ├── balance_card.dart
│   ├── quick_stats.dart
│   └── recent_transactions.dart
└── services/                 # Business logic
    └── ai_agent_service.dart
```

## How It Works 🔍

### Transaction Tracking
1. Add transactions using the floating action button
2. Categorize each transaction (Income or Expense)
3. View all transactions in the Transactions screen
4. Delete unwanted transactions with a swipe gesture

### AI Agent Features
The AI agent analyzes your financial data to provide:
- **Spending Pattern Detection**: Identifies categories where you spend the most
- **High Spending Alerts**: Warns when expenses exceed a healthy percentage of income
- **Savings Suggestions**: Recommends how to allocate surplus income
- **Interactive Chat**: Ask questions and get personalized financial advice

### Data Persistence
All data is stored locally using SharedPreferences, ensuring:
- Fast access to your financial data
- Privacy (no data sent to external servers)
- Offline functionality

## Future Enhancements 🔮

- [ ] Budget setting and tracking per category
- [ ] Recurring transactions
- [ ] Export data to CSV/PDF
- [ ] Multi-currency support
- [ ] Cloud sync across devices
- [ ] Advanced AI predictions using real ML models
- [ ] Financial goal setting and tracking
- [ ] Bill reminders and notifications

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact 📧

For questions or suggestions, please open an issue on GitHub.

---

Made with ❤️ using Flutter and AI
