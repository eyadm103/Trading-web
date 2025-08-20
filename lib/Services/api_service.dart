import 'dart:convert';
import 'package:flutter_application_1/models/user.dart';
import 'package:http/http.dart' as http;

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
