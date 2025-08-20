import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> stocks = [];
  List<dynamic> filteredStocks = [];
  bool isLoading = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchStocks();
  }

  Future<void> fetchStocks() async {
    final String apiKey = 'AwLyvjITeqSoug7FWNjKJLZPNu8WE53V';
    final String url =
        'https://financialmodelingprep.com/api/v3/stock_market/actives?apikey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      setState(() {
        stocks = data;
        filteredStocks = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateSearch(String value) {
    setState(() {
      searchQuery = value;
      filteredStocks = stocks
          .where(
            (stock) => stock['symbol'].toString().toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  Color getChangeColor(double change) {
    if (change > 0) return Colors.green;
    if (change < 0) return Colors.red;
    return Colors.grey;
  }

  Icon getChangeIcon(double change) {
    if (change > 0) {
      return const Icon(Icons.arrow_upward, color: Colors.green, size: 18);
    } else if (change < 0) {
      return const Icon(Icons.arrow_downward, color: Colors.red, size: 18);
    } else {
      return const Icon(Icons.remove, color: Colors.grey, size: 18);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(0.05),
              theme.colorScheme.surface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  onChanged: updateSearch,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search stock symbol...',
                    hintStyle: TextStyle(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.surface.withOpacity(0.9),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: theme.colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),

              // Body content
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : filteredStocks.isEmpty
                        ? const Center(child: Text('No stocks found.'))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: filteredStocks.length,
                            itemBuilder: (context, index) {
                              final stock = filteredStocks[index];
                              final symbol = stock['symbol']?.toString() ?? '';
                              final price = stock['price'] ?? 0.0;
                              final change = double.tryParse(
                                      stock['change']?.toString() ?? '0.0') ??
                                  0.0;
                              final rawChangePercentage =
                                  stock['changesPercentage']?.toString() ?? '0';
                              final changePercentage =
                                  rawChangePercentage.contains('%')
                                      ? rawChangePercentage
                                      : '$rawChangePercentage%';

                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              symbol,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                Text(
                                                  '\$${price.toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                const SizedBox(width: 10),
                                                getChangeIcon(change),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '$change ($changePercentage)',
                                                  style: TextStyle(
                                                    color: getChangeColor(change),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
