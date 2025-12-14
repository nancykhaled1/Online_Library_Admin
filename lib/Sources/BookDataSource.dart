import 'package:dartz/dartz.dart';
import 'package:online_library_management/Models/Requests/AddBookRequest.dart';
import 'package:online_library_management/Models/Responses/AddBookResponse.dart';

import '../Models/Responses/LoginError.dart';
import '../Services/Remote/ApiManager.dart';

class AddBookRemoteDataSource {
  final ApiManager apiManager;

  AddBookRemoteDataSource(this.apiManager);

  Future<Either<LoginError, AddBookResponse>> addBook(
      AddBookRequest request) {
    return apiManager.addBook(request);
  }

}