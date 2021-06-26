class PickupInfo {
  final int subscriptionDetailId;
  final int day;
  final String time;
  final String salad;

  PickupInfo(this.subscriptionDetailId, this.day, this.time, this.salad);

  PickupInfo.fromJson(Map<String, dynamic> json)
      : subscriptionDetailId = json['subscriptionDetailId'],
        day = json['day'],
        time = json['time'],
        salad = json['salad'];

  Map<String, dynamic> toJson() =>
      {'subscriptionDetailId': subscriptionDetailId, 'day': day, 'time': time, 'salad': salad};
}