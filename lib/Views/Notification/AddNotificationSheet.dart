import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_library_management/Cubits/Notification/NotificationViewModel.dart';
import 'package:online_library_management/Views/Notification/NotificationScreen.dart';
import '../../Cubits/States/States.dart';
import '../../Utils/MyColors.dart';
import '../../Utils/TextField.dart';
import '../../Utils/dialog.dart';

void addNotificationBottomSheet({
  required BuildContext context,
  required String buttonText,
  required Function(String value) onPressed,
}) {

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: MyColors.whiteColor,
    enableDrag: false,
    isDismissible: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (context) {
      return _AddNotificationBottomSheet(
        buttonText: buttonText,
        onPressed: onPressed,
      );
    },
  );
}

class _AddNotificationBottomSheet extends StatefulWidget {

  final String buttonText;
  final Function(String value) onPressed;

  const _AddNotificationBottomSheet({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  _AddNotificationBottomSheetState createState() => _AddNotificationBottomSheetState();
}

class _AddNotificationBottomSheetState extends State<_AddNotificationBottomSheet> {

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationScreenViewModel,States>(
      listener: (context, state) async {
        if (state is ErrorState) {
          showOverlayMessage(context, state.errorMessage!, isError: true);

        }
        else if (state is LoginSuccessState) {
          showOverlayMessage(context, state.response.data!.message!, isError: false);
          context.read<NotificationScreenViewModel>().clearForm();

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) =>  NotificationScreen(),
            ),
          );

        }
      },
      builder: (context, state) {
        final viewModel = context.read<NotificationScreenViewModel>();
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 10.h,
            bottom: MediaQuery.of(context).viewInsets.bottom, // ⬅⬅ هنا الحل
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 20.h),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        label: "Title",
                        hintText: "title",
                        controller: viewModel.titleController,
            
                        validator: (text) {
                          if (text!.isEmpty || text.trim().isEmpty) {
                            return 'enter the title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        label: "Description",
                        hintText: "your description....",
                        controller: viewModel.bodyController,
                        maxLines: 10,
            
                        validator: (text) {
                          if (text!.isEmpty || text.trim().isEmpty) {
                            return 'enter the description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
            
                      // Cancel button
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                  side: BorderSide(color: MyColors.outColor),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Text("Cancel",
                                    style: TextStyle(color: MyColors.blackColor,fontSize: 15.sp)),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (){
                                if (_formKey.currentState!.validate()) {
                                  widget.onPressed(viewModel.titleController.text.trim());
            
                                  Navigator.pop(context);
                                }
                                else {
                                  showOverlayMessage(context, "Please complete the form", isError: true);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: MyColors.primaryColor),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Text(widget.buttonText,
                                    style: TextStyle(color: MyColors.whiteColor,fontSize: 15.sp)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // add button
                      SizedBox(height: 20.h),
            
                    ],
                  ),
                ),
            
            
              ],
            ),
          ),
        );

      },

    );
  }
}
