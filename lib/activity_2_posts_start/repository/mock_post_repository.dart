import '../model/post.dart';
import 'post_repository.dart';

class MockPostRepository implements PostRepository {
  @override
  Future<Post> getPost(int postId) async {
    if (postId == 1) {
      return Post(id: 1, title: 'test title', description: 'test');
    } else {
      throw Exception('error');
    }
  }
}