class Post1 {
  final String body;
  final String title;
  final int id;

  Post1({required this.title, required this.body, required this.id});
}

class PostDTO {
  Post1 fromJson(Map<String, dynamic> json) {
    assert(
      json['title'] is String,
    );
    assert(
      json['body'] is String,
    );
    assert(
      json['id'] is int,
    );

    return Post1(
      title: json['title'],
      body: json['body'],
      id: json['id'],
    );
  }
}
