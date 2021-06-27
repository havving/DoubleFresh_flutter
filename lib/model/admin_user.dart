class AdminUser {
  final int id;
  final String password;
  final String name;
  final int phone;

  // final String status;

  /*final int subWeekCount;
  final int pickupTotalCount;
  final int pickupCount;
  final int pickupRemainCount;*/

  AdminUser(
      this.id,
      this.password,
      this.name,
      this.phone,
      // this.status,
      /*this.subWeekCount,
      this.pickupTotalCount,
      this.pickupCount,
      this.pickupRemainCount*/);

  AdminUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        password = json['password'],
        phone = json['phone'];
        // status = json['status'];
        /*subWeekCount = json['sub_week_count'],
        pickupTotalCount = json['pickup_total_count'],
        pickupCount = json['pickup_count'],
        pickupRemainCount = json['pickup_remain_count'];*/

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'password': password,
        'phone': phone,
        // 'status': status,
        /*'subWeekCount': subWeekCount,
        'pickupTotalCount': pickupTotalCount,
        'pickupCount': pickupCount,
        'pickupRemainCount': pickupRemainCount*/
      };
}
