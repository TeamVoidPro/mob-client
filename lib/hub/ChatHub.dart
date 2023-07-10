import 'package:signalr_netcore/signalr_client.dart';

import 'IChatHubService.dart';

// The location of the SignalR Server.
// var serverUrl = "192.168.10.50:10220/chat";
// // Creates the connection by using the HubConnectionBuilder.
// var hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
// // When the connection is closed, print out a message to the console.
// hubConnection.onclose( (error) => print("Connection Closed"));

class ChatHub implements IChatHubService {
  final hubConnection =
      HubConnectionBuilder().withUrl("http://10.0.2.2:5219/chat").build();
  String? connID;
  List<dynamic> users = [];

  @override
  Future<bool> connectToHub() {
    return _connectServer();
  }

  @override
  String? getClientId() {
    if (hubConnection.state == HubConnectionState.Connected) {
      return hubConnection.connectionId;
    } else {
      return null;
    }
  }

  @override
  onNewMessage(String methodName, Function(List? p1) onReceieved) {
    return hubConnection.on(methodName, onReceieved);
  }

  @override
  Future<bool> pushMessageToServer(String message) {
    try {
      if (hubConnection.state == HubConnectionState.Disconnected) {
        hubConnection.invoke("SendMessage", args: [message]);
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<List<dynamic>> getUsers() async {
    List<Object> users = [];
    hubConnection.invoke("GetConnectionID",args:[]).then((value) => 
    {
      print(value)
    });
  
    
    hubConnection.invoke("GetUsers", args: []).then((value) => {
          users.clear(),
          if (value != null) {users.add(value)},
          print(users)
        });
    return users;
  }

  Future<bool> _connectServer() async {
    try {
      await hubConnection.start();
      connID = hubConnection.connectionId;
      users = await getUsers();
      print("Connection started");
      print(users);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
