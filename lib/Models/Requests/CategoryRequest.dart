/// name : "science"
/// parentId : "691b5a0a28146284cb63eda7"

class CategoryRequest {
  CategoryRequest({
      this.name, 
      this.parentId,});

  CategoryRequest.fromJson(dynamic json) {
    name = json['name'];
    parentId = json['parentId'];
  }
  String? name;
  String? parentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['parentId'] = parentId;
    return map;
  }

}