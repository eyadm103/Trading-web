import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PositionsSquare extends StatefulWidget {
  const PositionsSquare({super.key});

  @override
  State<PositionsSquare> createState() => _PositionsSquareState();
}

class _PositionsSquareState extends State<PositionsSquare> {
  late Future<List<dynamic>> positionsFuture;

  @override
  void initState() {
    super.initState();
    positionsFuture = fetchPositions();
  }

  Future<List<dynamic>> fetchPositions() async {
    final url = Uri.parse("https://aswad1234.loca.lt/");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['positions'] ?? [];
    } else {
      throw Exception("Failed to load positions: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return FutureBuilder<List<dynamic>>(
      future: positionsFuture,
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

        final positions = snapshot.data ?? [];

        return LayoutBuilder(
          builder: (context, constraints) {
            final boxSize = isDesktop ? 250.0 : constraints.maxWidth;
            final iconSize = isDesktop ? 60.0 : boxSize * 0.25;
            final circleRadius = isDesktop ? 22.0 : boxSize * 0.1;
            final circleIconSize = isDesktop ? 30.0 : boxSize * 0.12;
            final spacing = isDesktop ? 10.0 : boxSize * 0.05;
            final titleFontSize = isDesktop ? 20.0 : boxSize * 0.09;
            final infoFontSize = isDesktop ? 16.0 : boxSize * 0.0737;
            final padding = isDesktop ? 16.0 : boxSize * 0.12;

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
                          Icons.account_balance_wallet_rounded,
                          size: iconSize,
                          color: theme.colorScheme.primary,
                        ),
                        SizedBox(width: spacing),
                        Text(
                          "Positions",
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
                      children: positions.isEmpty
                          ? [
                              Row(
                                children: [
                                  SizedBox(width: spacing),
                                  Expanded(
                                    child: Text(
                                      "No positions",
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            fontSize: infoFontSize,
                                            color: theme.colorScheme.onSurface
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          : positions.map((pos) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: spacing * 0.5),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: circleRadius,
                                      backgroundColor: theme.colorScheme.primary
                                          .withOpacity(0.25),
                                      child: Icon(
                                        Icons.trending_up,
                                        size: circleIconSize,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    SizedBox(width: spacing),
                                    Expanded(
                                      child: Text(
                                        pos.toString(),
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              fontSize: infoFontSize,
                                              color: theme.colorScheme.onSurface
                                                  .withOpacity(0.7),
                                              fontWeight: FontWeight.w600,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
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
