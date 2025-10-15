import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ai_insight.dart';
import '../models/transaction.dart';
import '../services/ai_agent_service.dart';

class AIAgentProvider with ChangeNotifier {
  final AIAgentService _aiService = AIAgentService();

  List<AIInsight> _insights = [];
  bool _isGenerating = false;
  String _lastAdvice = '';
  bool _isGettingAdvice = false;

  List<AIInsight> get insights => [..._insights];
  bool get isGenerating => _isGenerating;
  String get lastAdvice => _lastAdvice;
  bool get isGettingAdvice => _isGettingAdvice;

  int get unreadInsightsCount => _insights.where((i) => !i.isRead).length;

  AIAgentProvider() {
    _loadInsights();
  }

  Future<void> _loadInsights() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final insightsJson = prefs.getString('insights');

      if (insightsJson != null) {
        final List<dynamic> decoded = json.decode(insightsJson);
        _insights = decoded.map((e) => AIInsight.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading insights: $e');
    }
  }

  Future<void> _saveInsights() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final insightsJson = json.encode(
        _insights.map((e) => e.toJson()).toList(),
      );
      await prefs.setString('insights', insightsJson);
    } catch (e) {
      debugPrint('Error saving insights: $e');
    }
  }

  Future<void> generateInsights(
    List<Transaction> transactions,
    double monthlyBudget,
  ) async {
    _isGenerating = true;
    notifyListeners();

    try {
      final newInsights = await _aiService.generateInsights(
        transactions,
        monthlyBudget,
      );

      _insights.addAll(newInsights);

      // Keep only last 20 insights
      if (_insights.length > 20) {
        _insights = _insights.sublist(_insights.length - 20);
      }

      await _saveInsights();
    } catch (e) {
      debugPrint('Error generating insights: $e');
    }

    _isGenerating = false;
    notifyListeners();
  }

  Future<void> getAdvice(String query, List<Transaction> context) async {
    _isGettingAdvice = true;
    notifyListeners();

    try {
      _lastAdvice = await _aiService.getFinancialAdvice(query, context);
    } catch (e) {
      debugPrint('Error getting advice: $e');
      _lastAdvice = 'Sorry, I encountered an error. Please try again.';
    }

    _isGettingAdvice = false;
    notifyListeners();
  }

  void markInsightAsRead(String id) {
    final index = _insights.indexWhere((i) => i.id == id);
    if (index != -1) {
      _insights[index] = AIInsight(
        id: _insights[index].id,
        title: _insights[index].title,
        description: _insights[index].description,
        type: _insights[index].type,
        createdAt: _insights[index].createdAt,
        isRead: true,
      );
      _saveInsights();
      notifyListeners();
    }
  }

  void clearInsights() {
    _insights.clear();
    _saveInsights();
    notifyListeners();
  }
}
