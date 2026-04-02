import 'package:dartz/dartz.dart';
import 'package:online_library_management/Models/Requests/AddBookRequest.dart';
import 'package:online_library_management/Models/Requests/UpdateBookRequest.dart';
import 'package:online_library_management/Models/Responses/AddBookResponse.dart';
import 'package:online_library_management/Models/Responses/DeleteBookResponse.dart';
import 'package:online_library_management/Models/Responses/DeleteReviewResponse.dart';
import 'package:online_library_management/Models/Responses/UpdateBookResponse.dart';
import '../Models/Responses/BookByIdResponse.dart';
import '../Models/Responses/BookReviewResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Services/Remote/ApiManager.dart';


class AddBookRemoteDataSource {
  final ApiManager apiManager;

  AddBookRemoteDataSource(this.apiManager);

  Future<Either<LoginError, AddBookResponse>> addBook(
      AddBookRequest request) {
    return apiManager.addBook(request);
  }

  Future<Either<LoginError, BookByIdResponse>> getBookBId(String bookId) {
    return apiManager.getBookByID(bookId);
  }

  Future<Either<LoginError, UpdateBookResponse>> editBook(
      UpdateBookRequest request , String bookId) {
    return apiManager.editBook(request, bookId);
  }

  Future<Either<LoginError, DeleteBookResponse>> deleteBook(String bookId) {
    return apiManager.deleteBook(bookId);
  }

  Future<Either<LoginError, BookReviewResponse>> getBookReview(String bookId) {
    return apiManager.getBookReview(bookId);
  }

  Future<Either<LoginError, DeleteReviewResponse>> deleteReview(String reviewId) {
    return apiManager.deleteReview(reviewId);
  }

}

