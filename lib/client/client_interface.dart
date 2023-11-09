import 'package:flutter_gotify/models/application.dart';
import 'package:flutter_gotify/models/client.dart';
import 'package:flutter_gotify/models/message_external.dart';
import 'package:flutter_gotify/models/paging.dart';

abstract interface class GotifyClient {
  Future<List<ApplicationModel>> getApplications();
  Future<ApplicationModel> createApplication(String name, String description,
      String image, bool internal, int defaultPriority);
  Future<(List<MessageExternalModel>, PagingModel)> getMessages();
  Future<MessageExternalModel> sendMessage(String title, String message,
      int appid, int priority, Map<String, dynamic> extras);
  Future<List<ClientModel>> getClients();
  Future<ClientModel> createClient(String name);
}
