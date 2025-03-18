

import '../repository/mock_post_repository.dart';
import '../repository/post_repository.dart';
void main() {
  // 1- Create the repo
  PostRepository repository = MockPostRepository();

  // 2- Request the post  - Success
  repository.getPost(1).then((post) {
    print('Post fetched successfully: ${post.title}');
  }).catchError((e) {
    print('Failed to fetch post: $e');
  });

  // 3- Request the post - Failed
  repository.getPost(2).then((post) {
    print('Post fetched successfully: ${post.title}');
  }).catchError((e) {
    print('Failed to fetch post: $e');
  });
}
