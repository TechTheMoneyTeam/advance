import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/colorcount.dart';
import 'screens/home.dart';

void main() {
  runApp(
    
    ChangeNotifierProvider(
      create: (context) => ColorCounters(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    ),
  );
}