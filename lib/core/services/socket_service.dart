import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() => _instance;

  SocketService._internal();

  late IO.Socket socket;
  bool isConnected = false;

  final String serviceKey = "qikadmin"; // ⬅️ make sure it's 'qikadmin'
  final String livewareSecret = "liveware_secret";
  final String url = "https://liveware-qikearn-live-data-service.onrender.com";

  void connect({
    required Function onConnected,
    required Function(String) onDisconnected,
    required Function(String) onError,
    required Map<String, Function(dynamic)> eventListeners,
  }) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final data = utf8.encode('$serviceKey$timestamp');
    final key = utf8.encode(livewareSecret);
    final hmacSha256 = Hmac(sha256, key);
    final signature = hmacSha256.convert(data).toString();

    final authPayload = {
      'service_key': serviceKey,
      'timestamp': timestamp,
      'signature': signature,
    };

    print("🧩 Attempting to connect with auth: $authPayload");

    socket = IO.io(
      url,
      IO.OptionBuilder()
          .setTransports([
            'websocket',
            'polling',
          ]) // ✅ allow fallback to polling
          .setAuth(authPayload)
          .setTimeout(10000) // ✅ 10 seconds timeout
          .enableForceNew() // ✅ same as JS version
          .disableAutoConnect()
          .build(),
    );

    socket.onConnect((_) {
      isConnected = true;
      print("✅ Socket Connected: ${socket.id}");
      onConnected();
    });

    socket.onDisconnect((_) {
      isConnected = false;
      print("❌ Socket Disconnected");
      onDisconnected("Disconnected from server");
    });

    socket.onConnectError((err) {
      isConnected = false;
      print("🚫 Socket Connect Error: $err");
      onError(err.toString());
    });

    socket.onError((err) {
      isConnected = false;
      print("❗ General Socket Error: $err");
      onError(err.toString());
    });

    // Log all events (for debug)
    socket.onAny((event, data) {
      print("📩 [$event] $data");
    });

    // Bind all event listeners
    for (var entry in eventListeners.entries) {
      socket.on(entry.key, entry.value);
    }

    socket.connect(); // finally connect
  }

  void disconnect() {
    if (socket.connected) {
      socket.disconnect();
    }
    isConnected = false;
    print("🔌 Socket manually disconnected");
  }

  void emit(String event, dynamic payload) {
    if (isConnected) {
      print("📤 Emitting event: $event => $payload");
      socket.emit(event, payload);
    } else {
      print("⚠️ Cannot emit: socket not connected");
    }
  }
}
