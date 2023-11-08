class PagingModel {
  int limit;
  String? next;
  int since;

  int size;

  PagingModel(
      {required this.limit,
      required this.next,
      required this.since,
      required this.size});

  factory PagingModel.fromJson(Map<String, dynamic> json) {
    return PagingModel(
        limit: json['limit'],
        next: json['next'],
        since: json['since'],
        size: json['size']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['next'] = next;
    data['since'] = since;
    data['size'] = size;
    return data;
  }
}
