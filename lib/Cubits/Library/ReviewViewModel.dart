


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/Responses/BookReviewResponse.dart';
import '../../Repositories/BookRepository.dart';
import '../States/States.dart';

class ReviewCubit extends Cubit<States> {
  final AddBookRepository repository;

  ReviewCubit(this.repository) : super(InitialState());
  List<Reviews> review = [];



  Future<void> getBookReview(String bookId, {bool showLoading = true}) async {
    if (showLoading) {
      emit(LoadingState(loadingMessage: 'Loading...'));
    }

    var either = await repository.getBookReview(bookId);

    either.fold(
          (l) => emit(ErrorState(errorMessage: l.error?.message)),
          (success) {
        review = success.data?.reviews ?? [];
        emit(GetReviewSuccessState(review: review));
      },
    );
  }

  Future<void> deleteReview(String reviewId) async {
    emit(LoadingState(loadingMessage: 'Loading...'));

    final either = await repository.deleteReview(reviewId);

    await either.fold(
          (failure) {
        emit(ErrorState(errorMessage: failure.error?.message ?? "try again later!"));
      },
          (response) async {
        emit(DeleteReviewSuccessState(response: response));

      },
    );
  }



}




