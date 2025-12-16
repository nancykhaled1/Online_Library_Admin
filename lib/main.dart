import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_library_management/Cubits/Library/BookViewModel.dart';
import 'package:online_library_management/Cubits/Library/CategoryViewModel.dart';
import 'package:online_library_management/Repositories/BookRepository.dart';
import 'package:online_library_management/Repositories/CategoryRepository.dart';
import 'package:online_library_management/Sources/BookDataSource.dart';
import 'package:online_library_management/Sources/CategoriesDataSource.dart';
import 'Cubits/Auth/LoginScreenViewModel.dart';
import 'Cubits/Library/ReviewViewModel.dart';
import 'Repositories/LoginRepository.dart';
import 'Services/Remote/ApiManager.dart';
import 'Sources/LoginDataSource.dart';
import 'Utils/MyColors.dart';
import 'Views/Auth/LoginScreen.dart';
import 'Views/Home/HomeScreen.dart';
import 'Views/Library/LibraryScreen.dart';
import 'Views/Library/SubCategoriesScreen.dart';





Future<void> main() async {
  final apiManager = ApiManager();
  //login
  final loginRemoteDataSource = LoginRemoteDataSource(apiManager);
  final loginRepository = LoginRepository(loginRemoteDataSource);

  //categories
  final categoryRemoteDataSource = CategoryRemoteDataSource(apiManager);
  final categoryRepository = CategoryRepository(categoryRemoteDataSource);

  final addBookRemoteDataSource = AddBookRemoteDataSource(apiManager);
  final addBookRepository = AddBookRepository(addBookRemoteDataSource);

  runApp(

    MultiRepositoryProvider(
      providers: [


        RepositoryProvider<LoginRepository>(
          create: (context) => loginRepository,
        ),

        RepositoryProvider<CategoryRepository>(
          create: (context) => categoryRepository,
        ),
        RepositoryProvider<AddBookRepository>(
          create: (context) => addBookRepository,
        ),



      ],

      child: MultiBlocProvider(
        providers: [

          BlocProvider(
            create: (context) => LoginScreenCubit(
              context.read<LoginRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => CategoryCubit(
              context.read<CategoryRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => BookCubit(
              context.read<CategoryRepository>(),
                context.read<AddBookRepository>()
            ),
          ),

          BlocProvider(
            create: (context) => ReviewCubit(
                context.read<AddBookRepository>()
            ),
          ),


        ],
        child: const MyApp(),
      ),
    ),


  );
}





class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (_, child) {
        return SafeArea(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primaryColor: MyColors.primaryColor,
                colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primaryColor),

              ),

              initialRoute: LoginScreen.routeName,
              routes: {
                 LoginScreen.routeName : (context) => LoginScreen(),
                LibraryScreen.routeName : (context) => LibraryScreen(),
                CategoryScreen.routeName : (context) => CategoryScreen(),
                // RegisterScreen.routeName : (context) => RegisterScreen(),
                // LibraryHomeScreen.routeName : (context) => LibraryHomeScreen(),
                // MyShelfScreen.routeName : (context) => MyShelfScreen()
              }


          ),
        );
      },
    );
  }
}
