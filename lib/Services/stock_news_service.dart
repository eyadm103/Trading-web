import 'dart:convert';
import 'package:http/http.dart' as http;

class StockNewsService {
  final String _apiKey = 'd23vichr01qv4g02hfn0d23vichr01qv4g02hfng';

  Future<List<Map<String, String>>> fetchStockNews() async {
    final response = await http.get(
      Uri.parse('https://finnhub.io/api/v1/news?category=general&token=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);

      if (jsonData is List) {
        return jsonData.take(5).map((item) {
          final title = item['headline']?.toString() ?? 'No title';
          final image = (item['image']?.toString().isNotEmpty == true)
              ? item['image'].toString()
              : 'https://via.placeholder.com/400x200.png?text=No+Image';

          return {
            'title': title,
            'image': image,
          };
        }).toList();
      } else {
        throw Exception('Unexpected data format: not a list');
      }
    } else {
      throw Exception('Failed to load news. Status code: ${response.statusCode}');
    }
  }
}
