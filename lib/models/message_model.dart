class MessageModel {
  late String senderId;
  late String receiverId;
  late String dateTime;
  late String text;

  MessageModel({
    required this.senderId,
    required this.text,
    required this.receiverId,
    required this.dateTime,
  });

  MessageModel.fromJson(Map<String, dynamic>? json) {
    senderId = json!['senderId'];
    text = json['text'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'receiverId': receiverId,
      'dateTime': dateTime,
    };
  }
}
