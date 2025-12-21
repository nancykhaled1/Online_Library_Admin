/// success : true
/// data : {"borrow":{"_id":"69480f9207a047efe61c6f78","userId":"692466ff58540df5fe549dc6","bookId":{"_id":"691c8eb9b4adb1589feb5249","name":"Book","categoryId":"691c8e69b4adb1589feb523b","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479223/books/qnkofkb7u7smy39amtcn.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479223/books/gallery/jjxucmvtkt7aiu5ggdk0.png"],"numberOfCopies":10,"numberInStock":9,"borrowedBy":1,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:20:25.167Z","updatedAt":"2025-12-21T16:37:16.911Z","__v":0},"borrowDate":"2025-12-21T15:17:38.678Z","borrowTime":"15:17","mustReturnDate":"2025-12-28T15:17:38.678Z","status":"returned","createdAt":"2025-12-21T15:17:38.683Z","updatedAt":"2025-12-21T16:37:16.810Z","__v":0,"scannedByAdminAt":"2025-12-21T15:29:52.195Z","returnedAt":"2025-12-21T16:37:16.809Z"}}

class ScanReturnResponse {
  ScanReturnResponse({
      this.success, 
      this.data,});

  ScanReturnResponse.fromJson(dynamic json) {
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

/// borrow : {"_id":"69480f9207a047efe61c6f78","userId":"692466ff58540df5fe549dc6","bookId":{"_id":"691c8eb9b4adb1589feb5249","name":"Book","categoryId":"691c8e69b4adb1589feb523b","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479223/books/qnkofkb7u7smy39amtcn.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479223/books/gallery/jjxucmvtkt7aiu5ggdk0.png"],"numberOfCopies":10,"numberInStock":9,"borrowedBy":1,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:20:25.167Z","updatedAt":"2025-12-21T16:37:16.911Z","__v":0},"borrowDate":"2025-12-21T15:17:38.678Z","borrowTime":"15:17","mustReturnDate":"2025-12-28T15:17:38.678Z","status":"returned","createdAt":"2025-12-21T15:17:38.683Z","updatedAt":"2025-12-21T16:37:16.810Z","__v":0,"scannedByAdminAt":"2025-12-21T15:29:52.195Z","returnedAt":"2025-12-21T16:37:16.809Z"}

class Data {
  Data({
      this.borrow,});

  Data.fromJson(dynamic json) {
    borrow = json['borrow'] != null ? Return.fromJson(json['borrow']) : null;
  }
  Return? borrow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (borrow != null) {
      map['borrow'] = borrow?.toJson();
    }
    return map;
  }

}

/// _id : "69480f9207a047efe61c6f78"
/// userId : "692466ff58540df5fe549dc6"
/// bookId : {"_id":"691c8eb9b4adb1589feb5249","name":"Book","categoryId":"691c8e69b4adb1589feb523b","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479223/books/qnkofkb7u7smy39amtcn.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479223/books/gallery/jjxucmvtkt7aiu5ggdk0.png"],"numberOfCopies":10,"numberInStock":9,"borrowedBy":1,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:20:25.167Z","updatedAt":"2025-12-21T16:37:16.911Z","__v":0}
/// borrowDate : "2025-12-21T15:17:38.678Z"
/// borrowTime : "15:17"
/// mustReturnDate : "2025-12-28T15:17:38.678Z"
/// status : "returned"
/// createdAt : "2025-12-21T15:17:38.683Z"
/// updatedAt : "2025-12-21T16:37:16.810Z"
/// __v : 0
/// scannedByAdminAt : "2025-12-21T15:29:52.195Z"
/// returnedAt : "2025-12-21T16:37:16.809Z"

class Return {
  Return({
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
      this.scannedByAdminAt, 
      this.returnedAt,});

  Return.fromJson(dynamic json) {
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
    returnedAt = json['returnedAt'];
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
  String? returnedAt;

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
    map['returnedAt'] = returnedAt;
    return map;
  }

}

/// _id : "691c8eb9b4adb1589feb5249"
/// name : "Book"
/// categoryId : "691c8e69b4adb1589feb523b"
/// mainImage : "https://res.cloudinary.com/diubywm4o/image/upload/v1763479223/books/qnkofkb7u7smy39amtcn.png"
/// gallery : ["https://res.cloudinary.com/diubywm4o/image/upload/v1763479223/books/gallery/jjxucmvtkt7aiu5ggdk0.png"]
/// numberOfCopies : 10
/// numberInStock : 9
/// borrowedBy : 1
/// publisher : "Publisher Name"
/// writer : "Writer Name"
/// language : "English"
/// publishYear : 2022
/// edition : "First"
/// Synopsis : "This is a sample book."
/// numPages : 250
/// condition : "old"
/// weight : 500
/// createdAt : "2025-11-18T15:20:25.167Z"
/// updatedAt : "2025-12-21T16:37:16.911Z"
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