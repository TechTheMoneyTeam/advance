import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/courses_provider.dart';
import 'repositories/courses_repository.dart';
import 'repositories/courses_mock_repository.dart';
import 'screens/courses_list_screen.dart';

void main() {
  // 1 - Create repository and services
  CoursesRepository coursesRepo = CoursesMockRepository();

  runApp(
    ChangeNotifierProvider(
      // 2 - Create global providers
      create: (BuildContext context) {
        return CoursesProvider(repository: coursesRepo);
      },

      // 3 - Create UI
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CoursesListScreen(),
      ),
    ),
  );
}
