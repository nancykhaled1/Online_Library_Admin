import 'package:dartz/dartz.dart';
import 'package:online_library_management/Models/Responses/ScanBorrowedResponse.dart';
import 'package:online_library_management/Models/Responses/ScanReturnResponse.dart';
import '../Models/Responses/BorrowedReturnedResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Services/Remote/ApiManager.dart';

class BorrowRemoteDataSource {
  final ApiManager apiManager;

  BorrowRemoteDataSource(this.apiManager);



  Future<Either<LoginError, BorrowedReturnedResponse>> getBorrowBook() {
    return apiManager.getBorrowBooks();
  }

  Future<Either<LoginError, ScanBorrowedResponse>> scanBook(String borrowId) {
    return apiManager.scanBook(borrowId);
  }

  Future<Either<LoginError, ScanReturnResponse>> scanReturn(String borrowId) {
    return apiManager.scanReturn(borrowId);
  }

}