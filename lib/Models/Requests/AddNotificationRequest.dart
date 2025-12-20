/// title : "mmmmmmmmmmmmmmmmmmm"
/// body : "This is a test notification from Postman"

class AddNotificationRequest {
  AddNotificationRequest({
      this.title, 
      this.body,});

  AddNotificationRequest.fromJson(dynamic json) {
    title = json['title'];
    body = json['body'];
  }
  String? title;
  String? body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['body'] = body;
    return map;
  }

}