/// name : "science"

class ParentCategoryRequest {
  ParentCategoryRequest({
      this.name,});

  ParentCategoryRequest.fromJson(dynamic json) {
    name = json['name'];
  }
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}