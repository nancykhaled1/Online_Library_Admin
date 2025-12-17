/// success : true
/// data : {"message":"Notification fetched successfully","notification":{"_id":"6926249864f8c46c58c838a1","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-25T21:50:16.956Z","updatedAt":"2025-11-25T21:50:16.956Z","__v":0}}

class NotificationDetailsResponse {
  NotificationDetailsResponse({
      this.success, 
      this.data,});

  NotificationDetailsResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? DataDetails.fromJson(json['data']) : null;
  }
  bool? success;
  DataDetails? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// message : "Notification fetched successfully"
/// notification : {"_id":"6926249864f8c46c58c838a1","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-25T21:50:16.956Z","updatedAt":"2025-11-25T21:50:16.956Z","__v":0}

class DataDetails {
  DataDetails({
      this.message, 
      this.notification,});

  DataDetails.fromJson(dynamic json) {
    message = json['message'];
    notification = json['notification'] != null ? NotificationDetails.fromJson(json['notification']) : null;
  }
  String? message;
  NotificationDetails? notification;

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

class NotificationDetails {
  NotificationDetails({
      this.id, 
      this.title, 
      this.body, 
      this.relatedId, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  NotificationDetails.fromJson(dynamic json) {
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