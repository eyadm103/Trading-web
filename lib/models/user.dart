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
