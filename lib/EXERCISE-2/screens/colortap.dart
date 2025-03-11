import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/colorcount.dart';
import '../widgets/colortapwiget.dart';

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("StatisticsScreen rebuilt"); 
    return Scaffold(
      appBar: AppBar(title: const Text('Color Taps')),
      body: Column(
        children: [
          Consumer<ColorCounters>(
            builder: (context, colorCounters, child) {
              return ColorTapWidget(
                colorType: 'red',
                tapCount: colorCounters.redTapCount,
                onTap: () => colorCounters.incrementRedTapCount(),
              );
            },
          ),
          Consumer<ColorCounters>(
            builder: (context, colorCounters, child) {
              return ColorTapWidget(
                colorType: 'blue',
                tapCount: colorCounters.blueTapCount,
                onTap: () => colorCounters.incrementBlueTapCount(),
              );
            },
          ),
        ],
      ),
    );
  }
}