class AdminUser {
  final int id;
  final String name;
  final int phone;

  AdminUser(this.id, this.name, this.phone);

  AdminUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        phone = json['phone'];
}
