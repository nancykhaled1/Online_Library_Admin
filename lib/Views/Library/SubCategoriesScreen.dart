import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_library_management/Utils/MyColors.dart';
import 'package:online_library_management/Views/Library/BooksScreen.dart';
import 'package:online_library_management/Views/Library/LibraryScreen.dart';
import '../../Cubits/Library/CategoryViewModel.dart';
import '../../Cubits/States/States.dart';
import '../../Models/Requests/CategoryRequest.dart';
import '../../Utils/CommenConfirmSheet.dart';
import '../../Utils/dialog.dart';
import 'EditBottomSheet.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = 'category';
  final String ParentId;
  final String name;

  const CategoryScreen({super.key, required this.ParentId, required this.name});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategoryById(widget.ParentId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.whiteColor,
          appBar: AppBar(
            backgroundColor: MyColors.whiteColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text(
              'Novel',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: MyColors.blackColor,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        LibraryScreen(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),

          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manage your sub categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: MyColors.blackColor,
                  ),
                ),
                SizedBox(height: 20.h),

                BlocListener<CategoryCubit, States>(
                  listener: (context, state) {
                    if (state is ErrorState) {
                      showOverlayMessage(
                        context,
                        state.errorMessage ?? "Something went wrong",
                        isError: true,
                      );
                    }
                  },
                  child: BlocBuilder<CategoryCubit, States>(
                    builder: (context, state) {
                      final cubit = context.read<CategoryCubit>();
                      final category = cubit.children;

                      if (state is LoadingState) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (category.isEmpty) {
                        return Center(
                          child: Text(
                            'No category yet!',
                            style: TextStyle(
                              color: MyColors.greyColor,
                              fontSize: 16.sp,
                            ),
                          ),
                        );
                      }

                      return Expanded(
                        child: ListView.separated(
                          itemCount: category.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.h),
                          itemBuilder: (context, index) {
                            final item = category[index];

                            return GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => BookScreen(name: item.name??'Category',),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.r),
                                  border: Border.all(color: MyColors.outColor),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      item.name ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.edit,
                                          color: MyColors.primaryColor),
                                      onPressed: () {
                                        editBottomSheet(
                                          context: context,
                                          buttonText: 'Edit',
                                          onPressed: (value) {
                                            final request = CategoryRequest(
                                              name: value,
                                              parentId: widget.ParentId,
                                            );
                                            cubit.editCategory(
                                                request, item.id!);
                                          },
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        showCommonBottomSheet(
                                          context: context,
                                          imagePath:
                                          'assets/images/deleteImage.png',
                                          title: 'Delete this category?',
                                          description:
                                          'You sure you want to delete this category!',
                                          primaryButtonText: 'Yes, Delete',
                                          onPrimaryPressed: () async {
                                            Navigator.pop(context);
                                            cubit.deleteChildCategory(
                                                item.id!, widget.ParentId);
                                          },
                                          secondaryButtonText: 'No, Cancel',
                                          onSecondaryPressed: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              editBottomSheet(
                context: context,
                buttonText: 'Add',
                onPressed: (value) {
                  final request = CategoryRequest(
                    name: value,
                    parentId: widget.ParentId,
                  );
                  context.read<CategoryCubit>().addCategory(request);
                },
              );
            },
            backgroundColor: MyColors.primaryColor,
            child: Icon(Icons.add, color: MyColors.whiteColor, size: 30.sp),
          ),
        ),
      ),
    );
  }
}
