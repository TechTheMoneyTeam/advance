import 'package:flutter/material.dart';
import 'screens/ride_pref/ride_pref_screen.dart';
import 'theme/theme.dart';


import './repository/mock/mock_location_repo.dart';
import './service/locations_service.dart';
import './repository/mock/mock_ride_repo.dart';
import './service/rides_service.dart';

void main() {
     LocationsService().initialize(MockLocationsRepository());
  RidesService().initialize(MockRidesRepository());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: appTheme,
      home: Scaffold(body: RidePrefScreen()),
    );
  }
}
