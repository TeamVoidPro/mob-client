class MessagedUser{
  String connId;
  String name;
  String image;
  String lastMessage;
  String timestamp;
  bool isOnline;
  int? unreadMessages;

  MessagedUser({required this.connId, required this.name, required this.image, required this.lastMessage, required this.timestamp, required this.isOnline, this.unreadMessages});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['connId'] = connId;
    data['name'] = name;
    data['image'] = image;
    data['lastMessage'] = lastMessage;
    data['timestamp'] = timestamp;
    data['isOnline'] = isOnline;
    data['unreadMessages'] = unreadMessages;
    return data;
  }
}