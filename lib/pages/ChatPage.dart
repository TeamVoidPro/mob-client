import 'package:flutter/material.dart';

import '../data/Message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  static String _profilePic = "assets/Images/user.jpeg";
  List<message> _messages = [
    message(
      sender: "user",
      msg: "Hello 1",
      timestamp: "10:00",
      id: '1',
      receiver: "admin",
      image: _profilePic,
    ),
    message(
      sender: "admin",
      msg: "Hello back 1",
      timestamp: "10:00",
      id: '2',
      receiver: "user",
      image: _profilePic,
    ),
    message(
      sender: "user",
      msg: "Hello 2",
      timestamp: "10:00",
      id: '3',
      receiver: "admin",
      image: _profilePic,
    ),
    message(
      sender: "admin",
      msg: "Hello back 2",
      timestamp: "10:00",
      id: '4',
      receiver: "user",
      image: _profilePic,
    ),
  ];

  void _handleSubmitted(String msg) {
    print(_textController.text);


    setState(() {
      _messages.add(message(
        sender: "user",
        msg: _textController.text,
        timestamp: "10:00",
        id: '5',
        receiver: "admin",
        image: _profilePic,
      ));
    });
    _textController.clear();
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(
                hintText: 'Type your message...',
              ),
            ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  Widget RenderChat() {
    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: _messages[index].sender == "user"
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (_messages[index].sender == "admin")
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(_messages[index].image),
                ),
              if (_messages[index].sender == "admin")
                  SizedBox(
                    width: 10,
                  ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _messages[index].sender == "user"
                      ? Colors.blue
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _messages[index].msg,
                  style: TextStyle(
                    fontSize: 16,
                    color: _messages[index].sender == "user"
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              if (_messages[index].sender == "user")
                SizedBox(
                  width: 10,
                ),
              if (_messages[index].sender == "user")
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(_messages[index].image),
                ),
            ],
          ),
        );
      },
    );
  }

  // chat message list

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    print("arguments: $arguments");
    String _msg = "";
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/chatList');
            },
            icon: Icon(Icons.keyboard_arrow_left),
          ),
          title: Text(" UCSC Park "),
          actions: [
            // User Icon with clickability
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(_profilePic),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
                height: _height * 0.95,
                margin: EdgeInsets.only(bottom: _height * 0.12),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 237, 249, 252),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // chat messages
                  children: [
                    Expanded(
                      child: RenderChat(),
                    ),
                  ],
                )),
            Positioned(
                bottom: 0,
                left: 0,
                height: _height * 0.11,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 30,
                        color:
                            Color.fromARGB(255, 37, 54, 101).withOpacity(0.2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child:
                  Row(
                    children: [
                      // Chat input field and send button
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                          child: TextField(
                            controller: _textController,
                            onSubmitted: _handleSubmitted,
                            decoration: InputDecoration(
                              hintText: "Type a message",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: ElevatedButton(
                          onPressed: () {
                            _handleSubmitted(_textController.text);
                          },
                          child: Icon(Icons.send),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            backgroundColor: Color.fromARGB(255, 37, 54, 101),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
