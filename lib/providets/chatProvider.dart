import 'package:flutter/material.dart';

import '../data/MessagedUser.dart';
import '../hub/ChatHub.dart';
import '../hub/IChatHubService.dart';

class chatProvider extends ChangeNotifier {
  MessagedUser? _messagedUser = null;
  String? _clientConnID = "";
  IChatHubService? _chatHubService = null;
  List<dynamic> users = [];

  MessagedUser? get messagedUser => _messagedUser;
  String get clientConnID => _clientConnID ?? "";
  IChatHubService? get chatHubService => _chatHubService;

  void setConnectionID() async {
    _chatHubService = ChatHub();
    _chatHubService?.connectToHub();
    _clientConnID = _chatHubService?.getClientId();
    // users = await _chatHubService!.getUsers();
  }

  void getUsers() async {
    users = await _chatHubService!.getUsers();
    notifyListeners();
  }

  IChatHubService getChatHubService(){
    return _chatHubService!;
  }




  void setMessagedUser(MessagedUser? messagedUser) {
    _messagedUser = messagedUser;
    notifyListeners();
  }

  void clearMessagedUser() {
    _messagedUser = null;
    notifyListeners();
  }
}
