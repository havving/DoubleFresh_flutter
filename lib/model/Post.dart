class Post {
  final int id;
  final String password;
  final String name;
  final int phone;

  Post({
    required this.id,
    required this.password,
    required this.name,
    required this.phone
  });

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post (
        id: json['id'],
        password: json['password'],
        name: json['name'],
        phone: json['phone']
    );
  }
}
