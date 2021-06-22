class Subscription {
  final int id;
  final int subWeekCount;
  final int pickupTotalCount;
  final int pickupCount;
  final int pickupRemainCount;

  Subscription(this.id, this.subWeekCount, this.pickupTotalCount,
      this.pickupCount, this.pickupRemainCount);

  Subscription.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        subWeekCount = json['sub_week_count'],
        pickupTotalCount = json['pickup_total_count'],
        pickupCount = json['pickup_count'],
        pickupRemainCount = json['pickup_remain_count'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'subWeekCount': subWeekCount, 'pickupTotalCount': pickupTotalCount,
        'pickupCount': pickupCount, 'pickupRemainCount': pickupRemainCount};
}
