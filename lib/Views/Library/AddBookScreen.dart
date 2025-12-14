import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_library_management/Cubits/Library/BookViewModel.dart';
import '../../Cubits/States/States.dart';
import '../../Utils/MyColors.dart';
import '../../Utils/TextField.dart';
import '../../Utils/dialog.dart';
import 'LibraryScreen.dart';

class AddNewBookScreen extends StatefulWidget {
  final String categoryId;

  AddNewBookScreen({super.key, required this.categoryId});

  @override
  State<AddNewBookScreen> createState() => _AddNewBookScreenState();
}

class _AddNewBookScreenState extends State<AddNewBookScreen> {
  int copies = 0;
  int pages = 0;





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        appBar: AppBar(
          backgroundColor: MyColors.whiteColor,
          elevation: 0,
          title: Text(
            "Add new book",
            style: TextStyle(
              fontSize: 18.sp,
              color: MyColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.read<BookCubit>().clearForm();

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
              context.read<BookCubit>().clearForm();

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>  LibraryScreen(),
                ),
              );

            }
          },
          builder: (context, state) {
            final viewModel = context.read<BookCubit>();
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ----------------------------------------------------
                    // معلومات الكتاب الأساسية
                    // ----------------------------------------------------
                    sectionTitle("Main Book Information"),

                    CustomTextField(
                      keyboardType: TextInputType.text,
                      label: "Name",
                      hintText: "Input the name of book",
                      controller: viewModel.nameController,
                      validator: (text) {
                        if (text!.isEmpty || text.trim().isEmpty) {
                          return 'enter name of book';
                        }
                        return null;
                      },

                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      label: "Writer",
                      hintText: "Input the name of writer",
                      controller: viewModel.writerController,
                      validator: (text) {
                        if (text!.isEmpty || text.trim().isEmpty) {
                          return 'enter the name';
                        }
                        return null;
                      },

                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      label: "Synopsis",
                      hintText: "Input the synopsis",
                      controller: viewModel.synopsisController,
                      validator: (text) {
                        if (text!.isEmpty || text.trim().isEmpty) {
                          return 'must be filled';
                        }
                        return null;
                      },

                    ),

                    SizedBox(height: 20.h),

                    // ----------------------------------------------------
                    // تفاصيل النشر والمؤلفين
                    // ----------------------------------------------------
                    sectionTitle("Publishing Information"),

                    CustomTextField(
                      keyboardType: TextInputType.text,
                      label: "copies",
                      hintText: "Input the condition",
                      controller: viewModel.copiesController,
                      validator: (text) {
                        if (text!.isEmpty || text.trim().isEmpty) {
                          return 'enter the condition';
                        }
                        return null;
                      },

                    ),
                    SizedBox(height: 10.h),


                    CustomTextField(
                      keyboardType: TextInputType.text,
                      label: "Stock",
                      hintText: "Input the condition",
                      controller: viewModel.stockController,
                      validator: (text) {
                        if (text!.isEmpty || text.trim().isEmpty) {
                          return 'enter the condition';
                        }
                        return null;
                      },

                    ),

                    SizedBox(height: 10.h),

                    CustomTextField(
                      keyboardType: TextInputType.text,
                      label: "Publisher",
                      hintText: "Input the name of publisher",
                      controller: viewModel.publisherController,
                      validator: (text) {
                        if (text!.isEmpty || text.trim().isEmpty) {
                          return 'enter the name';
                        }
                        return null;
                      },

                    ),

                    SizedBox(height: 10.h),

                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          keyboardType: TextInputType.text,
                          label: "publishYear",
                          hintText: "Input the year",
                          controller: viewModel.yearController,
                          validator: (text) {
                            if (text!.isEmpty || text.trim().isEmpty) {
                              return 'enter the year';
                            }
                            return null;
                          },

                        ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(child: CustomTextField(
                          keyboardType: TextInputType.text,
                          label: "Edition",
                          hintText: "Input the edition",
                          controller: viewModel.editionController,
                          validator: (text) {
                            if (text!.isEmpty || text.trim().isEmpty) {
                              return 'enter the edition';
                            }
                            return null;
                          },

                        ),),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // ----------------------------------------------------
                    // مواصفات إضافية
                    // ----------------------------------------------------
                    sectionTitle("More Information"),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      label: "Language",
                      hintText: "Input the language",
                      controller: viewModel.languageController,
                      validator: (text) {
                        if (text!.isEmpty || text.trim().isEmpty) {
                          return 'enter the language';
                        }
                        return null;
                      },

                    ),
                    SizedBox(height: 10.h),

                    CustomTextField(
                      keyboardType: TextInputType.text,
                      label: "Condition",
                      hintText: "Input the condition",
                      controller: viewModel.conditionController,
                      validator: (text) {
                        if (text!.isEmpty || text.trim().isEmpty) {
                          return 'enter the condition';
                        }
                        return null;
                      },

                    ),
                    SizedBox(height: 10.h),

                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            keyboardType: TextInputType.text,
                            label: "No. of pages",
                            hintText: "Input the number",
                            controller: viewModel.pagesController,
                            validator: (text) {
                              if (text!.isEmpty || text.trim().isEmpty) {
                                return 'enter the number';
                              }
                              return null;
                            },

                          ),
                        ),
                        SizedBox(width: 10.h),

                        Expanded(
                          child: CustomTextField(
                            keyboardType: TextInputType.text,
                            label: "Weight",
                            hintText: "Input the weight",
                            controller: viewModel.weightController,
                            validator: (text) {
                              if (text!.isEmpty || text.trim().isEmpty) {
                                return 'enter the weight';
                              }
                              return null;
                            },

                          ),
                        ),
                      ],
                    ),



                    SizedBox(height: 10.h),


                    // ----------------------------------------------------
                    // الوسائط
                    // ----------------------------------------------------
                    sectionTitle("Images"),

                    Text(
                      "Main Image",
                      style: labelStyle(),
                    ),

                    SizedBox(height: 10.h),
                    mainImagePicker(),

                    SizedBox(height: 10.h),

                    Text("List of gallery", style: labelStyle()),
                    SizedBox(height: 10.h),
                    additionalImageBox(),

                    SizedBox(height: 40.h),

                    // زر الحفظ
                    ElevatedButton(
                      onPressed: (){
                        context.read<BookCubit>().selectedCategoryId = widget.categoryId;
                        context.read<BookCubit>().addBook();

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
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
                          Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                    ),


                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );

          },

        )





      ),
    );
  }

  // ------------------------- Widgets ------------------------------

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


  Widget counterRow({
    required int value,
    required VoidCallback onPlus,
    required VoidCallback onMinus,
  }) {
    return Row(
      children: [
        buildCounterButton(Icons.remove, onMinus),
        SizedBox(width: 15.w),
        Text(
          "$value",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 15.w),
        buildCounterButton(Icons.add, onPlus),
      ],
    );
  }

  Widget buildCounterButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 35.w,
        height: 35.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, size: 20.sp),
      ),
    );
  }

  Widget mainImagePicker() {
    final viewModel = context.watch<BookCubit>();

    return SizedBox(
      width: double.infinity,
      height: 200.h,
      child: GestureDetector(
        onTap: () => viewModel.pickMainImage(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: MyColors.outColor),
            color: MyColors.softGreyColor,
          ),
          child: viewModel.mainImageFile == null
              ? Icon(Icons.add_a_photo, color: MyColors.greyColor,size: 30.sp,)
              : Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.file(
                  viewModel.mainImageFile!,
                  width: double.infinity,
                  height: 200.h,
                 // fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    viewModel.clearMainImage();
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
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
      ),
    );
  }

  Widget additionalImageBox() {
    final viewModel = context.watch<BookCubit>();

    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.galleryFiles.length + 1,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          // زر إضافة الصور
          if (index == viewModel.galleryFiles.length) {
            return GestureDetector(
              onTap: () => viewModel.pickGalleryImages(),
              child: Container(
                width: 80.w,
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: MyColors.outColor),
                  color: MyColors.softGreyColor,
                ),
                child: Icon(Icons.add, color: MyColors.greyColor),
              ),
            );
          }

          // الصور الحقيقية اللي اختارها المستخدم
          return Container(
            width: 80.w,
            height: 100.h,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.file(
                    viewModel.galleryFiles[index],
                    width: 80.w,
                    height: 100.h,
                   // fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      viewModel.galleryFiles.removeAt(index);
                      viewModel.emit(GalleryImagesPickedSuccessState(
                          viewModel.galleryFiles.map((f) => f.path).toList()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.blackColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, size: 18.sp, color: MyColors.whiteColor),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }


  TextStyle labelStyle() {
    return TextStyle(
      fontSize: 14.sp,
      color: MyColors.blackColor,
      fontWeight: FontWeight.w600,
    );
  }
}




///  الحياه 3ز0: الكون بشرا فى عصر الذكاء الاصطناعى
///    ماكس تيجمارك
///    مؤسسه الكويت للتقدم العلمى
///    2019
///
