import 'package:flutter_gotify/models/paging.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(PagingModel, () {
    test('Paging constructor', () {
      PagingModel paging = PagingModel(
        limit: 10,
        next: "next_page",
        since: 123456789,
        size: 20,
      );

      expect(paging.limit, 10);
      expect(paging.next, "next_page");
      expect(paging.since, 123456789);
      expect(paging.size, 20);
    });

    test('Paging fromJson', () {
      Map<String, dynamic> json = {
        'limit': 10,
        'next': "next_page",
        'since': 123456789,
        'size': 20,
      };

      PagingModel paging = PagingModel.fromJson(json);

      expect(paging.limit, 10);
      expect(paging.next, "next_page");
      expect(paging.since, 123456789);
      expect(paging.size, 20);
    });

    test('Paging toJson', () {
      PagingModel paging = PagingModel(
        limit: 10,
        next: "next_page",
        since: 123456789,
        size: 20,
      );

      Map<String, dynamic> json = paging.toJson();

      expect(json['limit'], 10);
      expect(json['next'], "next_page");
      expect(json['since'], 123456789);
      expect(json['size'], 20);
    });
  });
}
