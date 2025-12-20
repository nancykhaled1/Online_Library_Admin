import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_library_management/Models/Requests/AddNotificationRequest.dart';

import '../../Models/Responses/AddNotificationResponse.dart';
import '../../Models/Responses/GetNotificationResponse.dart';
import '../../Models/Responses/LoginError.dart';
import '../../Repositories/GetNotificationRepository.dart';
import '../States/States.dart';

class NotificationScreenViewModel extends Cubit<States> {
  final GetNotificationRepository getNotificationRepository;
  NotificationScreenViewModel( this.getNotificationRepository)
      : super(InitialState());

  List<Notifications> notifications = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();



  void getNotification() async {
    emit(LoadingState(loadingMessage: 'Loading...'));
    var either = await getNotificationRepository.getNotification();
    either.fold(
          (l) {
        emit(ErrorState(errorMessage: l.error?.message));
      },

          (response) {
        notifications = response.data?.notifications ?? [];
        emit(GetNotificationSuccessState(notifications: notifications));
      },

    );
  }

  void getNotificationDetails(String notificationId) async {
    emit(LoadingState(loadingMessage: 'Loading...')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await getNotificationRepository.getNotificationById(notificationId);
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
          emit(NotificationDetailsSuccessState(notificationDetails: success.data!));
        }

    );
  }

  Future<void> deleteNotification(String notificationId) async {
    emit(LoadingState(loadingMessage: 'Loading...'));

    final either = await getNotificationRepository.deleteNotification(notificationId);

    await either.fold(
          (failure) {
        emit(ErrorState(errorMessage: failure.error?.message ?? "try again later!"));
      },
          (response) async {
        emit(DeleteNotificationSuccessState(response: response));
        getNotification();

      },
    );
  }

  Future<void> addNotification() async {

    emit(LoadingState(loadingMessage: "Loading..."));

    final request = AddNotificationRequest(
      title: titleController.text,
      body: bodyController.text,
    );

    Either<LoginError, AddNotificationResponse> response =
    await getNotificationRepository.addNotification(request);

    response.fold(
          (error) {
        emit(ErrorState(errorMessage: error.error!.message));
      },
          (data) async {

        emit(AddNotificationSuccessState(response: data));
        getNotification();

          },
    );

  }
  void clearForm() {
    titleController.clear();
    bodyController.clear();

    emit(InitialState());
  }

}
