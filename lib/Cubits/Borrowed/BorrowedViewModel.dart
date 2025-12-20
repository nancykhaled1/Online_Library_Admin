import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Models/Responses/BorrowedReturnedResponse.dart';
import '../../Repositories/BorrowRepository.dart';
import '../States/States.dart';

class BorrowCubit extends Cubit<States> {
  final BorrowRepository repository;

  BorrowCubit(this.repository) : super(InitialState());


  List<BorrowedBooks> borrowedBook = [];
  List<ReturnedBooks> returnedBook = [];


  Future<void> getBorrowBooks() async {
    emit(LoadingState(loadingMessage: 'Loading..')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await repository.getBorrowBook();
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
          borrowedBook = success.data?.borrowedBooks ??[];
          returnedBook = success.data?.returnedBooks ??[];
          emit(GetBorrowBooksSuccessState(borrow: borrowedBook, returned: returnedBook));
        }
    );
  }





}
