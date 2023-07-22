// Import the library.
import 'package:collage_me/core/cache_manager.dart';
import 'package:collage_me/core/my_shared_preference.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalrHub with CacheManager {
  static const String serverUrl = "https://evliliksitesii.com/hub";
  final hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();

  void connect() async {
    await MySharedPref.init();
    final _username = MySharedPref.get(username);
    hubConnection.start();
    hubConnection.invoke("subscribe");

    hubConnection.on("all", (arguments) {
      print(arguments);
    });
  }

  // final hubConnection.onclose( (error) => print("Connection Closed"));
}
