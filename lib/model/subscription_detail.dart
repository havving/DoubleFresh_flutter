// ignore: camel_case_types
class Subscription_Detail {
  final int subWeekCount;
  final int pickupTotalCount;
  final int pickupCount;
  final int pickupRemainCount;
  final String request;

  Subscription_Detail(this.subWeekCount, this.pickupTotalCount,
      this.pickupCount, this.pickupRemainCount, this.request);

  Subscription_Detail.fromJson(Map<String, dynamic> json)
      : subWeekCount = json['sub_week_count'],
        pickupTotalCount = json['pickup_total_count'],
        pickupCount = json['pickup_count'],
        pickupRemainCount = json['pickup_remain_count'],
        request = json['request'];

  Map<String, dynamic> toJson() => {
    'subWeekCount': subWeekCount,
    'pickupTotalCount': pickupTotalCount,
    'pickupCount': pickupCount,
    'pickupRemainCount': pickupRemainCount,
    'request': request,
  };
}
