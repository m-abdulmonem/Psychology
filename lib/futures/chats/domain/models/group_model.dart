class GroupModel {
  String? from, to,lastMsg;

  GroupModel({this.from, this.to,this.lastMsg});

  GroupModel.fromJson(Map<dynamic, dynamic> json)
      : from = json['from'],
        lastMsg = json['lastMsg'] ?? "",
        to = json['to'];

  Map<String,dynamic> toJson() => {
    'from' : from,
    'lastMsg' : lastMsg,
    'to' : to
  };
}
