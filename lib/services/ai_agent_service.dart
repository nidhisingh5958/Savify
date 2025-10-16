import 'dart:math';
import '../models/transaction.dart';
import '../models/ai_insight.dart';

/// AI Agent Service for generating financial insights and recommendations
/// This is a mock implementation that simulates AI behavior
/// In production, this would integrate with actual AI services like Google Gemini
class AIAgentService {
  final Random _random = Random();

  /// Generate financial insights based on transaction history
  Future<List<AIInsight>> generateInsights(
    List<Transaction> transactions,
    double monthlyBudget,
  ) async {
    // Simulate AI processing delay
    await Future.delayed(const Duration(seconds: 1));

    final insights = <AIInsight>[];

    if (transactions.isEmpty) {
      return insights;
    }

    // Calculate spending patterns
    final totalExpenses = transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);

    final totalIncome = transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);

    // Spending analysis
    if (totalExpenses > totalIncome * 0.8) {
      insights.add(
        AIInsight(
          id: 'insight_${DateTime.now().millisecondsSinceEpoch}_1',
          title: '⚠️ High Spending Alert',
          description:
              'Your expenses are ${((totalExpenses / totalIncome) * 100).toStringAsFixed(1)}% of your income. Consider reducing discretionary spending.',
          type: 'warning',
          createdAt: DateTime.now(),
        ),
      );
    }

    // Category analysis
    final categorySpending = <Category, double>{};
    for (var transaction in transactions.where(
      (t) => t.type == TransactionType.expense,
    )) {
      categorySpending[transaction.category] =
          (categorySpending[transaction.category] ?? 0) + transaction.amount;
    }

    if (categorySpending.isNotEmpty) {
      final topCategory = categorySpending.entries.reduce(
        (a, b) => a.value > b.value ? a : b,
      );

      insights.add(
        AIInsight(
          id: 'insight_${DateTime.now().millisecondsSinceEpoch}_2',
          title: '📊 Spending Pattern Detected',
          description:
              'Your highest spending category is ${categoryToString(topCategory.key)} at \$${topCategory.value.toStringAsFixed(2)}. Consider setting a budget for this category.',
          type: 'tip',
          createdAt: DateTime.now(),
        ),
      );
    }

    // Savings suggestion
    if (totalIncome > totalExpenses) {
      final savings = totalIncome - totalExpenses;
      insights.add(
        AIInsight(
          id: 'insight_${DateTime.now().millisecondsSinceEpoch}_3',
          title: '💰 Great Job Saving!',
          description:
              'You saved \$${savings.toStringAsFixed(2)} this month. Consider investing ${(savings * 0.3).toStringAsFixed(2)} of it for long-term growth.',
          type: 'suggestion',
          createdAt: DateTime.now(),
        ),
      );
    }

    return insights;
  }

  /// Get personalized financial advice
  Future<String> getFinancialAdvice(
    String query,
    List<Transaction> context,
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock AI responses based on query keywords
    if (query.toLowerCase().contains('save')) {
      return 'Based on your spending patterns, I recommend the 50/30/20 rule: allocate 50% of income to needs, 30% to wants, and 20% to savings and debt repayment.';
    } else if (query.toLowerCase().contains('budget')) {
      return 'Your current spending shows room for optimization. Try setting category-specific budgets and use the app to track your progress throughout the month.';
    } else if (query.toLowerCase().contains('invest')) {
      return 'Before investing, ensure you have an emergency fund covering 3-6 months of expenses. Then consider diversified investments aligned with your risk tolerance.';
    } else {
      return 'I can help you with budgeting, saving strategies, and expense tracking. What specific aspect of your finances would you like to improve?';
    }
  }

  /// Predict future spending based on historical data
  Future<Map<String, double>> predictNextMonthSpending(
    List<Transaction> transactions,
  ) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final predictions = <String, double>{};
    final categorySpending = <Category, List<double>>{};

    // Group transactions by category
    for (var transaction in transactions.where(
      (t) => t.type == TransactionType.expense,
    )) {
      categorySpending.putIfAbsent(transaction.category, () => []);
      categorySpending[transaction.category]!.add(transaction.amount);
    }

    // Calculate average spending per category
    for (var entry in categorySpending.entries) {
      final average = entry.value.reduce((a, b) => a + b) / entry.value.length;
      predictions[categoryToString(entry.key)] =
          average * 1.05; // 5% increase prediction
    }

    return predictions;
  }
}
