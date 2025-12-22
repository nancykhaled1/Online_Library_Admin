import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_library_management/Models/Responses/ParentCategoryResponse.dart';
import 'package:online_library_management/Repositories/CategoryRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Requests/CategoryRequest.dart';
import '../../Models/Requests/ParentCategoryRequest.dart';
import '../../Models/Responses/AllBooksResponse.dart';
import '../../Models/Responses/AllCategoriesResponse.dart';
import '../../Models/Responses/CategoryByIdResponse.dart';
import '../States/States.dart';

class CategoryCubit extends Cubit<States> {
   final CategoryRepository repository;
   List<Children> children = [];
   // Children? selectedCategory;
   String? selectedCategoryId;
   // Parents? selectedParent;
   List<Parents> parents = [];
   String? selectedParentId;
   List<Books> books = [];



   Parents? get selectedParent =>
       parents.firstWhereOrNull((p) => p.id == selectedParentId);

   Children? get selectedCategory =>
       children.firstWhereOrNull((c) => c.id == selectedCategoryId);



   Map<String, List<Children>> cachedCategories = {}; // parentId → list

  CategoryCubit(this.repository) : super(InitialState());


   Future<void> addParentCategory(ParentCategoryRequest request) async {
     emit(LoadingState(loadingMessage: "Adding category..."));

     try {
       final either = await repository.addParentCategory(request);

       either.fold(
             (l) {
           emit(ErrorState(errorMessage: l.error?.message));
         },
             (response) {
           emit(AddCategorySuccessState(category: response.data!.category!));
           loadHomeData();
         },
       );
     } catch (e) {
       emit(ErrorState(errorMessage: e.toString()));
     }
   }
   Future<void> addCategory(CategoryRequest request) async {
     emit(LoadingState(loadingMessage: "Adding category..."));

     try {
       final either = await repository.addCategory(request);

       either.fold(
             (l) {
           emit(ErrorState(errorMessage: l.error?.message));
         },
             (response) {
           emit(AddCategorySuccessState(category: response.data!.category!));
           getCategoryById(request.parentId!);
         },
       );
     } catch (e) {
       emit(ErrorState(errorMessage: e.toString()));
     }
   }


   Future<void> loadHomeData() async {
     emit(LoadingState(loadingMessage: "Loading..."));

     try {
       // 1) Call categories
       final catEither = await repository.getAllCategories();

       List<Categories> categories = [];
       catEither.fold(
             (l) => emit(ErrorState(errorMessage: l.error?.message)),
             (response) {
           categories = response.data?.categories ?? [];
         },
       );


       catEither.fold(
             (l) => emit(ErrorState(errorMessage: l.error?.message)),
             (response) {
           parents = response.data?.parents ?? [];
         },
       );

      // 2) Call books only if categories loaded successfully
       final booksEither = await repository.getAllBooks();

       booksEither.fold(
             (l) => emit(ErrorState(errorMessage: l.error?.message)),
             (response) {
           books = response.data?.books ?? [];
         },
       );


       // 3) Final emit — DONE
       emit(HomeDataSuccessState(
           categories,
           parents,
           books
       ));

     } catch (e) {
       emit(ErrorState(errorMessage: e.toString()));
     }
   }

   Future<void> getCategoryById(String parentId) async {

     // لو موجودة بالفعل = استخدم الكاش
     if (cachedCategories.containsKey(parentId)) {
       emit(CategoryByIdSuccessState(children: cachedCategories[parentId]!));
       return;
     }
     emit(LoadingState(loadingMessage: 'Loading..')); // ⬅️ عشان يمسح القديم ويعرض loader

     var either = await repository.getCategoryById(parentId);
     either.fold(
             (l) {
           emit(ErrorState(errorMessage: l.error?.message));
         },
             (success) {
           children = success.data?.children ??[];
           emit(CategoryByIdSuccessState(children: children));
         }

     );
   }

   Future<void> deleteCategory(String id) async {

     // 1) احذف من الواجهة فورًا
     removeCategoryInstantly(id);

     // 2) ابعت request من غير Loading
     final either = await repository.deleteCategory(id);

     either.fold(
           (failure) {
         // ❌ رجّعي العنصر تاني لو حصل error (rollback)
         loadHomeData();

         emit(ErrorState(errorMessage: failure.error?.message ?? "Delete failed"));
       },
           (response) {
         emit(DeleteCategorySuccessState(response: response));
         loadHomeData();
       },
     );
   }

   void removeCategoryInstantly(String id) {
     if (state is HomeDataSuccessState) {
       final current = state as HomeDataSuccessState;

       final updatedCategories =
       current.categories.where((cat) => cat.id != id).toList();

       emit(HomeDataSuccessState(
          updatedCategories,
          current.parents,
         current.books
       ));
     }
   }

   Future<void> deleteChildCategory(String id, String parentId) async {
     removeChildInstantly(id);

     final either = await repository.deleteCategory(id);

     either.fold(
           (failure) {
         getCategoryById(parentId); // roll back by refetch
         emit(ErrorState(errorMessage: failure.error?.message));
       },
           (response) {
         emit(DeleteCategorySuccessState(response: response));
         getCategoryById(parentId); // refresh page
       },
     );
   }

   void removeChildInstantly(String id) {
     children.removeWhere((item) => item.id == id);
     emit(CategoryByIdSuccessState(children: children));
   }

   Future<void> editParentCategory(ParentCategoryRequest request , String parentId) async {
     emit(LoadingState(loadingMessage: "Editing category..."));

     try {
       final either = await repository.editParentCategory(request,parentId);

       either.fold(
             (l) {
           emit(ErrorState(errorMessage: l.error?.message));
         },
             (response) {
           emit(AddCategorySuccessState(category: response.data!.category!));
           loadHomeData();
         },
       );
     } catch (e) {
       emit(ErrorState(errorMessage: e.toString()));
     }
   }

   Future<void> editCategory(CategoryRequest request , String categoryId) async {
     emit(LoadingState(loadingMessage: "Editing category..."));

     try {
       final either = await repository.editCategory(request,categoryId);

       either.fold(
             (l) {
           emit(ErrorState(errorMessage: l.error?.message));
         },
             (response) {
           emit(AddCategorySuccessState(category: response.data!.category!));
           loadHomeData();
         },
       );
     } catch (e) {
       emit(ErrorState(errorMessage: e.toString()));
     }
   }


}

extension FirstWhereOrNullExtension<E> on List<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}



