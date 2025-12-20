/// success : true
/// data : {"message":"Notification sent to all users","notificationId":"6942c35586fc1dc06be539ea","results":{"successCount":4,"failureCount":2,"totalTokens":6}}

class AddNotificationResponse {
  AddNotificationResponse({
      this.success, 
      this.data,});

  AddNotificationResponse.fromJson(dynamic json) {
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

/// message : "Notification sent to all users"
/// notificationId : "6942c35586fc1dc06be539ea"
/// results : {"successCount":4,"failureCount":2,"totalTokens":6}

class Data {
  Data({
      this.message, 
      this.notificationId, 
      this.results,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    notificationId = json['notificationId'];
    results = json['results'] != null ? Results.fromJson(json['results']) : null;
  }
  String? message;
  String? notificationId;
  Results? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['notificationId'] = notificationId;
    if (results != null) {
      map['results'] = results?.toJson();
    }
    return map;
  }

}

/// successCount : 4
/// failureCount : 2
/// totalTokens : 6

class Results {
  Results({
      this.successCount, 
      this.failureCount, 
      this.totalTokens,});

  Results.fromJson(dynamic json) {
    successCount = json['successCount'];
    failureCount = json['failureCount'];
    totalTokens = json['totalTokens'];
  }
  int? successCount;
  int? failureCount;
  int? totalTokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['successCount'] = successCount;
    map['failureCount'] = failureCount;
    map['totalTokens'] = totalTokens;
    return map;
  }

}