// ignore_for_file: avoid_print

import 'courses_repository.dart';

import '../models/course_model.dart';

class CoursesMockRepository extends CoursesRepository {
  @override
  List<Course> getCourses() {
    print('Repository - get course');
    return [Course(name: 'HTML'), Course(name: 'JAVA')];
  }

  @override
  void addScore(Course course, CourseScore score) {
    print('Repository - add  score');
    course.addScore(score); // For test
  }
}
