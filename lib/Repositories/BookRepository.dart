import 'package:dartz/dartz.dart';
import 'package:online_library_management/Models/Requests/AddBookRequest.dart';
import 'package:online_library_management/Models/Responses/AddBookResponse.dart';
import 'package:online_library_management/Sources/BookDataSource.dart';

import '../Models/Responses/LoginError.dart';

class AddBookRepository {
  final AddBookRemoteDataSource remoteDataSource;

  AddBookRepository(this.remoteDataSource);

  Future<Either<LoginError, AddBookResponse>> addBook(AddBookRequest request) {
    return remoteDataSource.addBook(request);
  }
}