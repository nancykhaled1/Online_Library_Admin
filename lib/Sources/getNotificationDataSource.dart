
import 'package:dartz/dartz.dart';
import 'package:online_library_management/Models/Requests/AddNotificationRequest.dart';
import 'package:online_library_management/Models/Responses/DeleteNotificationResponse.dart';

import '../Models/Responses/AddNotificationResponse.dart';
import '../Models/Responses/GetNotificationResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/NotificationDetailsResponse.dart';
import '../Services/Remote/ApiManager.dart';

class GetNotificationRemoteDataSource {
  final ApiManager apiManager;

  GetNotificationRemoteDataSource(this.apiManager);

  Future<Either<LoginError, GetNotificationResponse>> getNotification() {
    return apiManager.getNotification();
  }

  Future<Either<LoginError, NotificationDetailsResponse>> getNotificationDetails(String notificationId) {
    return apiManager.getNotificationByID(notificationId);
  }

  Future<Either<LoginError, DeleteNotificationResponse>> deleteNotification(String notificationId) {
    return apiManager.deleteNotification(notificationId);
  }

  Future<Either<LoginError, AddNotificationResponse>> addNotification(AddNotificationRequest request) {
    return apiManager.addNotification(request.title!,request.body!);
  }
}