import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_library_management/Cubits/States/States.dart';
import 'package:online_library_management/Models/Responses/UpdateBookResponse.dart';

import '../../Cubits/Library/BookViewModel.dart';
import '../../Models/Responses/BookByIdResponse.dart';
import '../../Utils/MyColors.dart';
import '../../Utils/TextField.dart';
import '../../Utils/dialog.dart';
import 'LibraryScreen.dart';


class EditBookScreen extends StatefulWidget {
  final BookById book;

  const EditBookScreen({super.key, required this.book});

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookCubit>().initEditBook(widget.book);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<BookCubit>();

    return Scaffold(
      backgroundColor:  MyColors.whiteColor,
      appBar: AppBar(
        backgroundColor: MyColors.whiteColor,
        elevation: 0,
        title: Text(
          "Edit Book",
          style: TextStyle(
            fontSize: 18.sp,
            color: MyColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
          //  context.read<BookCubit>().clearForm();

            Navigator.of(context).pushReplacementNamed(LibraryScreen.routeName);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),

      body: BlocConsumer<BookCubit,States>(
        listener: (context, state) async {
          if (state is ErrorState) {
            showOverlayMessage(context, state.errorMessage!, isError: true);

          }
          else if (state is LoginSuccessState) {
            showOverlayMessage(context, state.response.data!.message!, isError: false);
            //context.read<BookCubit>().clearForm();

            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) =>  LibraryScreen(),
            //   ),
            // );

          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// ---------- Main Image ----------
                sectionTitle("Images"),
                _mainImagePicker(cubit),
                SizedBox(height: 16.h),

                /// ---------- Gallery ----------
                _galleryImages(cubit),
                SizedBox(height: 24.h),

                /// ---------- Fields ----------
                sectionTitle("Main Book Information"),
                CustomTextField(
                  label: "Book Name",
                  hintText: "Enter book name",
                  controller: cubit.nameController,
                  validator: (_) => null,
                ),
                SizedBox(height: 10.h),

                CustomTextField(
                  label: "Writer",
                  hintText: "Writer name",
                  controller: cubit.writerController,
                  validator: (_) => null,
                ),
                SizedBox(height: 10.h),

                CustomTextField(
                  label: "Synopsis",
                  hintText: "Write description",
                  controller: cubit.synopsisController,
                  maxLines: 4,
                  validator: (_) => null,
                ),

                SizedBox(height: 20.h),

                // ----------------------------------------------------
                // تفاصيل النشر والمؤلفين
                // ----------------------------------------------------
                sectionTitle("Publishing Information"),

                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: "Copies",
                        hintText: "10",
                        controller: cubit.copiesController,
                        keyboardType: TextInputType.number,
                        validator: (_) => null,
                      ),
                    ),
                    SizedBox(width: 10.w),

                    Expanded(
                      child: CustomTextField(
                        label: "Stock",
                        hintText: "10",
                        controller: cubit.stockController,
                        keyboardType: TextInputType.number,
                        validator: (_) => null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  label: "Publisher",
                  hintText: "Publisher name",
                  controller: cubit.publisherController,
                  validator: (_) => null,
                ),
                SizedBox(height: 10.h),

                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: "Publish year",
                        hintText: "2024",
                        controller: cubit.yearController,
                        keyboardType: TextInputType.number,
                        validator: (_) => null,
                      ),
                    ),
                    SizedBox(width: 10.w),

                    Expanded(
                      child: CustomTextField(
                        label: "Edition",
                        hintText: "Edition",
                        controller: cubit.editionController,
                        validator: (_) => null,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // ----------------------------------------------------
                // مواصفات إضافية
                // ----------------------------------------------------
                sectionTitle("More Information"),

                CustomTextField(
                  label: "Language",
                  hintText: "Language",
                  controller: cubit.languageController,
                  validator: (_) => null,
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  label: "Condition",
                  hintText: "",
                  controller: cubit.conditionController,
                  validator: (_) => null,
                ),
                SizedBox(height: 10.h),

                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: "Number of Pages",
                        hintText: "250",
                        controller: cubit.pagesController,
                        keyboardType: TextInputType.number,
                        validator: (_) => null,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: CustomTextField(
                        label: "Weight (gm)",
                        hintText: "500",
                        controller: cubit.weightController,
                        keyboardType: TextInputType.number,
                        validator: (_) => null,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                /// ---------- Save Button ----------
                ElevatedButton(
                  onPressed: (){
                    cubit.editBook(
                      cubit.buildUpdateRequest(),
                      widget.book.id!,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 16.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                  ),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state is LoadingState
                          ? SizedBox(
                       // width: 20.w,
                        height: 20.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                              AlwaysStoppedAnimation<Color>(
                                MyColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ):
                      Text(
                        "Save changes",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: MyColors.whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                ),

              ],
            ),
          );
        },

      )




    );
  }

  // =================== Widgets ===================

  Widget _mainImagePicker(BookCubit cubit) {
    return GestureDetector(
      onTap: () => cubit.pickMainImage(),
      child: Container(
        height: 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: MyColors.outColor),
        ),
        child: Stack(
          children: [
            if (cubit.mainImageFile != null)
              Center(child: Image.file(cubit.mainImageFile!, width: double.infinity,
                height: 200.h, ))
            else if (cubit.mainImageNetwork != null)
              Center(child: Image.network(cubit.mainImageNetwork!,  width: double.infinity,
                height: 200.h,))
            else
              const Center(child: Icon(Icons.add_a_photo)),

            if (cubit.mainImageFile != null || cubit.mainImageNetwork != null)
              Positioned(
                top: 8.h,
                right: 8.w,
                child: GestureDetector(
                  onTap: () {
                    cubit.mainImageFile = null;
                    cubit.mainImageNetwork = null;
                    cubit.emit(InitialState());
                  },
                  child:Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: MyColors.blackColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close,
                        color: MyColors.whiteColor, size: 18.sp),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _galleryImages(BookCubit cubit) {
    final total =
        cubit.galleryNetworkImages.length + cubit.galleryFiles.length + 1;

    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: total,
        itemBuilder: (_, index) {
          if (index == total - 1) {
            return _addImageBox(() => cubit.pickGalleryImages());
          }

          if (index < cubit.galleryNetworkImages.length) {
            return _galleryItem(
              Image.network(cubit.galleryNetworkImages[index], height: 200.h,),
                  () {
                cubit.galleryNetworkImages.removeAt(index);
                cubit.emit(InitialState());
              },
            );
          }

          final fileIndex = index - cubit.galleryNetworkImages.length;
          return _galleryItem(
            Image.file(cubit.galleryFiles[fileIndex],height: 100.h, ),
                () {
              cubit.galleryFiles.removeAt(fileIndex);
              cubit.emit(InitialState());
            },
          );
        },
      ),
    );
  }

  Widget _addImageBox(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: MyColors.outColor),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _galleryItem(Widget image, VoidCallback onRemove) {
    return Container(
      width: 80.w,
      height: 100.h,
      margin: EdgeInsets.only(right: 10.w),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: image,

          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: MyColors.blackColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close,
                    color: MyColors.whiteColor, size: 18.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: MyColors.blackColor,
        ),
      ),
    );
  }
}
