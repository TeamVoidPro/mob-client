import 'package:flutter/material.dart';
import 'package:mob_client/providets/chatProvider.dart';
import 'package:provider/provider.dart';
// import 'package:signalr_netcore/hub_connection.dart';
// import 'package:signalr_netcore/hub_connection_builder.dart';

import '../data/MessagedUser.dart';
import '../hub/ChatHub.dart';
import '../hub/IChatHubService.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPage();
}

class _ChatListPage extends State<ChatListPage> {
  late IChatHubService _chatHubService;
  String? connID;

  @override
  void initState() {
    super.initState();
  }

  void onMessageRecieved(List<dynamic>? args) {
    print(args);
    setState(() {
      connID = args?[0];
    });
  }

  List<MessagedUser> users = [
    MessagedUser(
      connId: "1",
      name: "User 1",
      image: "assets/Images/user.jpeg",
      lastMessage: "Hello 1",
      timestamp: "10:00",
      isOnline: true,
      unreadMessages: 1,
    ),
    MessagedUser(
      connId: "2",
      name: "User 2",
      image: "assets/Images/user.jpeg",
      lastMessage: "Hello 2",
      timestamp: "10:00",
      isOnline: false,
      unreadMessages: 2,
    )
  ];

  @override
  Widget build(BuildContext context) {
    // provider
    final chatsProvider = Provider.of<chatProvider>(context);
    chatsProvider.setConnectionID();
    final _ChatHubService = chatsProvider.chatHubService;
    final _ConnID = chatsProvider.clientConnID;
    print(_ConnID);
    // print(chatsProvider.users);

    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 237, 249, 252),
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 50,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
              size: 32,
            ),
            onPressed: () {},
          ),
          title: Text(
            'My Chat',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            // Chat Icon wrapped inside a Container with #EDF9FC color background and border radius of 15
            Container(
              margin: EdgeInsets.only(right: 10),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 237, 249, 252),
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/home');
                  print(_chatHubService.getClientId());
                },
                icon: Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 0, 116, 217),
                ),
              ),
            ),
          ],
          actionsIconTheme:
              IconThemeData(color: Color.fromARGB(255, 120, 119, 115)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                child: ListView.builder(
                  itemCount: users.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        onTap: () {
                          print(_chatHubService.getClientId());
                          // send the user connId to the chat page
                          Navigator.pushNamed(context, '/chat',
                              arguments: users[index].connId);
                        },
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(users[index].image),
                          child: users[index].isOnline
                              ? Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                        title: Text(
                          users[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          users[index].lastMessage,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              users[index].timestamp,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            if (users[index].unreadMessages! > 0)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  users[index].unreadMessages.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text(connID ?? "No message")
            ],
          ),
        ));
  }
}
