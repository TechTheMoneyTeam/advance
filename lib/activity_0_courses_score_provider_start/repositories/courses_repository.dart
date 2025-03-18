import '../models/course_model.dart';

abstract class CoursesRepository {
  List<Course> getCourses();

  void addScore(Course course, CourseScore score);
}
