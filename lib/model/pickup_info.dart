class PickupInfo {
  final int id;
  final int day;
  final DateTime time;
  final String salad;

  PickupInfo(this.id, this.day, this.time, this.salad);

  PickupInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        day = json['day'],
        time = json['time'],
        salad = json['salad'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'day': day, 'time': time, 'salad': salad};
}