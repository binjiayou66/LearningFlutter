enum MessageType {
  System,
  Public,
  Chat,
  Group,
}

class MessageData {
  String avatar;
  String title;
  String subTitle;
  DateTime time;
  MessageType type;

  MessageData(this.avatar, this.title, this.subTitle, this.time, this.type);
}
