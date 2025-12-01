/// success : true
/// data : {"message":"Category updated successfully.","category":{"_id":"692cbda652caf2f56ba75a0c","name":"fff","parentId":"691a4fc5a5c283182c4de7ec","createdAt":"2025-11-30T21:56:54.088Z","updatedAt":"2025-11-30T22:14:33.259Z","__v":0}}

class UpdateCategoryResponse {
  UpdateCategoryResponse({
      this.success, 
      this.data,});

  UpdateCategoryResponse.fromJson(dynamic json) {
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

/// message : "Category updated successfully."
/// category : {"_id":"692cbda652caf2f56ba75a0c","name":"fff","parentId":"691a4fc5a5c283182c4de7ec","createdAt":"2025-11-30T21:56:54.088Z","updatedAt":"2025-11-30T22:14:33.259Z","__v":0}

class Data {
  Data({
      this.message, 
      this.category,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }
  String? message;
  Category? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    return map;
  }

}

/// _id : "692cbda652caf2f56ba75a0c"
/// name : "fff"
/// parentId : "691a4fc5a5c283182c4de7ec"
/// createdAt : "2025-11-30T21:56:54.088Z"
/// updatedAt : "2025-11-30T22:14:33.259Z"
/// __v : 0

class Category {
  Category({
      this.id, 
      this.name, 
      this.parentId, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Category.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    parentId = json['parentId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? name;
  String? parentId;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['parentId'] = parentId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}