/// success : true
/// data : {"borrow":{"_id":"6946bf7486fc1dc06be53ad8","userId":"692466ff58540df5fe549dc6","bookId":{"_id":"691c8e1ab4adb1589feb5238","name":"Education Book","categoryId":"691b7d849e366d61f7897b75","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"],"numberOfCopies":10,"numberInStock":7,"borrowedBy":3,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:17:46.596Z","updatedAt":"2025-12-20T15:23:56.826Z","__v":0},"borrowDate":"2025-12-20T15:23:31.667Z","borrowTime":"15:23","mustReturnDate":"2025-12-27T15:23:31.667Z","status":"on_borrow","createdAt":"2025-12-20T15:23:32.413Z","updatedAt":"2025-12-20T15:23:56.588Z","__v":0,"scannedByAdminAt":"2025-12-20T15:23:56.587Z"}}

class ScanBorrowedResponse {
  ScanBorrowedResponse({
      this.success, 
      this.data,});

  ScanBorrowedResponse.fromJson(dynamic json) {
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

/// borrow : {"_id":"6946bf7486fc1dc06be53ad8","userId":"692466ff58540df5fe549dc6","bookId":{"_id":"691c8e1ab4adb1589feb5238","name":"Education Book","categoryId":"691b7d849e366d61f7897b75","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"],"numberOfCopies":10,"numberInStock":7,"borrowedBy":3,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:17:46.596Z","updatedAt":"2025-12-20T15:23:56.826Z","__v":0},"borrowDate":"2025-12-20T15:23:31.667Z","borrowTime":"15:23","mustReturnDate":"2025-12-27T15:23:31.667Z","status":"on_borrow","createdAt":"2025-12-20T15:23:32.413Z","updatedAt":"2025-12-20T15:23:56.588Z","__v":0,"scannedByAdminAt":"2025-12-20T15:23:56.587Z"}

class Data {
  Data({
      this.borrow,});

  Data.fromJson(dynamic json) {
    borrow = json['borrow'] != null ? Borrow.fromJson(json['borrow']) : null;
  }
  Borrow? borrow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (borrow != null) {
      map['borrow'] = borrow?.toJson();
    }
    return map;
  }

}

/// _id : "6946bf7486fc1dc06be53ad8"
/// userId : "692466ff58540df5fe549dc6"
/// bookId : {"_id":"691c8e1ab4adb1589feb5238","name":"Education Book","categoryId":"691b7d849e366d61f7897b75","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"],"numberOfCopies":10,"numberInStock":7,"borrowedBy":3,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:17:46.596Z","updatedAt":"2025-12-20T15:23:56.826Z","__v":0}
/// borrowDate : "2025-12-20T15:23:31.667Z"
/// borrowTime : "15:23"
/// mustReturnDate : "2025-12-27T15:23:31.667Z"
/// status : "on_borrow"
/// createdAt : "2025-12-20T15:23:32.413Z"
/// updatedAt : "2025-12-20T15:23:56.588Z"
/// __v : 0
/// scannedByAdminAt : "2025-12-20T15:23:56.587Z"

class Borrow {
  Borrow({
      this.id, 
      this.userId, 
      this.bookId, 
      this.borrowDate, 
      this.borrowTime, 
      this.mustReturnDate, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.scannedByAdminAt,});

  Borrow.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['userId'];
    bookId = json['bookId'] != null ? BookId.fromJson(json['bookId']) : null;
    borrowDate = json['borrowDate'];
    borrowTime = json['borrowTime'];
    mustReturnDate = json['mustReturnDate'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    scannedByAdminAt = json['scannedByAdminAt'];
  }
  String? id;
  String? userId;
  BookId? bookId;
  String? borrowDate;
  String? borrowTime;
  String? mustReturnDate;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? scannedByAdminAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['userId'] = userId;
    if (bookId != null) {
      map['bookId'] = bookId?.toJson();
    }
    map['borrowDate'] = borrowDate;
    map['borrowTime'] = borrowTime;
    map['mustReturnDate'] = mustReturnDate;
    map['status'] = status;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['scannedByAdminAt'] = scannedByAdminAt;
    return map;
  }

}

/// _id : "691c8e1ab4adb1589feb5238"
/// name : "Education Book"
/// categoryId : "691b7d849e366d61f7897b75"
/// mainImage : "https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png"
/// gallery : ["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"]
/// numberOfCopies : 10
/// numberInStock : 7
/// borrowedBy : 3
/// publisher : "Publisher Name"
/// writer : "Writer Name"
/// language : "English"
/// publishYear : 2022
/// edition : "First"
/// Synopsis : "This is a sample book."
/// numPages : 250
/// condition : "old"
/// weight : 500
/// createdAt : "2025-11-18T15:17:46.596Z"
/// updatedAt : "2025-12-20T15:23:56.826Z"
/// __v : 0

class BookId {
  BookId({
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

  BookId.fromJson(dynamic json) {
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