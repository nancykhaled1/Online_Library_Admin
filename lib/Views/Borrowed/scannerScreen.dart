import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:online_library_management/Views/Borrowed/BorrowedScreen.dart';
import '../../Cubits/Borrowed/BorrowedViewModel.dart';
import '../../Cubits/States/States.dart';
import '../../Utils/MyColors.dart';

class ScanBorrowScreen extends StatefulWidget {
  const ScanBorrowScreen({super.key});

  @override
  State<ScanBorrowScreen> createState() => _ScanBorrowScreenState();
}

class _ScanBorrowScreenState extends State<ScanBorrowScreen> {
  bool isScanned = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: MyColors.blackColor,
        title: Text('Scan Book QR',style: TextStyle(
          color: MyColors.whiteColor
        ),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed(BorrowedScreen.routeName);
          },
          icon: Icon(Icons.arrow_back,color: MyColors.whiteColor,),
        ),
      ),
      body: BlocConsumer<BorrowCubit, States>(
        listener: (context, state) {
          if (state is ScanBorrowSuccessState) {
            final parsedDate =
            DateTime.parse(state.borrow.createdAt!).toLocal();
            final formattedDate = DateFormat(
              'dd/MM/yyyy',
            ).format(parsedDate);
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: MyColors.whiteColor,
                title:  Text('Success',
                style: TextStyle(
                  color: MyColors.primaryColor
                ),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'The name:${state.borrow.bookId?.name ?? ''}'
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text('Returned in:\n$formattedDate',
                      style: TextStyle(
                        color: MyColors.greyColor
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed(BorrowedScreen.routeName);

                    },
                    child: const Text('OK'),
                  )
                ],
              ),
            );
          }

          if (state is ErrorState) {
            setState(() => isScanned = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Try again later')),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center();
          }

          return Stack(
            children: [
              MobileScanner(
                onDetect: (barcode) {
                  if (isScanned) return;

                  final String? raw = barcode.barcodes.first.rawValue;
                  if (raw == null) return;

                  isScanned = true;

                  try {
                    final decoded = jsonDecode(raw);

                    final String borrowId = decoded['borrowId'];

                    print("Extracted borrowId: $borrowId");

                    context.read<BorrowCubit>().scanBorrowedBook(borrowId);
                  } catch (e) {
                    isScanned = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid QR code')),
                    );
                  }
                },

              ),

              // Overlay
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.primaryColor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
