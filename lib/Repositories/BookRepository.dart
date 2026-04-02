import 'package:dartz/dartz.dart';
import 'package:online_library_management/Models/Requests/AddBookRequest.dart';
import 'package:online_library_management/Models/Requests/UpdateBookRequest.dart';
import 'package:online_library_management/Models/Responses/AddBookResponse.dart';
import 'package:online_library_management/Models/Responses/DeleteBookResponse.dart';
import 'package:online_library_management/Models/Responses/DeleteReviewResponse.dart';
import 'package:online_library_management/Models/Responses/UpdateBookResponse.dart';
import 'package:online_library_management/Sources/BookDataSource.dart';

import '../Models/Responses/BookByIdResponse.dart';
import '../Models/Responses/BookReviewResponse.dart';
import '../Models/Responses/LoginError.dart';

class AddBookRepository {
  final AddBookRemoteDataSource remoteDataSource;

  AddBookRepository(this.remoteDataSource);

  Future<Either<LoginError, AddBookResponse>> addBook(AddBookRequest request) {
    return remoteDataSource.addBook(request);
  }

  Future<Either<LoginError, BookByIdResponse>> getBookById(String bookId) {
    return remoteDataSource.getBookBId(bookId);
  }

  Future<Either<LoginError, UpdateBookResponse>> editBook(
      UpdateBookRequest request,String bookId) {
    return remoteDataSource.editBook(request, bookId);
  }

  Future<Either<LoginError, DeleteBookResponse>> deleteBook(String bookId) {
    return remoteDataSource.deleteBook(bookId);
  }

  Future<Either<LoginError, BookReviewResponse>> getBookReview(String bookId) {
    return remoteDataSource.getBookReview(bookId);
  }

  Future<Either<LoginError, DeleteReviewResponse>> deleteReview(String reviewId) {
    return remoteDataSource.deleteReview(reviewId);
  }

}