class User {
  final int id;
  final String password;
  final String name;
  final int phone;

  User(this.id, this.password, this.name, this.phone);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        password = json['password'],
        phone = json['phone'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'password': password, 'phone': phone};
}
