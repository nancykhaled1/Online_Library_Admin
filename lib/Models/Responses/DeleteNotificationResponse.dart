/// success : true
/// data : {"message":"Notification deleted successfully","notification":{"_id":"6926249864f8c46c58c838a1","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-25T21:50:16.956Z","updatedAt":"2025-11-25T21:50:16.956Z","__v":0}}

class DeleteNotificationResponse {
  DeleteNotificationResponse({
      this.success, 
      this.data,});

  DeleteNotificationResponse.fromJson(dynamic json) {
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

/// message : "Notification deleted successfully"
/// notification : {"_id":"6926249864f8c46c58c838a1","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-25T21:50:16.956Z","updatedAt":"2025-11-25T21:50:16.956Z","__v":0}

class Data {
  Data({
      this.message, 
      this.notification,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    notification = json['notification'] != null ? Notification.fromJson(json['notification']) : null;
  }
  String? message;
  Notification? notification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (notification != null) {
      map['notification'] = notification?.toJson();
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

class Notification {
  Notification({
      this.id, 
      this.title, 
      this.body, 
      this.relatedId, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Notification.fromJson(dynamic json) {
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