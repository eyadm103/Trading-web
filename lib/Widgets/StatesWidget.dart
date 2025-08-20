import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatesSquare extends StatefulWidget {
  const StatesSquare({super.key});

  @override
  State<StatesSquare> createState() => _MarketMessageSquareState();
}

class _MarketMessageSquareState extends State<StatesSquare> {
  late Future<Map<String, dynamic>> marketDataFuture;

  @override
  void initState() {
    super.initState();
    marketDataFuture = fetchMarketData();
  }

  Future<Map<String, dynamic>> fetchMarketData() async {
    final url = Uri.parse("https://aswad1234.loca.lt");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Failed to load market data: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return FutureBuilder<Map<String, dynamic>>(
      future: marketDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error: ${snapshot.error}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final data = snapshot.data ?? {};
        final dailyStats = data['daily_stats'] ?? {};
        final trades = dailyStats['trades'] ?? 0;
        final wins = dailyStats['wins'] ?? 0;
        final losses = dailyStats['losses'] ?? 0;
        final totalProfit = dailyStats['total_profit'] ?? 0.0;
        final totalLoss = dailyStats['total_loss'] ?? 0.0;

        return LayoutBuilder(
          builder: (context, constraints) {
            final boxSize = isDesktop ? 250.0 : constraints.maxWidth;
            final iconSize = isDesktop ? 60.0 : boxSize * 0.25;
            final spacing = isDesktop ? 10.0 : boxSize * 0.03;
            final titleFontSize = isDesktop ? 20.0 : boxSize * 0.09;
            final infoFontSize = isDesktop ? 16.0 : boxSize * 0.0737;
            final padding = isDesktop ? 16.0 : boxSize * 0.08;

            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {},
              child: Container(
                width: boxSize,
                height: boxSize,
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary.withOpacity(0.12),
                      theme.colorScheme.primary.withOpacity(0.06),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.25),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.show_chart,
                          size: iconSize,
                          color: theme.colorScheme.primary,
                        ),
                        SizedBox(width: spacing),
                        Text(
                          "States",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface,
                            fontSize: titleFontSize,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spacing),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Trades: $trades",
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: infoFontSize,
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                            height: 1.2, // يقلل المسافة الرأسية بين الأسطر
                          ),
                        ),
                        Text(
                          "Wins: $wins",
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: infoFontSize,
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          "Losses: $losses",
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: infoFontSize,
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          "Total Profit: $totalProfit",
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: infoFontSize,
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          "Total Loss: $totalLoss",
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: infoFontSize,
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
