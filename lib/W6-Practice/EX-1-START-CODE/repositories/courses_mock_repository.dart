

import 'courses_repository.dart';

import '../models/course.dart';

class CoursesMockRepository extends CoursesRepository {
  @override
  List<Course> getCourses() {
    print('Repository - get course');
    return [Course(name: 'HTML'), Course(name: 'JAVA'),Course(name: 'Flutter')];
  }

  @override
  void addScore(Course course, CourseScore score) {
    print('Repository - add  score');
    course.addScore(score);
  }
}
