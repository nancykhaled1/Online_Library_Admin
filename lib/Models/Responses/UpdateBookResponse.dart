/// success : true
/// data : {"message":"Book updated successfully","book":{"_id":"69296ca8396b30a88ff2f413","name":"Book 22","categoryId":"691b5a0a28146284cb63eda7","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1764322471/books/a5koc7n4u4xeebjxprdt.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1764322472/books/gallery/taeciieyuzaqpvpjkywd.png","https://res.cloudinary.com/diubywm4o/image/upload/v1764322472/books/gallery/sg0yslon9d0cjggqgluq.jpg"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2021,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"new","weight":500,"createdAt":"2025-11-28T09:34:32.787Z","updatedAt":"2025-12-15T14:04:53.233Z","__v":0}}

class UpdateBookResponse {
  UpdateBookResponse({
      this.success, 
      this.data,});

  UpdateBookResponse.fromJson(dynamic json) {
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

/// message : "Book updated successfully"
/// book : {"_id":"69296ca8396b30a88ff2f413","name":"Book 22","categoryId":"691b5a0a28146284cb63eda7","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1764322471/books/a5koc7n4u4xeebjxprdt.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1764322472/books/gallery/taeciieyuzaqpvpjkywd.png","https://res.cloudinary.com/diubywm4o/image/upload/v1764322472/books/gallery/sg0yslon9d0cjggqgluq.jpg"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2021,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"new","weight":500,"createdAt":"2025-11-28T09:34:32.787Z","updatedAt":"2025-12-15T14:04:53.233Z","__v":0}

class Data {
  Data({
      this.message, 
      this.book,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    book = json['book'] != null ? UpdateBook.fromJson(json['book']) : null;
  }
  String? message;
  UpdateBook? book;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (book != null) {
      map['book'] = book?.toJson();
    }
    return map;
  }

}

/// _id : "69296ca8396b30a88ff2f413"
/// name : "Book 22"
/// categoryId : "691b5a0a28146284cb63eda7"
/// mainImage : "https://res.cloudinary.com/diubywm4o/image/upload/v1764322471/books/a5koc7n4u4xeebjxprdt.png"
/// gallery : ["https://res.cloudinary.com/diubywm4o/image/upload/v1764322472/books/gallery/taeciieyuzaqpvpjkywd.png","https://res.cloudinary.com/diubywm4o/image/upload/v1764322472/books/gallery/sg0yslon9d0cjggqgluq.jpg"]
/// numberOfCopies : 10
/// numberInStock : 10
/// borrowedBy : 0
/// publisher : "Publisher Name"
/// writer : "Writer Name"
/// language : "English"
/// publishYear : 2021
/// edition : "First"
/// Synopsis : "This is a sample book."
/// numPages : 250
/// condition : "new"
/// weight : 500
/// createdAt : "2025-11-28T09:34:32.787Z"
/// updatedAt : "2025-12-15T14:04:53.233Z"
/// __v : 0

class UpdateBook {
  UpdateBook({
      this.id, 
      this.name, 
      this.categoryId, 
      this.mainImage, 
      this.gallery, 
      this.numberOfCopies, 
      this.numberInStock, 
      this.borrowedBy, 
      this.publisher, 
      this.writer, 
      this.language, 
      this.publishYear, 
      this.edition, 
      this.synopsis, 
      this.numPages, 
      this.condition, 
      this.weight, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  UpdateBook.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    categoryId = json['categoryId'];
    mainImage = json['mainImage'];
    gallery = json['gallery'] != null ? json['gallery'].cast<String>() : [];
    numberOfCopies = json['numberOfCopies'];
    numberInStock = json['numberInStock'];
    borrowedBy = json['borrowedBy'];
    publisher = json['publisher'];
    writer = json['writer'];
    language = json['language'];
    publishYear = json['publishYear'];
    edition = json['edition'];
    synopsis = json['Synopsis'];
    numPages = json['numPages'];
    condition = json['condition'];
    weight = json['weight'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? name;
  String? categoryId;
  String? mainImage;
  List<String>? gallery;
  int? numberOfCopies;
  int? numberInStock;
  int? borrowedBy;
  String? publisher;
  String? writer;
  String? language;
  int? publishYear;
  String? edition;
  String? synopsis;
  int? numPages;
  String? condition;
  int? weight;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['categoryId'] = categoryId;
    map['mainImage'] = mainImage;
    map['gallery'] = gallery;
    map['numberOfCopies'] = numberOfCopies;
    map['numberInStock'] = numberInStock;
    map['borrowedBy'] = borrowedBy;
    map['publisher'] = publisher;
    map['writer'] = writer;
    map['language'] = language;
    map['publishYear'] = publishYear;
    map['edition'] = edition;
    map['Synopsis'] = synopsis;
    map['numPages'] = numPages;
    map['condition'] = condition;
    map['weight'] = weight;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}