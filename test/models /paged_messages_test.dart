import 'package:flutter_gotify/models/message_external.dart';
import 'package:flutter_gotify/models/paged_messages.dart';
import 'package:flutter_gotify/models/paging.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(PagedMessagesModel, () {
    test('PagedMessages constructor', () {
      List<MessageExternalModel> messages = [
        MessageExternalModel(
          appid: 1,
          date: "2023-11-02",
          extras: {"key": "value"},
          id: 123,
          message: "Test Message",
          priority: 3,
          title: "Test Title",
        ),
      ];

      PagingModel paging = PagingModel(
        limit: 10,
        next: "next_page",
        since: 123456789,
        size: 20,
      );

      PagedMessagesModel pagedMessages = PagedMessagesModel(
        messages: messages,
        paging: paging,
      );

      expect(pagedMessages.messages, messages);
      expect(pagedMessages.paging, paging);
    });

    test('PagedMessages fromJson', () {
      Map<String, dynamic> json = {
        'messages': [
          {
            'appid': 1,
            'date': "2023-11-02",
            'extras': {"key": "value"},
            'id': 123,
            'message': "Test Message",
            'priority': 3,
            'title': "Test Title",
          },
        ],
        'paging': {
          'limit': 10,
          'next': "next_page",
          'since': 123456789,
          'size': 20,
        },
      };

      PagedMessagesModel pagedMessages = PagedMessagesModel.fromJson(json);

      expect(pagedMessages.messages.length, 1);
      expect(pagedMessages.messages[0].appid, 1);
      expect(pagedMessages.messages[0].date, "2023-11-02");
      expect(pagedMessages.messages[0].extras, {"key": "value"});
      expect(pagedMessages.messages[0].id, 123);
      expect(pagedMessages.messages[0].message, "Test Message");
      expect(pagedMessages.messages[0].priority, 3);
      expect(pagedMessages.messages[0].title, "Test Title");
      expect(pagedMessages.paging.limit, 10);
      expect(pagedMessages.paging.next, "next_page");
      expect(pagedMessages.paging.since, 123456789);
      expect(pagedMessages.paging.size, 20);
    });

    test('PagedMessages toJson', () {
      List<MessageExternalModel> messages = [
        MessageExternalModel(
          appid: 1,
          date: "2023-11-02",
          extras: {"key": "value"},
          id: 123,
          message: "Test Message",
          priority: 3,
          title: "Test Title",
        ),
      ];

      PagingModel paging = PagingModel(
        limit: 10,
        next: "next_page",
        since: 123456789,
        size: 20,
      );

      PagedMessagesModel pagedMessages = PagedMessagesModel(
        messages: messages,
        paging: paging,
      );

      Map<String, dynamic> json = pagedMessages.toJson();

      expect(json['messages'].length, 1);
      expect(json['messages'][0]['appid'], 1);
      expect(json['messages'][0]['date'], "2023-11-02");
      expect(json['messages'][0]['extras'], {"key": "value"});
      expect(json['messages'][0]['id'], 123);
      expect(json['messages'][0]['message'], "Test Message");
      expect(json['messages'][0]['priority'], 3);
      expect(json['messages'][0]['title'], "Test Title");
      expect(json['paging']['limit'], 10);
      expect(json['paging']['next'], "next_page");
      expect(json['paging']['since'], 123456789);
      expect(json['paging']['size'], 20);
    });
  });
}
