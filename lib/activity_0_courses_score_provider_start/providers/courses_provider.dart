
import 'package:flutter/material.dart';

import '../models/course_model.dart';
import '../repositories/courses_repository.dart';

class CoursesProvider extends ChangeNotifier {
  List<Course> _courses = [];

  final CoursesRepository repository;

  CoursesProvider({required this.repository}) {
    _fetchCourses(); // Fetch courses from repo
  }

  // ---------------------
  // COURSES API
  // ---------------------

  List<Course> get courses => _courses;

  void _fetchCourses() {
    print('Provider  - feches courses');

    // 1 - Repository feches courses
    _courses = repository.getCourses();

    // 2- Notify listeners
    notifyListeners();
  }

  // ---------------------
  // COURSE API
  // ---------------------

  Course? getCourseFor(String courseId) {
    return _courses.firstWhere((c) => c.name == courseId);
  }

  void addScore(String courseId, CourseScore score) {
    print('Provider  - add score');

    // get the course
    Course? course = getCourseFor(courseId);

    if (course != null) {
      // 1 - Repository add score
      repository.addScore(course, score);

      //2- Notify listeners
      notifyListeners();
    }
  }
}
