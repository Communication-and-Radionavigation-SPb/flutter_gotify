import 'package:flutter_gotify/client/http_client/api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group(GotifyHttpClient, () {
    late GotifyHttpClient gotifyClient;
    late MockHttpClient mockHttpClient;
    late Uri url;

    setUp(() {
      mockHttpClient = MockHttpClient();
      gotifyClient = GotifyHttpClient(
        baseUrl: 'http://localhost:8080',
        appToken: 'C8.6OhnAgV6OrjD',
        clientToken: 'AuPOSbvUlfLgzx1',
      );
      url = Uri.parse('http://localhost:8080');
    });

    test('getApplications returns a list of ApplicationModel', () async {
      final mockResponse = http.Response(
        '[{"id": 1, "name": "App 1"}, {"id": 2, "name": "App 2"}]',
        200,
      );
      when(mockHttpClient.get(url, headers: anyNamed('headers')))
          .thenAnswer((_) async => mockResponse);

      final applications = await gotifyClient.getApplications();

      expect(applications.length, 2);
      expect(applications[0].id, 1);
      expect(applications[0].name, 'App 1');
      expect(applications[1].id, 2);
      expect(applications[1].name, 'App 2');
    });

    test('getApplications throws an exception on non-200 response', () async {
      final mockResponse = http.Response('Error', 400);
      when(mockHttpClient.get(url, headers: anyNamed('headers')))
          .thenAnswer((_) async => mockResponse);

      final applications = await gotifyClient.getApplications();

      expect(applications, throwsException);
    });

    test('getMessages throws an exception on non-200 response', () async {
      final mockResponse = http.Response('Error', 400);
      when(mockHttpClient.get(url, headers: anyNamed('headers')))
          .thenAnswer((_) async => mockResponse);

      final messages = await gotifyClient.getMessages();

      expect(messages, throwsException);
    });

    test('getClients returns a list of ClientModel', () async {
      final mockResponse = http.Response(
        '[{"id": 1, "name": "Client 1"}, {"id": 2, "name": "Client 2"}]',
        200,
      );
      when(mockHttpClient.get(url, headers: anyNamed('headers')))
          .thenAnswer((_) async => mockResponse);

      final clients = await gotifyClient.getClients();

      expect(clients.length, 2);
      expect(clients[0].id, 1);
      expect(clients[0].name, 'Client 1');
      expect(clients[1].id, 2);
      expect(clients[1].name, 'Client 2');
    });

    test('getClients throws an exception on non-200 response', () async {
      final mockResponse = http.Response('Error', 400);
      when(mockHttpClient.get(url, headers: anyNamed('headers')))
          .thenAnswer((_) async => mockResponse);

      expect(gotifyClient.getClients(), throwsException);
    });
  });
}
