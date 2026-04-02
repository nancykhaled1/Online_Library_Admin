import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:online_library_management/Utils/MyColors.dart';
import 'package:online_library_management/Views/Library/SubCategoriesScreen.dart';
import 'package:flutter_svg/svg.dart';
import '../../Cubits/Library/CategoryViewModel.dart';
import '../../Cubits/States/States.dart';
import '../../Models/Requests/ParentCategoryRequest.dart';
import '../../Utils/CommenConfirmSheet.dart';
import '../../Utils/dialog.dart';
import '../Drawer/DrawerScreen.dart';
import 'EditBottomSheet.dart';

class LibraryScreen extends StatefulWidget{
  static const routeName = 'library';

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    super.initState();

    // هنا بنعمل تحميل للبيانات

      context.read<CategoryCubit>().loadHomeData();

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
            'Library',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              color: MyColors.blackColor
            ),
          ),
          centerTitle: true,
        ),
        drawer: const AppDrawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 10.w
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage your main categories',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: MyColors.blackColor
                ),
              ),
              SizedBox(height: 20.h),
              BlocListener<CategoryCubit,States>(
                listener: (context, state) {
                  if (state is ErrorState) {
                    showOverlayMessage(
                      context,
                      state.errorMessage ?? "Something went wrong",
                      isError: true,
                    );
                  }
                },
                child: BlocBuilder<CategoryCubit,States>(
                  builder: (context,state){
                    if (state is LoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    else if (state is HomeDataSuccessState) {
                      final parent = state.categories
                          .where((category) => category.parentId == null)
                          .toList();

                      if(parent.isEmpty){

                        return Center(
                          child: Text('no category yet!',
                            style: TextStyle(color: MyColors.greyColor,
                              fontSize: 16.sp,
                            ),),
                        );
                      }


                      return Expanded(
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: parent.length,
                          separatorBuilder: (_, __) =>
                              SizedBox(height: 10.h),
                          itemBuilder: (context, index) {
                            final parentCategory = parent[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => CategoryScreen(ParentId: parentCategory.id!, name: parentCategory.name??'Category',),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              child: Container(
                                //  width: double.infinity,
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(14.r),
                                  border: Border.all(
                                    color: MyColors.outColor,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      parentCategory.name??'',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(onPressed: (){
                                      editBottomSheet(context: context,
                                          buttonText: 'Edit',
                                        onPressed: (value) {
                                          final request = ParentCategoryRequest(
                                            name: value,
                                          );

                                          context.read<CategoryCubit>().editParentCategory(request,parentCategory.id!);

                                        },
                                      );
                                    },
                                        icon: Icon(Icons.edit,color: MyColors.primaryColor,)),
                                    SizedBox(width: 5.w,),
                                    IconButton(onPressed: (){
                                      showCommonBottomSheet(
                                        context: context,
                                        imagePath: 'assets/images/deleteImage.png',
                                        title: 'Delete this category?',
                                        description:
                                        'You sure you want to delete this category!',
                                        primaryButtonText: 'Yes, Delete',
                                        onPrimaryPressed: () async {
                                          Navigator.pop(context); // اقفل الشيت

                                          context.read<CategoryCubit>()
                                              .deleteCategory(parentCategory.id!);
                                        },
                                        secondaryButtonText: 'No, Cancel',
                                        onSecondaryPressed: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                        icon: Icon(Icons.delete,color: Colors.red,))
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    else if (state is ErrorState) {
                      final error = state.errorMessage;

                      if (error == "No Internet Connection") {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/noconnection.svg", // 🖼️ ضيفي صورة عندك
                                width: 200,
                                height: 200,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "No internet connection",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: MyColors.greyColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Noto Kufi Arabic",
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            "Please, Try again later",
                            style: TextStyle(
                              color: MyColors.greyColor,
                              fontSize: 16.sp,
                            ),
                          ),
                        );
                      }

                    }

                    return Container();
                  },
                ),
              ),

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
                onPressed: () {
                  editBottomSheet(context: context,
                    buttonText: 'Add',
                    onPressed: (value) {
                      final request = ParentCategoryRequest(
                        name: value,
                      );

                      context.read<CategoryCubit>().addParentCategory(request);
                    },


                  );
                },
                backgroundColor: MyColors.primaryColor,
                child: Icon(
                  Icons.add, color: MyColors.whiteColor, size: 30.sp,),
              ),

    ))
    );
  }
}