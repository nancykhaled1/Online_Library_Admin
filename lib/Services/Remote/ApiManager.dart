import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:online_library_management/Models/Requests/AddBookRequest.dart';
import 'package:online_library_management/Models/Requests/CategoryRequest.dart';
import 'package:online_library_management/Models/Requests/ParentCategoryRequest.dart';
import 'package:online_library_management/Models/Responses/AddBookResponse.dart';
import 'package:online_library_management/Models/Responses/DeleteBookResponse.dart';
import 'package:online_library_management/Models/Responses/DeleteCategoryResponse.dart';
import 'package:online_library_management/Models/Responses/DeleteNotificationResponse.dart';
import 'package:online_library_management/Models/Responses/ParentCategoryResponse.dart';

import '../../Models/Requests/LoginRequest.dart';
import '../../Models/Requests/UpdateBookRequest.dart';
import '../../Models/Responses/AllCategoriesResponse.dart';
import '../../Models/Responses/BookByIdResponse.dart';
import '../../Models/Responses/BookReviewResponse.dart';
import '../../Models/Responses/BooksByCategoryIdResponse.dart';
import '../../Models/Responses/CategoryByIdResponse.dart';
import '../../Models/Responses/GetNotificationResponse.dart';
import '../../Models/Responses/LoginError.dart';
import '../../Models/Responses/LoginResponse.dart';
import '../../Models/Responses/NotificationDetailsResponse.dart';
import '../../Models/Responses/UpdateBookResponse.dart';
import '../Local/SharedPreference.dart';
import 'ApiConstants.dart';

class ApiManager{

  Future<Either<LoginError, LoginResponse>> login(
      String email,
      String password,
      ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.LoginApi);

        var requestBody = LoginRequest(
          email: email ?? '',
          password: password ?? '',
        );

        print('Sending request to: $url');
        print('Request body: ${requestBody.toJson()}');

        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
            requestBody.toJson(),
          ), // تأكد toJson يرجع Map<String, dynamic>
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var registerResponse = LoginResponse.fromJson(jsonResponse);
          return right(registerResponse);
        } else {
          // أخطاء السيرفر
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 0,
              message: "No Internet Connection",
            ),
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(code: -1, message: "Unexpected Error"),
        ),
      );
    }
  }


  Future<Either<LoginError, ParentCategoryResponse>> addParentCategory(ParentCategoryRequest request) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.getCategories);

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },
        body: jsonEncode(request.toJson()), // ⬅ هنا

      );


      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var categoryResponse = ParentCategoryResponse.fromJson(jsonResponse);
        return right(categoryResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, ParentCategoryResponse>> addCategory(CategoryRequest request) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.getCategories);

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },
        body: jsonEncode(request.toJson()), // ⬅ هنا

      );


      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var categoryResponse = ParentCategoryResponse.fromJson(jsonResponse);
        return right(categoryResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }


  Future<Either<LoginError, AllCategoriesResponse>> getAllCategories() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.getCategories);

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        /// هنا بعمل parse للـ object كله
        var levelResponse = AllCategoriesResponse.fromJson(jsonResponse);

        return right(levelResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
            // details: "Please check your connection and try again.",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, CategoryByIdResponse>> getCategoryByID(String parentId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/admin/categories/$parentId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",
        },
      );

      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var categoryByIdResponse = CategoryByIdResponse.fromJson(jsonResponse);
        return right(categoryByIdResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, DeleteCategoryResponse>> deleteCategory(String categoryId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/admin/categories/$categoryId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.delete(
        url,
        headers: {
          "Authorization": "Bearer $savedToken",
          "Content-Type": "application/json",
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        /// هنا بعمل parse للـ object كله
        var deleteCategoryResponse = DeleteCategoryResponse.fromJson(jsonResponse);

        return right(deleteCategoryResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }
  Future<Either<LoginError, ParentCategoryResponse>> editParentCategory(ParentCategoryRequest request , String parentId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/admin/categories/$parentId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },
        body: jsonEncode(request.toJson()), // ⬅ هنا

      );


      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var categoryResponse = ParentCategoryResponse.fromJson(jsonResponse);
        return right(categoryResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }
  Future<Either<LoginError, ParentCategoryResponse>> editCategory(CategoryRequest request , String categoryId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/admin/categories/$categoryId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },
        body: jsonEncode(request.toJson()), // ⬅ هنا

      );


      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var categoryResponse = ParentCategoryResponse.fromJson(jsonResponse);
        return right(categoryResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, BooksByCategoryIdResponse>> getBookByCategoryID(String categoryId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/admin/categories/$categoryId/books");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",
        },
      );

      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var bookResponse = BooksByCategoryIdResponse.fromJson(jsonResponse);
        return right(bookResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, AddBookResponse>> addBook(AddBookRequest request) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.addBookApi);

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },
        body: jsonEncode(request.toJson()), // ⬅ هنا

      );


      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var addBookResponse = AddBookResponse.fromJson(jsonResponse);
        return right(addBookResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, BookByIdResponse>> getBookByID(String bookId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/admin/books/$bookId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $savedToken",
          "Content-Type": "application/json",
        },
      );

      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var bookResponse = BookByIdResponse.fromJson(jsonResponse);
        return right(bookResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, UpdateBookResponse>> editBook(UpdateBookRequest request,String bookId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/admin/books/$bookId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },
        body: jsonEncode(request.toJson()), // ⬅ هنا

      );


      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var bookResponse = UpdateBookResponse.fromJson(jsonResponse);
        return right(bookResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, DeleteBookResponse>> deleteBook(String bookId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/admin/books/$bookId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.delete(
        url,
        headers: {
          "Authorization": "Bearer $savedToken",
          "Content-Type": "application/json",
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        /// هنا بعمل parse للـ object كله
        var deleteBookResponse = DeleteBookResponse.fromJson(jsonResponse);

        return right(deleteBookResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, BookReviewResponse>> getBookReview(String bookId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/admin/book-reviews/$bookId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",
        },
      );

      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var bookReviewResponse = BookReviewResponse.fromJson(jsonResponse);
        return right(bookReviewResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }


  Future<Either<LoginError, GetNotificationResponse>> getNotification() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.getNotificationApi);

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $savedToken",
          "Content-Type": "application/json",
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        /// هنا بعمل parse للـ object كله
        var getNotificationResponse = GetNotificationResponse.fromJson(jsonResponse);

        return right(getNotificationResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, NotificationDetailsResponse>> getNotificationByID(String notificationId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/admin/notification/$notificationId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $savedToken",
          "Content-Type": "application/json",
        },
      );

      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var NotificationResponse = NotificationDetailsResponse.fromJson(jsonResponse);
        return right(NotificationResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, DeleteNotificationResponse>> deleteNotification(String notificationId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/admin/notification/$notificationId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.delete(
        url,
        headers: {
          "Authorization": "Bearer $savedToken",
          "Content-Type": "application/json",
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        /// هنا بعمل parse للـ object كله
        var deleteNotificationResponse = DeleteNotificationResponse.fromJson(jsonResponse);

        return right(deleteNotificationResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }




}