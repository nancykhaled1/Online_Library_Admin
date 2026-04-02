import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Models/Responses/BorrowedReturnedResponse.dart';
import '../../Repositories/BorrowRepository.dart';
import '../States/States.dart';

class BorrowCubit extends Cubit<States> {
  final BorrowRepository repository;

  BorrowCubit(this.repository) : super(InitialState());


  List<BorrowedBooks> borrowedBook = [];
  List<ReturnedBooks> returnedBook = [];
  List<PendingBooks> pendingBook = [];
  List<LateBooks> lateBook = [];



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
          lateBook = success.data?.lateBooks ??[];
          pendingBook = success.data?.pendingBooks ??[];

          emit(GetBorrowBooksSuccessState(borrow: borrowedBook, returned: returnedBook, pending: pendingBook, late: lateBook));
        }
    );
  }


  Future<void> scanBorrowedBook(String borrowId) async {
    emit(LoadingState(loadingMessage: 'Loading...'));

    final either = await repository.scanBook(borrowId);

    either.fold(
          (l) {
            emit(ErrorState(errorMessage: l.error?.message));
      },
          (success) {
        final borrow = success.data?.borrow;
        if (borrow == null) {
            print("Borrow ID is null");

          emit(
            ErrorState(errorMessage: 'No borrow data found'),
          );
          return;
        }
        emit(
          ScanBorrowSuccessState(borrow: borrow),
        );
      },
    );
  }


  Future<void> scanReturnedBook(String borrowId) async {
    emit(LoadingState(loadingMessage: 'Loading...'));

    final either = await repository.scanReturn(borrowId);

    either.fold(
          (l) {
        emit(ErrorState(errorMessage: l.error?.message));
      },
          (success) {
        final returned = success.data?.borrow;
        if (returned == null) {
          print("returned ID is null");

          emit(
            ErrorState(errorMessage: 'No returned data found'),
          );
          return;
        }
        emit(
          ScanReturnSuccessState(returned: returned),
        );
      },
    );
  }






}
