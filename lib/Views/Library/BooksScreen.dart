import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_library_management/Cubits/Library/BookViewModel.dart';
import 'package:online_library_management/Utils/MyColors.dart';
import 'package:online_library_management/Views/Library/LibraryScreen.dart';
import 'package:online_library_management/Views/Library/SubCategoriesScreen.dart';

import '../../Cubits/States/States.dart';
import '../../Utils/CommenConfirmSheet.dart';
import 'AddBookScreen.dart';
import 'BookDetailsScreen.dart';
import 'EditBottomSheet.dart';

class BookScreen extends StatefulWidget{
  static const routeName = 'book';
  final String name;
  final String categoryId;
  const BookScreen({super.key, required this.name,required this.categoryId});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  void initState() {
    super.initState();

    /// هنا مهم جدًا ننادي API
    context.read<BookCubit>().getBookByCategoryId(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // هنا بتتحكمى هل ترجعى ولا لا
        return false; // ❌ مش هيرجع
        // return true;  ✅ هيرجع
      },
      child: SafeArea(child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        appBar: AppBar(
          backgroundColor: MyColors.whiteColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            'Science',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: MyColors.blackColor
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
               Navigator.of(context).pushReplacementNamed(CategoryScreen.routeName);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 10.w
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage your books',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: MyColors.blackColor
                ),
              ),
              SizedBox(height: 20.h),
              BlocBuilder<BookCubit, States>(
                builder: (context, state) {

                  if (state is LoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }

          if (state is BookByCategoryIdSuccessState) {
            final books = state.book;
            if (books.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/nofound.png', height: 200.h,),
                    SizedBox(width: 5.w,),
                    Text(
                      "No books found in this category",
                      style: TextStyle(
                          color: MyColors.greyColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              );
            }


            return Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: books.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  final book = books[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => BookDetailsScreen(bookId: book.id!,),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(14.r),
                        border: Border.all(
                          color: MyColors.outColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.name ??'',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: MyColors.blackColor),

                              ),
                              SizedBox(height: 4.h),
                              Text(
                                book.publisher ??'',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.greyColor),

                              ),
                            ],
                          ),
                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(12.r),
                            child:  Image.network(book.mainImage ??'assets/images/book.png',
                              height: 50.h,
                              width: 50.w,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset("assets/images/img.png", height: 50.h,);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );

          }
          return Container();
                },
              ),

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AddNewBookScreen(categoryId: widget.categoryId),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
            },
          backgroundColor: MyColors.primaryColor,
          child: Icon(Icons.add, color: MyColors.whiteColor, size: 30.sp),
        ),

      )),
    );
  }
}