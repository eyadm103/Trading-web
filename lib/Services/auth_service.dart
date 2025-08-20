import 'dart:convert';
import 'package:http/http.dart' as http;

class Stock {
  int id;
  String symbol;
  double price;
  String lastUpdated;

  Stock({
    required this.id,
    required this.symbol,
    required this.price,
    required this.lastUpdated,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        id: json['id'],
        symbol: json['symbol'],
        price: (json['price'] as num).toDouble(),
        lastUpdated: json['last_updated'],
      );
}

class ApiService {
  final String baseUrl = 'https://2c01648a1a21.ngrok-free.app';

  Future<List<Stock>> fetchStocks() async {
    final res = await http.get(Uri.parse('$baseUrl/api/stock/'));

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Stock.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch stocks: ${res.statusCode}');
    }
  }
}
