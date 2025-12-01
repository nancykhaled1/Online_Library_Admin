/// success : true
/// data : {"message":"Category created successfully.","category":{"name":"Stories","parentId":null,"_id":"692c538d52caf2f56ba75977","createdAt":"2025-11-30T14:24:13.749Z","updatedAt":"2025-11-30T14:24:13.749Z","__v":0}}

class ParentCategoryResponse {
  ParentCategoryResponse({
      this.success, 
      this.data,});

  ParentCategoryResponse.fromJson(dynamic json) {
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

/// message : "Category created successfully."
/// category : {"name":"Stories","parentId":null,"_id":"692c538d52caf2f56ba75977","createdAt":"2025-11-30T14:24:13.749Z","updatedAt":"2025-11-30T14:24:13.749Z","__v":0}

class Data {
  Data({
      this.message, 
      this.category,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    category = json['category'] != null ? ParentCategory.fromJson(json['category']) : null;
  }
  String? message;
  ParentCategory? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    return map;
  }

}

/// name : "Stories"
/// parentId : null
/// _id : "692c538d52caf2f56ba75977"
/// createdAt : "2025-11-30T14:24:13.749Z"
/// updatedAt : "2025-11-30T14:24:13.749Z"
/// __v : 0

class ParentCategory {
  ParentCategory({
      this.name, 
      this.parentId, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  ParentCategory.fromJson(dynamic json) {
    name = json['name'];
    parentId = json['parentId'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? name;
  dynamic parentId;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['parentId'] = parentId;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}