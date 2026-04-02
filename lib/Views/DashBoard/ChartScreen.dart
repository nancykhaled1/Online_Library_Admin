import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/MyColors.dart';

class BorrowSummaryPieChart extends StatelessWidget {
  final int borrowed;
  final int returned;
  final int late;
  final int pending;

  const BorrowSummaryPieChart({
    super.key,
    required this.borrowed,
    required this.returned,
    required this.late,
    required this.pending,
  });

  @override
  Widget build(BuildContext context) {
    final total = borrowed + returned + late + pending;

    if (total == 0) {
      return const Center(child: Text("No data available"));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // الدائرة نفسها
        SizedBox(
          height: 200.h,
          width: 200.w,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 40.r,
              sectionsSpace: 5,
              sections: [
                _section("Borrowed", borrowed, MyColors.orangeColor),
                _section("Returned", returned, MyColors.greenColor),
                _section("Late", late, Colors.red),
                _section("Pending", pending, MyColors.inputColor),
              ],
            ),
          ),
        ),

        SizedBox(width: 20.w),

        // الـ legend جنب الدائرة
        Padding(
          padding: EdgeInsets.symmetric(
            vertical:50.h
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _legend(MyColors.darkOrangeColor, "Borrowed"),
              SizedBox(height: 8.h),
              _legend(MyColors.darkGreenColor, "Returned"),
              SizedBox(height: 8.h),
              _legend(Colors.red, "Late"),
              SizedBox(height: 8.h),
              _legend(MyColors.inputColor, "Pending"),
            ],
          ),
        )
      ],
    );
  }

  PieChartSectionData _section(String title, int value, Color color) {
    return PieChartSectionData(
      value: value.toDouble(),
      title: value == 0 ? '' : value.toString(),
      radius: 40.r,
      titleStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      color: color,
    );
  }

  Widget _legend(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          text,
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    );
  }
}
