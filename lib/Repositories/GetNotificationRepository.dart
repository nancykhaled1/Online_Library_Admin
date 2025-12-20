

import 'package:dartz/dartz.dart';
import 'package:online_library_management/Models/Responses/DeleteNotificationResponse.dart';

import '../Models/Requests/AddNotificationRequest.dart';
import '../Models/Responses/AddNotificationResponse.dart';
import '../Models/Responses/GetNotificationResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/NotificationDetailsResponse.dart';
import '../Sources/getNotificationDataSource.dart';

class GetNotificationRepository {
  final GetNotificationRemoteDataSource remoteDataSource;

  GetNotificationRepository(this.remoteDataSource);

  Future<Either<LoginError, GetNotificationResponse>> getNotification() {
    return remoteDataSource.getNotification();
  }

  Future<Either<LoginError, NotificationDetailsResponse>> getNotificationById(String notificationId) {
    return remoteDataSource.getNotificationDetails(notificationId);
  }

  Future<Either<LoginError, DeleteNotificationResponse>> deleteNotification(String notificationId) {
    return remoteDataSource.deleteNotification(notificationId);
  }

  Future<Either<LoginError, AddNotificationResponse>> addNotification(AddNotificationRequest request) {
    return remoteDataSource.addNotification(request);
  }


}

