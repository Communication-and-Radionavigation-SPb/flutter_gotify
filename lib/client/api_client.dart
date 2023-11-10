import 'dart:convert';
import 'package:flutter_gotify/client/client_interface.dart';
import 'package:flutter_gotify/models/application.dart';
import 'package:flutter_gotify/models/client.dart';
import 'package:flutter_gotify/models/message_external.dart';
import 'package:flutter_gotify/models/paging.dart';
import 'package:http/http.dart' as http;

class GotifyHttpClient implements GotifyClient {
  final String baseUrl;
  final String token;
  final String messageToken;

  GotifyHttpClient(
      {required this.baseUrl, required this.token, required this.messageToken});

  @override
  Future<List<ApplicationModel>> getApplications() async {
    final Map<String, String> appParams = {};
    Uri url = Uri.parse('$baseUrl/application');

    final response = await http.get(
      url,
      headers: {
        'X-Gotify-Key': token,
      },
    );

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      final List<ApplicationModel> applications = List<ApplicationModel>.from(
          data.map((app) => ApplicationModel.fromJson(app)));
      print(applications);
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

  @override
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
      print(messages);
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

  @override
  Future<List<ClientModel>> getClients() async {
    Uri url = Uri.parse('$baseUrl/client');

    final response = await http.get(url, headers: {
      'X-Gotify-Key': token,
    });

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      final List<ClientModel> clients = List.from(data.map(
        (cl) => ClientModel.fromJson(cl),
      ));
      print(clients);
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
}
