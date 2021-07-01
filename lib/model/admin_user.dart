class AdminUser {
  final int id;
  final String name;
  final int phone;
  final String status;

  AdminUser(this.id, this.name, this.phone, this.status);

  AdminUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        phone = json['phone'],
        status = json['status'];
}
