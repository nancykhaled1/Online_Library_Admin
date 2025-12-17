/// success : true
/// data : {"message":"Notifications fetched successfully","notifications":[{"_id":"6926249864f8c46c58c838a1","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-25T21:50:16.956Z","updatedAt":"2025-11-25T21:50:16.956Z","__v":0},{"_id":"69287b0ca6d3d61952c099e0","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-27T16:23:40.547Z","updatedAt":"2025-11-27T16:23:40.547Z","__v":0},{"_id":"6928cb87a6d3d61952c09a5e","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-27T22:07:03.334Z","updatedAt":"2025-11-27T22:07:03.334Z","__v":0},{"_id":"69296e78396b30a88ff2f4a7","title":"mmmmmmmmmmmmmmmmmmm","body":"This is a test notification from Postman","relatedId":"692968b9396b30a88ff2f3cb","createdAt":"2025-11-28T09:42:16.711Z","updatedAt":"2025-11-28T09:42:16.711Z","__v":0},{"_id":"69296ea3396b30a88ff2f4c8","title":"mmmmmmmmmmmmmmmmmmxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxm","body":"This is a test notification from Postman","relatedId":"692968b9396b30a88ff2f3cb","createdAt":"2025-11-28T09:42:59.581Z","updatedAt":"2025-11-28T09:42:59.581Z","__v":0},{"_id":"69296ec6396b30a88ff2f4ec","title":"mmmmmmmmmmmmmmmmmmxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxm","body":"This is a test notification from Posdsa;lvnlanslvnlasnvlanelsvnlkasnvelknsdvnsdv;/an;evn;an ev.tman","relatedId":"692968b9396b30a88ff2f3cb","createdAt":"2025-11-28T09:43:34.145Z","updatedAt":"2025-11-28T09:43:34.145Z","__v":0},{"_id":"69296eca396b30a88ff2f4f1","title":"mmmmmmmmmmmmmmmmmmxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxm","body":"This is a test notification from Posdsa;lvnlanslvnlasnvlanelsvnlkasnvelknsdvnsdv;/an;evn;an ev.tman","relatedId":"692968b9396b30a88ff2f3cb","createdAt":"2025-11-28T09:43:38.661Z","updatedAt":"2025-11-28T09:43:38.661Z","__v":0},{"_id":"69299fdc0fa31383af5b53fe","title":"testttttttttttttttttttttttttttttttttttttttttttt","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-28T13:13:00.384Z","updatedAt":"2025-11-28T13:13:00.384Z","__v":0},{"_id":"6929b07a0fa31383af5b5469","title":"testttttttttttttttttttttttttttttttttttttttttttt","body":"This is a test notification from PostmanThis is a test notification from PostmanThis is a test notification from PostmanThis is a test notification from PostmanThis is a test notification from PostmanThis is a test notification from PostmanThis is a test notification from Postman","relatedId":null,"createdAt":"2025-11-28T14:23:54.504Z","updatedAt":"2025-11-28T14:23:54.504Z","__v":0}]}

class GetNotificationResponse {
  GetNotificationResponse({
      this.success, 
      this.data,});

  GetNotificationResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// message : "Notifications fetched successfully"
/// notifications : [{"_id":"6926249864f8c46c58c838a1","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-25T21:50:16.956Z","updatedAt":"2025-11-25T21:50:16.956Z","__v":0},{"_id":"69287b0ca6d3d61952c099e0","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-27T16:23:40.547Z","updatedAt":"2025-11-27T16:23:40.547Z","__v":0},{"_id":"6928cb87a6d3d61952c09a5e","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-27T22:07:03.334Z","updatedAt":"2025-11-27T22:07:03.334Z","__v":0},{"_id":"69296e78396b30a88ff2f4a7","title":"mmmmmmmmmmmmmmmmmmm","body":"This is a test notification from Postman","relatedId":"692968b9396b30a88ff2f3cb","createdAt":"2025-11-28T09:42:16.711Z","updatedAt":"2025-11-28T09:42:16.711Z","__v":0},{"_id":"69296ea3396b30a88ff2f4c8","title":"mmmmmmmmmmmmmmmmmmxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxm","body":"This is a test notification from Postman","relatedId":"692968b9396b30a88ff2f3cb","createdAt":"2025-11-28T09:42:59.581Z","updatedAt":"2025-11-28T09:42:59.581Z","__v":0},{"_id":"69296ec6396b30a88ff2f4ec","title":"mmmmmmmmmmmmmmmmmmxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxm","body":"This is a test notification from Posdsa;lvnlanslvnlasnvlanelsvnlkasnvelknsdvnsdv;/an;evn;an ev.tman","relatedId":"692968b9396b30a88ff2f3cb","createdAt":"2025-11-28T09:43:34.145Z","updatedAt":"2025-11-28T09:43:34.145Z","__v":0},{"_id":"69296eca396b30a88ff2f4f1","title":"mmmmmmmmmmmmmmmmmmxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxm","body":"This is a test notification from Posdsa;lvnlanslvnlasnvlanelsvnlkasnvelknsdvnsdv;/an;evn;an ev.tman","relatedId":"692968b9396b30a88ff2f3cb","createdAt":"2025-11-28T09:43:38.661Z","updatedAt":"2025-11-28T09:43:38.661Z","__v":0},{"_id":"69299fdc0fa31383af5b53fe","title":"testttttttttttttttttttttttttttttttttttttttttttt","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-28T13:13:00.384Z","updatedAt":"2025-11-28T13:13:00.384Z","__v":0},{"_id":"6929b07a0fa31383af5b5469","title":"testttttttttttttttttttttttttttttttttttttttttttt","body":"This is a test notification from PostmanThis is a test notification from PostmanThis is a test notification from PostmanThis is a test notification from PostmanThis is a test notification from PostmanThis is a test notification from PostmanThis is a test notification from Postman","relatedId":null,"createdAt":"2025-11-28T14:23:54.504Z","updatedAt":"2025-11-28T14:23:54.504Z","__v":0}]

class Data {
  Data({
      this.message, 
      this.notifications,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    if (json['notifications'] != null) {
      notifications = [];
      json['notifications'].forEach((v) {
        notifications?.add(Notifications.fromJson(v));
      });
    }
  }
  String? message;
  List<Notifications>? notifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (notifications != null) {
      map['notifications'] = notifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6926249864f8c46c58c838a1"
/// title : "test"
/// body : "This is a test notification from Postman"
/// relatedId : null
/// createdAt : "2025-11-25T21:50:16.956Z"
/// updatedAt : "2025-11-25T21:50:16.956Z"
/// __v : 0

class Notifications {
  Notifications({
      this.id, 
      this.title, 
      this.body, 
      this.relatedId, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Notifications.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    body = json['body'];
    relatedId = json['relatedId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? title;
  String? body;
  dynamic relatedId;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['body'] = body;
    map['relatedId'] = relatedId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}