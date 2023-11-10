import 'package:web_socket_channel/web_socket_channel.dart';

class GotifyWebSocketClient {
  final String baseUrl;
  final String token;
  final String messageToken;
  late WebSocketChannel _channel;

  GotifyWebSocketClient({
    required this.baseUrl,
    required this.token,
    required this.messageToken,
  });

  void connect() {
    _channel = WebSocketChannel.connect(
      Uri.parse('$baseUrl/stream/?token=$token'),
    );
  }

  void disconnect() {
    _channel.sink.close();
  }

  @override
  Future<void> getMessages() async {
    connect();

    _channel.stream.listen((event) {
      print(event);
    });
  }
}
