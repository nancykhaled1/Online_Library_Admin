import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:online_library_management/Views/Borrowed/ReturnedScreen.dart';
import '../../Cubits/Borrowed/BorrowedViewModel.dart';
import '../../Cubits/States/States.dart';
import '../../Utils/MyColors.dart';
import '../Borrowed/BorrowedScreen.dart';

enum ScanType {
  borrow,
  returnBook,
}

class ScanBorrowScreen extends StatefulWidget {
  final ScanType scanType;

  const ScanBorrowScreen({
    super.key,
    required this.scanType,
  });

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
        centerTitle: true,
        title: Text(
          widget.scanType == ScanType.borrow
              ? 'Scan Borrow QR'
              : 'Scan Return QR',
          style: TextStyle(color: MyColors.whiteColor),
        ),
        leading: IconButton(
          onPressed: () {
            if (widget.scanType == ScanType.borrow) {
              Navigator.of(context)
                  .popAndPushNamed(BorrowedScreen.routeName);
            } else {
              Navigator.of(context)
                  .popAndPushNamed(ReturnedScreen.routeName);
            }
          },
          icon: Icon(Icons.arrow_back, color: MyColors.whiteColor),
        ),

      ),

      body: BlocConsumer<BorrowCubit, States>(
        listener: (context, state) {
          /// ================= BORROW SUCCESS =================
          if (state is ScanBorrowSuccessState) {
            final parsedDate =
            DateTime.parse(state.borrow.mustReturnDate!).toLocal();
            final formattedDate =
            DateFormat('dd/MM/yyyy').format(parsedDate);

            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: MyColors.whiteColor,
                title: Text(
                  'Borrow Success',
                  style: TextStyle(color: MyColors.primaryColor),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Book: ${state.borrow.bookId?.name ?? ''}'),
                    SizedBox(height: 10.h),
                    Text(
                      'Returned in:\n$formattedDate',
                      style: TextStyle(color: MyColors.greyColor),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed(
                          BorrowedScreen.routeName);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }

          /// ================= RETURN SUCCESS =================
          if (state is ScanReturnSuccessState) {
            final parsedDate =
            DateTime.parse(state.returned.returnedAt!).toLocal();
            final formattedDate =
            DateFormat('dd/MM/yyyy').format(parsedDate);

            final Date =
            DateTime.parse(state.returned.mustReturnDate!).toLocal();
            final returnDate =
            DateFormat('dd/MM/yyyy').format(Date);

            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: MyColors.whiteColor,
                title: Text(
                  'Return Success',
                  style: TextStyle(color: MyColors.primaryColor),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Book: ${state.returned.bookId?.name ?? ''}'),
                    SizedBox(height: 10.h),
                    Text(
                      'Returned at:\n$formattedDate',
                      style: TextStyle(color: MyColors.greyColor),
                    ),

                    SizedBox(height: 20.h),
                    Text(
                      'Must returned at:$returnDate\n ',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed(
                          ReturnedScreen.routeName);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }

          /// ================= ERROR =================
          if (state is ErrorState) {
            setState(() => isScanned = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                Text(state.errorMessage ?? 'Try again later'),
              ),
            );
          }
        },

        builder: (context, state) {
          return Stack(
            children: [
              MobileScanner(
                onDetect: (barcode) {
                  if (isScanned) return;

                  final raw = barcode.barcodes.first.rawValue;
                  if (raw == null) return;

                  isScanned = true;

                  try {
                    final decoded = jsonDecode(raw);
                    final String borrowId = decoded['borrowId'];

                    /// 👇 اختيار الفانكشن حسب النوع
                    if (widget.scanType == ScanType.borrow) {
                      context
                          .read<BorrowCubit>()
                          .scanBorrowedBook(borrowId);
                    } else {
                      context
                          .read<BorrowCubit>()
                          .scanReturnedBook(borrowId);
                    }
                  } catch (e) {
                    isScanned = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invalid QR code'),
                      ),
                    );
                  }
                },
              ),

              /// Overlay
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
