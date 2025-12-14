/// success : true
/// data : {"message":"Book created successfully","book":{"name":"Book Examplessssssssssssssss","categoryId":"691448b1754324fe6aa70bd7","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1764624152/books/mu5d55cju8n2i5zbeno2.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1764624152/books/gallery/zbeim4lxf2nugsbpr9tj.png"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"new","weight":500,"_id":"692e071852caf2f56ba75ba2","createdAt":"2025-12-01T21:22:32.984Z","updatedAt":"2025-12-01T21:22:32.984Z","__v":0}}

class AddBookResponse {
  AddBookResponse({
      this.success, 
      this.data,});

  AddBookResponse.fromJson(dynamic json) {
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

/// message : "Book created successfully"
/// book : {"name":"Book Examplessssssssssssssss","categoryId":"691448b1754324fe6aa70bd7","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1764624152/books/mu5d55cju8n2i5zbeno2.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1764624152/books/gallery/zbeim4lxf2nugsbpr9tj.png"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"new","weight":500,"_id":"692e071852caf2f56ba75ba2","createdAt":"2025-12-01T21:22:32.984Z","updatedAt":"2025-12-01T21:22:32.984Z","__v":0}

class Data {
  Data({
      this.message, 
      this.book,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    book = json['book'] != null ? Book.fromJson(json['book']) : null;
  }
  String? message;
  Book? book;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (book != null) {
      map['book'] = book?.toJson();
    }
    return map;
  }

}

/// name : "Book Examplessssssssssssssss"
/// categoryId : "691448b1754324fe6aa70bd7"
/// mainImage : "https://res.cloudinary.com/diubywm4o/image/upload/v1764624152/books/mu5d55cju8n2i5zbeno2.png"
/// gallery : ["https://res.cloudinary.com/diubywm4o/image/upload/v1764624152/books/gallery/zbeim4lxf2nugsbpr9tj.png"]
/// numberOfCopies : 10
/// numberInStock : 10
/// borrowedBy : 0
/// publisher : "Publisher Name"
/// writer : "Writer Name"
/// language : "English"
/// publishYear : 2022
/// edition : "First"
/// Synopsis : "This is a sample book."
/// numPages : 250
/// condition : "new"
/// weight : 500
/// _id : "692e071852caf2f56ba75ba2"
/// createdAt : "2025-12-01T21:22:32.984Z"
/// updatedAt : "2025-12-01T21:22:32.984Z"
/// __v : 0

class Book {
  Book({
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
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Book.fromJson(dynamic json) {
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
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
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
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}