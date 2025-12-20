/// success : true
/// data : {"borrowedBooks":[{"_id":"692abf2452caf2f56ba7580d","user":{"_id":"69174062c824bbdb62ac1cf1","name":"Hassan Mohamed","email":"hassanmohed590@gmail.com","phone":"01012346666","role":"admin","gender":"male","emailVerified":true,"fcmtoken":"cv85w8VyQuODknhSJqnqJU:APA91bGJo1bEKDz0mwtf1waeX-1LxD8SdhDFaueRurPE-ayolj0mtdi9E6FVXlBPuPth42hSBHFovns_npa3j_LsCSTQNXQMpzdudOqPB_S78qYQaQmV82o","updatedAt":"2025-11-28T15:57:12.139Z","photo":"https://res.cloudinary.com/diubywm4o/image/upload/v1764325746/users/fslpwszu0j5palglf1rz.jpg","googleId":"101223657150379655931","id":"69174062c824bbdb62ac1cf1"},"book":{"_id":"69296d87396b30a88ff2f461","name":"قصص","categoryId":"691c8f54b4adb1589feb5265","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1766002091/books/ccbplwbrtiy8payhukg1.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1766002092/books/gallery/mw3bvquu98xvjttfbakv.png","https://res.cloudinary.com/diubywm4o/image/upload/v1766002093/books/gallery/hlpcl4m4cpghfmmdae9k.jpg"],"numberOfCopies":10,"numberInStock":9,"borrowedBy":1,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-28T09:38:15.743Z","updatedAt":"2025-12-17T20:08:13.484Z","__v":1},"borrowDate":"2025-11-29","borrowTime":"09:38","mustReturnDate":"2025-12-06","status":"on_borrow"}],"returnedBooks":[{"_id":"692968b9396b30a88ff2f3cb","user":{"_id":"69174062c824bbdb62ac1cf1","name":"Hassan Mohamed","email":"hassanmohed590@gmail.com","phone":"01012346666","role":"admin","gender":"male","emailVerified":true,"fcmtoken":"cv85w8VyQuODknhSJqnqJU:APA91bGJo1bEKDz0mwtf1waeX-1LxD8SdhDFaueRurPE-ayolj0mtdi9E6FVXlBPuPth42hSBHFovns_npa3j_LsCSTQNXQMpzdudOqPB_S78qYQaQmV82o","updatedAt":"2025-11-28T15:57:12.139Z","photo":"https://res.cloudinary.com/diubywm4o/image/upload/v1764325746/users/fslpwszu0j5palglf1rz.jpg","googleId":"101223657150379655931","id":"69174062c824bbdb62ac1cf1"},"book":{"_id":"691c8e1ab4adb1589feb5238","name":"Education Book","categoryId":"691b7d849e366d61f7897b75","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"],"numberOfCopies":10,"numberInStock":8,"borrowedBy":2,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:17:46.596Z","updatedAt":"2025-11-28T09:51:09.065Z","__v":0},"borrowDate":"2025-11-28","borrowTime":"09:17","mustReturnDate":"2025-12-05","returnDate":"2025-11-28","status":"returned"}]}

class BorrowedReturnedResponse {
  BorrowedReturnedResponse({
      this.success, 
      this.data,});

