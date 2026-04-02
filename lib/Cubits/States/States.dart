



import 'package:online_library_management/Models/Responses/BorrowedReturnedResponse.dart';
import 'package:online_library_management/Models/Responses/DeleteBookResponse.dart';
import 'package:online_library_management/Models/Responses/DeleteCategoryResponse.dart';
import 'package:online_library_management/Models/Responses/DeleteNotificationResponse.dart';
import 'package:online_library_management/Models/Responses/DeleteReviewResponse.dart';
import 'package:online_library_management/Models/Responses/ScanReturnResponse.dart';

import '../../Models/Responses/AddBookResponse.dart';
import '../../Models/Responses/AddNotificationResponse.dart';
import '../../Models/Responses/AllBooksResponse.dart';
import '../../Models/Responses/AllCategoriesResponse.dart';
import '../../Models/Responses/BookByIdResponse.dart';
import '../../Models/Responses/BookReviewResponse.dart';
import '../../Models/Responses/BooksByCategoryIdResponse.dart';
import '../../Models/Responses/CategoryByIdResponse.dart';
import '../../Models/Responses/GetNotificationResponse.dart';
import '../../Models/Responses/LoginResponse.dart';
import '../../Models/Responses/NotificationDetailsResponse.dart';
import '../../Models/Responses/ParentCategoryResponse.dart';
import '../../Models/Responses/ScanBorrowedResponse.dart';
import '../../Models/Responses/UpdateBookResponse.dart';

abstract class States{}

class InitialState extends States{}

class LoadingState extends States{
  String? loadingMessage;
  LoadingState({required this.loadingMessage});
}


class BookLoadingState extends States{
  String? loadingMessage;
  BookLoadingState({required this.loadingMessage});
}




class ErrorState extends States{
  String? errorMessage;
  ErrorState({required this.errorMessage});
}


class ButtonErrorState extends States{
  String? errorMessage;
  ButtonErrorState({required this.errorMessage});
}



class LoginSuccessState extends States {
  final LoginResponse response;

  LoginSuccessState({required this.response});
}

class AddCategorySuccessState extends States {
  final ParentCategory category;

  AddCategorySuccessState({required this.category});
}



class HomeDataSuccessState extends States {
  final List<Categories> categories;
  final List<Parents> parents;
  final List<Books> books;

  HomeDataSuccessState(this.categories,  this.parents , this.books);
}

class CategoryByIdSuccessState extends States {
  final List<Children> children;

  CategoryByIdSuccessState({required this.children});
}

class DeleteCategorySuccessState extends States {
  final DeleteCategoryResponse response;

  DeleteCategorySuccessState({required this.response});
}

class BookByCategoryIdSuccessState extends States {
  final List<BooksByCategoryId> book;

  BookByCategoryIdSuccessState({required this.book});
}


class BookDetailsSuccessState extends States {
  final BookById book;

  BookDetailsSuccessState({required this.book});
}

class AddBookSuccessState extends States {
  final AddBookResponse book;

  AddBookSuccessState({required this.book});
}

class MainImagePickedSuccessState extends States {
  final String imageUrl;
  MainImagePickedSuccessState(this.imageUrl);
}
class GalleryImagesPickedSuccessState extends States {
  final List<String> imageUrl;
  GalleryImagesPickedSuccessState(this.imageUrl);
}

class MainImageClearedState extends States {}
class BookFormClearedState extends States {}


class EditBookSuccessState extends States {
  final UpdateBook book;

  EditBookSuccessState({required this.book});
}

class DeleteBookSuccessState extends States {
  final DeleteBookResponse response;

  DeleteBookSuccessState({required this.response});
}


class GetReviewSuccessState extends States {
  final List<Reviews> review;

  GetReviewSuccessState({required this.review});
}

class DeleteReviewSuccessState extends States {
  final DeleteReviewResponse response;

  DeleteReviewSuccessState({required this.response});
}

class GetNotificationSuccessState extends States {
  final List<Notifications> notifications;

  GetNotificationSuccessState({required this.notifications});
}

class NotificationDetailsSuccessState extends States {
  final DataDetails notificationDetails;

  NotificationDetailsSuccessState({required this.notificationDetails});
}

class DeleteNotificationSuccessState extends States {
  final DeleteNotificationResponse response;

  DeleteNotificationSuccessState({required this.response});
}

class AddNotificationSuccessState extends States {
  final AddNotificationResponse response;

  AddNotificationSuccessState({required this.response});
}

class GetBorrowBooksSuccessState extends States {
  final List<BorrowedBooks> borrow;
  final List<ReturnedBooks> returned;
  final List<PendingBooks> pending;
  final List<LateBooks> late;



  GetBorrowBooksSuccessState({required this.borrow,required this.returned,required this.pending,required this.late});
}

class ScanBorrowSuccessState extends States {
  final Borrow borrow;
  ScanBorrowSuccessState({required this.borrow});
}

class ScanReturnSuccessState extends States {
  final Return returned;
  ScanReturnSuccessState({required this.returned});
}
class SummarySuccessState extends States {
  final Summary summary;
  SummarySuccessState({required this.summary});
}

// class SaveBookSuccessState extends States {
//   final SaveBookResponse response;
//
//   SaveBookSuccessState({required this.response});
// }
//
//
// class AllSaveBookSuccessState extends States {
//   final List<Favorites> favorite;
//
//   AllSaveBookSuccessState({required this.favorite});
// }
//
//
// class RemoveSavedBookSuccessState extends States {
//   final RemoveData removeData;
//
//   RemoveSavedBookSuccessState({required this.removeData});
// }
//
// class SearchBooksSuccessState extends States {
//   final List<SearchBooks> search;
//
//   SearchBooksSuccessState({required this.search});
// }
//
// class BorrowBooksSuccessState extends States {
//   final BorrowData borrowData;
//
//   BorrowBooksSuccessState({required this.borrowData});
// }
//

//
//
//
// class ReturnBooksSuccessState extends States {
//   final ReturnData returnData;
//
//   ReturnBooksSuccessState({required this.returnData});
// }
//
//
// class ProfileSuccessState extends States {
//   final ProfileUser user;
//
//   ProfileSuccessState({required this.user});
// }
//
//
// class UpdateProfileSuccessState extends States {
//   final ProfileUser user;
//
//   UpdateProfileSuccessState({required this.user});
// }
//
// class UploadImageSuccessState extends States {
//   final String imageUrl;
//   UploadImageSuccessState(this.imageUrl);
// }
//
// class ChangeEditState extends States {}
//
// class DeleteProfileSuccessState extends States {
//   final DeleteProfileResponse response;
//   DeleteProfileSuccessState(this.response);
// }
//
// class NotificationSuccessState extends States {
//   final NotificationResponse response;
//
//   NotificationSuccessState({required this.response});
// }
//

//
// class CounterSuccessState extends States {
//   final CounterData counterData;
//
//   CounterSuccessState({required this.counterData});
// }

