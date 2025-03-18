import '../dto/post_dto.dart';
abstract class PostRepository1 {
  Future<List<Post1>> getPosts(List<int> postIds);
}
