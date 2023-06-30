class message {
  String id;
  String image;
  String msg;
  String sender;
  String receiver;
  String timestamp;

  message({required this.id, required this.msg, required this.sender, required this.receiver, required this.image, this.timestamp = ""});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['sender'] = sender;
    data['receiver'] = receiver;
    data['timestamp'] = timestamp;
    return data;
  }
}