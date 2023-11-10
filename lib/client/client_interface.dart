import 'package:flutter_gotify/models/application.dart';
import 'package:flutter_gotify/models/client.dart';
import 'package:flutter_gotify/models/message_external.dart';
import 'package:flutter_gotify/models/paging.dart';

abstract interface class GotifyClient {
  Future<List<ApplicationModel>> getApplications();
  Future<(List<MessageExternalModel>, PagingModel)> getMessages();
  Future<List<ClientModel>> getClients();
}
