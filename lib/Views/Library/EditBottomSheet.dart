import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/MyColors.dart';
import '../../Utils/TextField.dart';

void editBottomSheet({
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
      return _EditBottomSheet(
        buttonText: buttonText,
        onPressed: onPressed,
      );
    },
  );
}

class _EditBottomSheet extends StatefulWidget {

  final String buttonText;
  final Function(String value) onPressed;

  const _EditBottomSheet({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  _EditBottomSheetState createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<_EditBottomSheet> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 10.h,
        bottom: MediaQuery.of(context).viewInsets.bottom, // ⬅⬅ هنا الحل
      ),
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
                  label: "Name of Category",
                  hintText: "name",
                  prefixIcon: Icons.text_fields,
                  controller: nameController,

                  validator: (text) {
                    if (text!.isEmpty || text.trim().isEmpty) {
                      return 'enter the name';
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
                            widget.onPressed(nameController.text.trim());
                            Navigator.pop(context);
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
    );
  }
}
