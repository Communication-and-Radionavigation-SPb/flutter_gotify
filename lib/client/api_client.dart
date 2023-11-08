import 'dart:convert';

import 'package:flutter_gotify/models/application.dart';
import 'package:flutter_gotify/models/client.dart';
import 'package:flutter_gotify/models/message_external.dart';
import 'package:flutter_gotify/models/paging.dart';
import 'package:http/http.dart' as http;

class GotifyClient {
  final String baseUrl;
  final String token;
  final String messageToken;

  GotifyClient(
      {required this.baseUrl, required this.token, required this.messageToken});

  Future<List<ApplicationModel>> getApplications() async {
    final response = await http.get(
      Uri.parse('$baseUrl/application'),
      headers: {'X-Gotify-Key': token},
    );

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      final List<ApplicationModel> applications = List<ApplicationModel>.from(
          data.map((x) => ApplicationModel.fromJson(x)));
      return applications;
    } else {
      switch (response.statusCode) {
        case 400:
          throw Exception(' request');
        case 401:
          throw Exception('${response.statusCode} Unauthorized');
        case 403:
          throw Exception(' ${response.statusCode} Forbidden');
        case 404:
          throw Exception(' ${response.statusCode}  Not found');
        case 500:
          throw Exception(' ${response.statusCode} Internal server error');
        default:
          throw Exception('Failed to send message (${response.statusCode})');
      }
    }
  }

  Future<ApplicationModel> createApplication(String name, String description,
      String image, bool internal, int defaultPriority) async {
    final response = await http.post(
      Uri.parse('$baseUrl/application'),
      headers: {'X-Gotify-Key': token, 'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'description': description,
        'image': image,
        'internal': internal,
        'defaultPriority': defaultPriority,
      }),
    );

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      final ApplicationModel application = ApplicationModel.fromJson(data);
      return application;
    } else {
      switch (response.statusCode) {
        case 400:
          throw Exception(' request');
        case 401:
          throw Exception('${response.statusCode} Unauthorized');
        case 403:
          throw Exception(' ${response.statusCode} Forbidden');
        case 404:
          throw Exception(' ${response.statusCode}  Not found');
        case 500:
          throw Exception(' ${response.statusCode} Internal server error');
        default:
          throw Exception('Failed to send message (${response.statusCode})');
      }
    }
  }

  Future<(List<MessageExternalModel>, PagingModel)> getMessages(
      {int limit = 100, int? since}) async {
    final Map<String, String> params = {};
    Uri url = Uri.parse('$baseUrl/message');

    params.putIfAbsent("limit", () => limit.toString());
    if (since != null) {
      params.putIfAbsent("since", () => since.toString());
    }
    url = url.replace(
      queryParameters: params,
    );

    final response = await http.get(
      url,
      headers: {'X-Gotify-Key': token},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<MessageExternalModel> messages = List.from(
        data["messages"].map(
          (mes) => MessageExternalModel.fromJson(mes),
        ),
      );
      final PagingModel paging = PagingModel.fromJson(data["paging"]);
      print(messages[0].message);
      return (messages, paging);
    } else {
      switch (response.statusCode) {
        case 400:
          throw Exception(' request');
        case 401:
          throw Exception('${response.statusCode} Unauthorized');
        case 403:
          throw Exception(' ${response.statusCode} Forbidden');
        case 404:
          throw Exception(' ${response.statusCode}  Not found');
        case 500:
          throw Exception(' ${response.statusCode} Internal server error');
        default:
          throw Exception('Failed to send message (${response.statusCode})');
      }
    }
  }

  Future<MessageExternalModel> sendMessage(String title, String message,
      int appid, int priority, Map<String, dynamic> extras) async {
    final response = await http.post(
      Uri.parse('$baseUrl/message'),
      headers: {
        'X-Gotify-Key': messageToken,
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        'title': title,
        'message': message,
        'appid': appid,
        'priority': priority,
        'extras': extras,
      }),
    );
    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      final MessageExternalModel message = MessageExternalModel.fromJson(data);
      return message;
    } else {
      switch (response.statusCode) {
        case 400:
          throw Exception(' request');
        case 401:
          throw Exception('${response.statusCode} Unauthorized');
        case 403:
          throw Exception(' ${response.statusCode} Forbidden');
        case 404:
          throw Exception(' ${response.statusCode}  Not found');
        case 500:
          throw Exception(' ${response.statusCode} Internal server error');
        default:
          throw Exception('Failed to send message (${response.statusCode})');
      }
    }
  }

  Future<List<ClientModel>> getClients() async {
    final response = await http.get(
      Uri.parse('$baseUrl/client'),
      headers: {'X-Gotify-Key': token},
    );

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      final List<ClientModel> clients =
          List<ClientModel>.from(data.map((x) => ClientModel.fromJson(x)));
      return clients;
    } else {
      switch (response.statusCode) {
        case 400:
          throw Exception(' request');
        case 401:
          throw Exception('${response.statusCode} Unauthorized');
        case 403:
          throw Exception(' ${response.statusCode} Forbidden');
        case 404:
          throw Exception(' ${response.statusCode}  Not found');
        case 500:
          throw Exception(' ${response.statusCode} Internal server error');
        default:
          throw Exception('Failed to send message (${response.statusCode})');
      }
    }
  }

  Future<ClientModel> createClient(String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/client'),
      headers: {'X-Gotify-Key': token, 'Content-Type': 'application/json'},
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      final ClientModel client = ClientModel.fromJson(data);
      return client;
    } else {
      switch (response.statusCode) {
        case 400:
          throw Exception(' request');
        case 401:
          throw Exception('${response.statusCode} Unauthorized');
        case 403:
          throw Exception(' ${response.statusCode} Forbidden');
        case 404:
          throw Exception(' ${response.statusCode}  Not found');
        case 500:
          throw Exception(' ${response.statusCode} Internal server error');
        default:
          throw Exception('Failed to send message (${response.statusCode} )');
      }
    }
  }
}
