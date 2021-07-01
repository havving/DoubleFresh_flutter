class AdminPickup {
  final String name;
  final String time;
  final String request;

  AdminPickup(this.name, this.time, this.request);

  AdminPickup.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        time = json['time'],
        request = json['request'];
}
