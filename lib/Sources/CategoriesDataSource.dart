import 'package:dartz/dartz.dart';
import 'package:online_library_management/Models/Requests/ParentCategoryRequest.dart';
import 'package:online_library_management/Models/Responses/DeleteCategoryResponse.dart';
import 'package:online_library_management/Models/Responses/ParentCategoryResponse.dart';
import '../Models/Requests/CategoryRequest.dart';
import '../Models/Responses/AllBooksResponse.dart';
import '../Models/Responses/AllCategoriesResponse.dart';
import '../Models/Responses/BooksByCategoryIdResponse.dart';
import '../Models/Responses/CategoryByIdResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Services/Remote/ApiManager.dart';

class CategoryRemoteDataSource {
  final ApiManager apiManager;

  CategoryRemoteDataSource(this.apiManager);

  Future<Either<LoginError, ParentCategoryResponse>> addParentCategory(
      ParentCategoryRequest request) {
    return apiManager.addParentCategory(request);
  }
  Future<Either<LoginError, ParentCategoryResponse>> addCategory(
      CategoryRequest request) {
    return apiManager.addCategory(request);
  }

  Future<Either<LoginError, AllCategoriesResponse>> getAllCategories() {
    return apiManager.getAllCategories();
  }

  Future<Either<LoginError, CategoryByIdResponse>> getCategoryById(String parentId) {
    return apiManager.getCategoryByID(parentId);
  }

  Future<Either<LoginError, DeleteCategoryResponse>> deleteCategory(String categoryId) {
    return apiManager.deleteCategory(categoryId);
  }

  Future<Either<LoginError, ParentCategoryResponse>> editParentCategory(
      ParentCategoryRequest request , String parentId) {
    return apiManager.editParentCategory(request, parentId);
  }

  Future<Either<LoginError, ParentCategoryResponse>> editCategory(
      CategoryRequest request , String categoryId) {
    return apiManager.editCategory(request, categoryId);
  }

  Future<Either<LoginError, BooksByCategoryIdResponse>> getBookByCategoryId(String categoryId) {
    return apiManager.getBookByCategoryID(categoryId);
  }
  Future<Either<LoginError, AllBooksResponse>> getAllBooks() {
    return apiManager.getAllBooks();
  }

}