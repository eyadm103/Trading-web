import 'package:flutter/foundation.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<String> _symbols = {};

  Set<String> get symbols => _symbols;

  bool isFavorite(String symbol) => _symbols.contains(symbol);

  void toggle(String symbol) {
    if (_symbols.contains(symbol)) {
      _symbols.remove(symbol);
    } else {
      _symbols.add(symbol);
    }
    notifyListeners();
  }

  int get count => _symbols.length;
}
