

import '../model/post.dart';
import '../repository/mock_post_repository.dart';
import '../repository/post_repository.dart';
void main() async {
  // 1- Create the repo
  PostRepository repository = MockPostRepository();

  // 2- Request the post  - Success
  try {
    Post post = await repository.getPost(1);
    print('Post fetched successfully: ${post.title}');
  } catch (e) {
    print('Failed to fetch post: $e');
  }

  // 3- Request the post - Failed
  try {
    Post post = await repository.getPost(2);
    print('Post fetched successfully: ${post.title}');
  } catch (e) {
    print('Failed to fetch post: $e');
  }
}
