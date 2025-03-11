import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/colorcount.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("ColorTapsScreen rebuilt");
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Center(
        child: Consumer<ColorCounters>(
          builder: (context, colorCounters, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Red Taps: ${colorCounters.redTapCount}', 
                    style: const TextStyle(fontSize: 24)),
                Text('Blue Taps: ${colorCounters.blueTapCount}', 
                    style: const TextStyle(fontSize: 24)),
              ],
            );
          },
        ),
      ),
    );
  }
}