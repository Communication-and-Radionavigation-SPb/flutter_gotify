import 'package:flutter_gotify/models/message_external.dart';
import 'package:flutter_gotify/models/paging.dart';

class PagedMessagesModel {
  List<MessageExternalModel> messages;
  PagingModel paging;

  PagedMessagesModel({
    required this.messages,
    required this.paging,
  });

  factory PagedMessagesModel.fromJson(Map<String, dynamic> json) {
    return PagedMessagesModel(
      messages: (json['messages'] as List<dynamic>)
          .map((messageJson) => MessageExternalModel.fromJson(messageJson))
          .toList(),
      paging: PagingModel.fromJson(json['paging'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messages': messages.map((message) => message.toJson()).toList(),
      'paging': paging.toJson(),
    };
  }
}
