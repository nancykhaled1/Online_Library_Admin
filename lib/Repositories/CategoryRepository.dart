import 'package:dartz/dartz.dart';
import 'package:online_library_management/Models/Requests/ParentCategoryRequest.dart';
import 'package:online_library_management/Models/Responses/DeleteCategoryResponse.dart';
import 'package:online_library_management/Models/Responses/ParentCategoryResponse.dart';
import 'package:online_library_management/Sources/CategoriesDataSource.dart';

import '../Models/Requests/CategoryRequest.dart';
import '../Models/Responses/AllCategoriesResponse.dart';
import '../Models/Responses/BooksByCategoryIdResponse.dart';
import '../Models/Responses/CategoryByIdResponse.dart';
import '../Models/Responses/LoginError.dart';

class CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepository(this.remoteDataSource);

  Future<Either<LoginError, ParentCategoryResponse>> addParentCategory(
      ParentCategoryRequest request) {
    return remoteDataSource.addParentCategory(request);
  }

  Future<Either<LoginError, ParentCategoryResponse>> addCategory(
      CategoryRequest request) {
    return remoteDataSource.addCategory(request);
  }

  Future<Either<LoginError, AllCategoriesResponse>> getAllCategories() {
    return remoteDataSource.getAllCategories();
  }

  Future<Either<LoginError, CategoryByIdResponse>> getCategoryById(String parentId) {
    return remoteDataSource.getCategoryById(parentId);
  }

  Future<Either<LoginError, DeleteCategoryResponse>> deleteCategory(String categoryId) {
    return remoteDataSource.deleteCategory(categoryId);
  }

  Future<Either<LoginError, ParentCategoryResponse>> editParentCategory(
      ParentCategoryRequest request,String parentId) {
    return remoteDataSource.editParentCategory(request,parentId);
  }

  Future<Either<LoginError, ParentCategoryResponse>> editCategory(
      CategoryRequest request,String categoryId) {
    return remoteDataSource.editCategory(request,categoryId);
  }

  Future<Either<LoginError, BooksByCategoryIdResponse>> getBookByCategoryId(String categoryId) {
    return remoteDataSource.getBookByCategoryId(categoryId);
  }
}