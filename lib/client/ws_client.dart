import 'dart:convert';

import 'package:flutter_gotify/models/application.dart';
import 'package:flutter_gotify/models/client.dart';
import 'package:flutter_gotify/models/message_external.dart';
import 'package:flutter_gotify/models/paging.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GotifyWebSocketClient {
  final String baseUrl;
  final String token;
  final String messageToken;

  GotifyWebSocketClient(
      {required this.baseUrl, required this.token, required this.messageToken});

  Future<List<ApplicationModel>> getApplications() async {
    final channel = WebSocketChannel.connect(
      Uri.parse('$baseUrl/stream?token=$token'),
    );

    channel.sink.add(jsonEncode({'type': 'applications.get'}));

    final response = await channel.stream.first;

    channel.sink.close();

    final dynamic data = jsonDecode(response);
    final List<ApplicationModel> applications = List<ApplicationModel>.from(
        data.map((x) => ApplicationModel.fromJson(x)));
    return applications;
  }

  Future<ApplicationModel> createApplication(String name, String description,
      String image, bool internal, int defaultPriority) async {
    final channel = WebSocketChannel.connect(
      Uri.parse('$baseUrl/stream?token=$token'),
    );

    channel.sink.add(jsonEncode({
      'name': name,
      'description': description,
      'image': image,
      'internal': internal,
      'defaultPriority': defaultPriority,
    }));

    final response = await channel.stream.first;

    channel.sink.close();

    final dynamic data = jsonDecode(response);
    final ApplicationModel application = ApplicationModel.fromJson(data);
    return application;
  }

  Future<(List<MessageExternalModel>, PagingModel)> getMessages(
      {int limit = 100, int? since}) async {
    final channel = WebSocketChannel.connect(
      Uri.parse('$baseUrl/stream?token=$token'),
    );

    final Map<String, dynamic> request = {
      'type': 'messages.get',
      'limit': limit,
    };

    if (since != null) {
      request['since'] = since;
    }

    channel.sink.add(jsonEncode(request));

    final response = await channel.stream.first;

    channel.sink.close();

    final Map<String, dynamic> data = jsonDecode(response);
    final List<MessageExternalModel> messages = List.from(
      data["messages"].map(
        (mes) => MessageExternalModel.fromJson(mes),
      ),
    );
    final PagingModel paging = PagingModel.fromJson(data["paging"]);
    return (messages, paging);
  }

  Future<MessageExternalModel> sendMessage(String title, String message,
      int appid, int priority, Map<String, dynamic> extras) async {
    final channel = WebSocketChannel.connect(
      Uri.parse('$baseUrl/stream?token=$messageToken'),
    );

    channel.sink.add(
      jsonEncode({
        'title': title,
        'message': message,
        'appid': appid,
        'priority': priority,
        'extras': extras,
      }),
    );

    final response = await channel.stream.first;

    channel.sink.close();

    final dynamic data = jsonDecode(response);
    final MessageExternalModel messageData =
        MessageExternalModel.fromJson(data);
    return messageData;
  }

  Future<List<ClientModel>> getClients() async {
    final channel = WebSocketChannel.connect(
      Uri.parse('$baseUrl/stream?token=$token'),
    );

    channel.sink.add(jsonEncode({'type': 'clients.get'}));

    final response = await channel.stream.first;

    channel.sink.close();

    final dynamic data = jsonDecode(response);
    final List<ClientModel> clients =
        List<ClientModel>.from(data.map((x) => ClientModel.fromJson(x)));
    return clients;
  }

  Future<ClientModel> createClient(String name) async {
    final channel = WebSocketChannel.connect(
      Uri.parse('$baseUrl/stream?token=$token'),
    );

    channel.sink.add(jsonEncode({
      'type': 'clients.create',
      'name': name,
    }));

    final response = await channel.stream.first;

    channel.sink.close();

    final dynamic data = jsonDecode(response);
    final ClientModel client = ClientModel.fromJson(data);
    return client;
  }
}
