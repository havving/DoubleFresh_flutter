class Post {
  final int userId;
  final int id;
  final String title;

  Post({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post (
        id: json['id'],
        userId: json['userId'],
        title: json['title']
    );
  }
}