  BorrowedReturnedResponse.fromJson(dynamic json) {
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

/// borrowedBooks : [{"_id":"692abf2452caf2f56ba7580d","user":{"_id":"69174062c824bbdb62ac1cf1","name":"Hassan Mohamed","email":"hassanmohed590@gmail.com","phone":"01012346666","role":"admin","gender":"male","emailVerified":true,"fcmtoken":"cv85w8VyQuODknhSJqnqJU:APA91bGJo1bEKDz0mwtf1waeX-1LxD8SdhDFaueRurPE-ayolj0mtdi9E6FVXlBPuPth42hSBHFovns_npa3j_LsCSTQNXQMpzdudOqPB_S78qYQaQmV82o","updatedAt":"2025-11-28T15:57:12.139Z","photo":"https://res.cloudinary.com/diubywm4o/image/upload/v1764325746/users/fslpwszu0j5palglf1rz.jpg","googleId":"101223657150379655931","id":"69174062c824bbdb62ac1cf1"},"book":{"_id":"69296d87396b30a88ff2f461","name":"قصص","categoryId":"691c8f54b4adb1589feb5265","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1766002091/books/ccbplwbrtiy8payhukg1.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1766002092/books/gallery/mw3bvquu98xvjttfbakv.png","https://res.cloudinary.com/diubywm4o/image/upload/v1766002093/books/gallery/hlpcl4m4cpghfmmdae9k.jpg"],"numberOfCopies":10,"numberInStock":9,"borrowedBy":1,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-28T09:38:15.743Z","updatedAt":"2025-12-17T20:08:13.484Z","__v":1},"borrowDate":"2025-11-29","borrowTime":"09:38","mustReturnDate":"2025-12-06","status":"on_borrow"}]
/// returnedBooks : [{"_id":"692968b9396b30a88ff2f3cb","user":{"_id":"69174062c824bbdb62ac1cf1","name":"Hassan Mohamed","email":"hassanmohed590@gmail.com","phone":"01012346666","role":"admin","gender":"male","emailVerified":true,"fcmtoken":"cv85w8VyQuODknhSJqnqJU:APA91bGJo1bEKDz0mwtf1waeX-1LxD8SdhDFaueRurPE-ayolj0mtdi9E6FVXlBPuPth42hSBHFovns_npa3j_LsCSTQNXQMpzdudOqPB_S78qYQaQmV82o","updatedAt":"2025-11-28T15:57:12.139Z","photo":"https://res.cloudinary.com/diubywm4o/image/upload/v1764325746/users/fslpwszu0j5palglf1rz.jpg","googleId":"101223657150379655931","id":"69174062c824bbdb62ac1cf1"},"book":{"_id":"691c8e1ab4adb1589feb5238","name":"Education Book","categoryId":"691b7d849e366d61f7897b75","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"],"numberOfCopies":10,"numberInStock":8,"borrowedBy":2,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:17:46.596Z","updatedAt":"2025-11-28T09:51:09.065Z","__v":0},"borrowDate":"2025-11-28","borrowTime":"09:17","mustReturnDate":"2025-12-05","returnDate":"2025-11-28","status":"returned"}]

class Data {
  Data({
      this.borrowedBooks, 
      this.returnedBooks,});

  Data.fromJson(dynamic json) {
    if (json['borrowedBooks'] != null) {
      borrowedBooks = [];
      json['borrowedBooks'].forEach((v) {
        borrowedBooks?.add(BorrowedBooks.fromJson(v));
      });
    }
    if (json['returnedBooks'] != null) {
      returnedBooks = [];
      json['returnedBooks'].forEach((v) {
        returnedBooks?.add(ReturnedBooks.fromJson(v));
      });
    }
  }
  List<BorrowedBooks>? borrowedBooks;
  List<ReturnedBooks>? returnedBooks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (borrowedBooks != null) {
      map['borrowedBooks'] = borrowedBooks?.map((v) => v.toJson()).toList();
    }
    if (returnedBooks != null) {
      map['returnedBooks'] = returnedBooks?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "692968b9396b30a88ff2f3cb"
/// user : {"_id":"69174062c824bbdb62ac1cf1","name":"Hassan Mohamed","email":"hassanmohed590@gmail.com","phone":"01012346666","role":"admin","gender":"male","emailVerified":true,"fcmtoken":"cv85w8VyQuODknhSJqnqJU:APA91bGJo1bEKDz0mwtf1waeX-1LxD8SdhDFaueRurPE-ayolj0mtdi9E6FVXlBPuPth42hSBHFovns_npa3j_LsCSTQNXQMpzdudOqPB_S78qYQaQmV82o","updatedAt":"2025-11-28T15:57:12.139Z","photo":"https://res.cloudinary.com/diubywm4o/image/upload/v1764325746/users/fslpwszu0j5palglf1rz.jpg","googleId":"101223657150379655931","id":"69174062c824bbdb62ac1cf1"}
/// book : {"_id":"691c8e1ab4adb1589feb5238","name":"Education Book","categoryId":"691b7d849e366d61f7897b75","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"],"numberOfCopies":10,"numberInStock":8,"borrowedBy":2,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:17:46.596Z","updatedAt":"2025-11-28T09:51:09.065Z","__v":0}
/// borrowDate : "2025-11-28"
/// borrowTime : "09:17"
/// mustReturnDate : "2025-12-05"
/// returnDate : "2025-11-28"
/// status : "returned"

class ReturnedBooks {
  ReturnedBooks({
      this.id, 
      this.user, 
      this.book, 
      this.borrowDate, 
      this.borrowTime, 
      this.mustReturnDate, 
      this.returnDate, 
      this.status,});

  ReturnedBooks.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    book = json['book'] != null ? Book.fromJson(json['book']) : null;
    borrowDate = json['borrowDate'];
    borrowTime = json['borrowTime'];
    mustReturnDate = json['mustReturnDate'];
    returnDate = json['returnDate'];
    status = json['status'];
  }
  String? id;
  User? user;
  Book? book;
  String? borrowDate;
  String? borrowTime;
  String? mustReturnDate;
  String? returnDate;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (book != null) {
      map['book'] = book?.toJson();
    }
    map['borrowDate'] = borrowDate;
    map['borrowTime'] = borrowTime;
    map['mustReturnDate'] = mustReturnDate;
    map['returnDate'] = returnDate;
    map['status'] = status;
    return map;
  }

}

/// _id : "691c8e1ab4adb1589feb5238"
/// name : "Education Book"
/// categoryId : "691b7d849e366d61f7897b75"
/// mainImage : "https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png"
/// gallery : ["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"]
/// numberOfCopies : 10
/// numberInStock : 8
/// borrowedBy : 2
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
/// updatedAt : "2025-11-28T09:51:09.065Z"
/// __v : 0

class Book {
  Book({
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

  Book.fromJson(dynamic json) {
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

/// _id : "69174062c824bbdb62ac1cf1"
/// name : "Hassan Mohamed"
/// email : "hassanmohed590@gmail.com"
/// phone : "01012346666"
/// role : "admin"
/// gender : "male"
/// emailVerified : true
/// fcmtoken : "cv85w8VyQuODknhSJqnqJU:APA91bGJo1bEKDz0mwtf1waeX-1LxD8SdhDFaueRurPE-ayolj0mtdi9E6FVXlBPuPth42hSBHFovns_npa3j_LsCSTQNXQMpzdudOqPB_S78qYQaQmV82o"
/// updatedAt : "2025-11-28T15:57:12.139Z"
/// photo : "https://res.cloudinary.com/diubywm4o/image/upload/v1764325746/users/fslpwszu0j5palglf1rz.jpg"
/// googleId : "101223657150379655931"
/// id : "69174062c824bbdb62ac1cf1"

class User {
  User({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.role, 
      this.gender, 
      this.emailVerified, 
      this.fcmtoken, 
      this.updatedAt, 
      this.photo, 
      this.googleId, 
      });

  User.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    gender = json['gender'];
    emailVerified = json['emailVerified'];
    fcmtoken = json['fcmtoken'];
    updatedAt = json['updatedAt'];
    photo = json['photo'];
    googleId = json['googleId'];
  }
  String? id;
  String? name;
  String? email;
  String? phone;
  String? role;
  String? gender;
  bool? emailVerified;
  String? fcmtoken;
  String? updatedAt;
  String? photo;
  String? googleId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['role'] = role;
    map['gender'] = gender;
    map['emailVerified'] = emailVerified;
    map['fcmtoken'] = fcmtoken;
    map['updatedAt'] = updatedAt;
    map['photo'] = photo;
    map['googleId'] = googleId;
    map['id'] = id;
    return map;
  }

}

/// _id : "692abf2452caf2f56ba7580d"
/// user : {"_id":"69174062c824bbdb62ac1cf1","name":"Hassan Mohamed","email":"hassanmohed590@gmail.com","phone":"01012346666","role":"admin","gender":"male","emailVerified":true,"fcmtoken":"cv85w8VyQuODknhSJqnqJU:APA91bGJo1bEKDz0mwtf1waeX-1LxD8SdhDFaueRurPE-ayolj0mtdi9E6FVXlBPuPth42hSBHFovns_npa3j_LsCSTQNXQMpzdudOqPB_S78qYQaQmV82o","updatedAt":"2025-11-28T15:57:12.139Z","photo":"https://res.cloudinary.com/diubywm4o/image/upload/v1764325746/users/fslpwszu0j5palglf1rz.jpg","googleId":"101223657150379655931","id":"69174062c824bbdb62ac1cf1"}
/// book : {"_id":"69296d87396b30a88ff2f461","name":"قصص","categoryId":"691c8f54b4adb1589feb5265","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1766002091/books/ccbplwbrtiy8payhukg1.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1766002092/books/gallery/mw3bvquu98xvjttfbakv.png","https://res.cloudinary.com/diubywm4o/image/upload/v1766002093/books/gallery/hlpcl4m4cpghfmmdae9k.jpg"],"numberOfCopies":10,"numberInStock":9,"borrowedBy":1,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-28T09:38:15.743Z","updatedAt":"2025-12-17T20:08:13.484Z","__v":1}
/// borrowDate : "2025-11-29"
/// borrowTime : "09:38"
/// mustReturnDate : "2025-12-06"
/// status : "on_borrow"

class BorrowedBooks {
  BorrowedBooks({
      this.id, 
      this.user, 
      this.book, 
      this.borrowDate, 
      this.borrowTime, 
      this.mustReturnDate, 
      this.status,});

  BorrowedBooks.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    book = json['book'] != null ? Book.fromJson(json['book']) : null;
    borrowDate = json['borrowDate'];
    borrowTime = json['borrowTime'];
    mustReturnDate = json['mustReturnDate'];
    status = json['status'];
  }
  String? id;
  User? user;
  Book? book;
  String? borrowDate;
  String? borrowTime;
  String? mustReturnDate;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (book != null) {
      map['book'] = book?.toJson();
    }
    map['borrowDate'] = borrowDate;
    map['borrowTime'] = borrowTime;
    map['mustReturnDate'] = mustReturnDate;
    map['status'] = status;
    return map;
  }

}

/// _id : "69296d87396b30a88ff2f461"
/// name : "قصص"
/// categoryId : "691c8f54b4adb1589feb5265"
/// mainImage : "https://res.cloudinary.com/diubywm4o/image/upload/v1766002091/books/ccbplwbrtiy8payhukg1.png"
/// gallery : ["https://res.cloudinary.com/diubywm4o/image/upload/v1766002092/books/gallery/mw3bvquu98xvjttfbakv.png","https://res.cloudinary.com/diubywm4o/image/upload/v1766002093/books/gallery/hlpcl4m4cpghfmmdae9k.jpg"]
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
/// createdAt : "2025-11-28T09:38:15.743Z"
/// updatedAt : "2025-12-17T20:08:13.484Z"
/// __v : 1

