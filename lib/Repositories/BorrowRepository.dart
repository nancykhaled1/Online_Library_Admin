import 'package:dartz/dartz.dart';
import 'package:online_library_management/Models/Responses/BorrowedReturnedResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Sources/BorrowDataSource.dart';





class BorrowRepository {
  final BorrowRemoteDataSource remoteDataSource;

  BorrowRepository(this.remoteDataSource);


  Future<Either<LoginError, BorrowedReturnedResponse>> getBorrowBook() {
    return remoteDataSource.getBorrowBook();
  }
}