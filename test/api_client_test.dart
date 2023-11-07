import 'package:flutter_gotify/api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group(GotifyClient, () {
    late GotifyClient gotifyClient;
    late MockHttpClient mockHttpClient;
    late Uri url;

    setUp(() {
      mockHttpClient = MockHttpClient();
      gotifyClient = GotifyClient(
        baseUrl: 'http://localhost:8080',
        token: 'C8.6OhnAgV6OrjD',
        messageToken: 'AuPOSbvUlfLgzx1',
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

      expect(gotifyClient.getApplications(), throwsException);
    });

    test('createApplication returns an ApplicationModel', () async {
      final mockResponse = http.Response(
        '{"id": 1, "name": "App 1"}',
        200,
      );
      when(mockHttpClient.post(url,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => mockResponse);

      final application = await gotifyClient.createApplication(
        'App 1',
        'Description',
        'image.png',
        true,
        1,
      );

      expect(application.id, 1);
      expect(application.name, 'App 1');
    });

    test('createApplication throws an exception on non-200 response', () async {
      final mockResponse = http.Response('Error', 400);
      when(mockHttpClient.post(url,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => mockResponse);

      expect(
        gotifyClient.createApplication(
            'App 1', 'Description', 'image.png', true, 1),
        throwsException,
      );
    });

    test('getMessages throws an exception on non-200 response', () async {
      final mockResponse = http.Response('Error', 400);
      when(mockHttpClient.get(url, headers: anyNamed('headers')))
          .thenAnswer((_) async => mockResponse);

      expect(gotifyClient.getMessages(), throwsException);
    });

    test('sendMessage returns a MessageExternalModel', () async {
      final mockResponse = http.Response(
        '{"id": 1, "title": "Message 1"}',
        200,
      );
      when(mockHttpClient.post(url,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => mockResponse);

      final message = await gotifyClient.sendMessage(
        'Title',
        'Message',
        1,
        1,
        {'key': 'value'},
      );

      expect(message.id, 1);
      expect(message.title, 'Message 1');
    });

    test('sendMessage throws an exception on non-200 response', () async {
      final mockResponse = http.Response('Error', 400);
      when(mockHttpClient.post(url,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => mockResponse);

      expect(
        gotifyClient.sendMessage('Title', 'Message', 1, 1, {'key': 'value'}),
        throwsException,
      );
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

    test('createClient returns a ClientModel', () async {
      final mockResponse = http.Response(
        '{"id": 1, "name": "Client 1"}',
        200,
      );
      when(mockHttpClient.post(url,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => mockResponse);

      final client = await gotifyClient.createClient('Client 1');

      expect(client.id, 1);
      expect(client.name, 'Client 1');
    });

    test('createClient throws an exception on non-200 response', () async {
      final mockResponse = http.Response('Error', 400);
      when(mockHttpClient.post(url,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => mockResponse);

      expect(gotifyClient.createClient('Client 1'), throwsException);
    });
  });
}
