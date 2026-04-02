import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:online_library_management/Views/Library/LibraryScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Cubits/Library/BookViewModel.dart';
import '../../Cubits/Library/ReviewViewModel.dart';
import '../../Cubits/States/States.dart';
import '../../Utils/CommenConfirmSheet.dart';
import '../../Utils/MyColors.dart';
import 'AllReviews.dart';
import 'UpdateBookScreen.dart';


class BookDetailsScreen extends StatefulWidget {
  final String bookId;
  const BookDetailsScreen({super.key, required this.bookId});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  final PageController _pageController = PageController();
  bool showMore = false;

  @override
  void initState() {
    super.initState();

    context.read<BookCubit>().getBookDetails(widget.bookId);
    context.read<ReviewCubit>().getBookReview(widget.bookId);



  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookCubit, States>(
      listener: (context, state) {
        if (state is DeleteBookSuccessState) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => LibraryScreen()),
                (route) => false,
          );
        }
      },
      child: BlocBuilder<BookCubit, States>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Scaffold(
              backgroundColor: MyColors.whiteColor,
              body: Center(child: CircularProgressIndicator()),
            );
          }
          else if (state is ErrorState) {
            final error = state.errorMessage;
      
            if (error == "No Internet Connection") {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      "assets/images/noconnection.svg", // 🖼️ ضيفي صورة عندك
                      width: 200.w,
                      height: 200.h,
                    ),
                  ),
                  SizedBox(height: 20.h),
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
          if (state is BookDetailsSuccessState) {
            final book = state.book;
            final images = (book.gallery != null && book.gallery!.isNotEmpty)
                ? book.gallery!
                : [book.mainImage!];

            return WillPopScope(
              onWillPop: () async {
                // هنا بتتحكمى هل ترجعى ولا لا
                return false; // ❌ مش هيرجع
                // return true;  ✅ هيرجع
              },
              child: Scaffold(
                backgroundColor: MyColors.whiteColor,
                appBar: AppBar(
                  backgroundColor: MyColors.whiteColor,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                              LibraryScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
      
                        /// ---------- Book Image Slider ----------
                    // حدد عدد الصور الفعلي
                   // لو فاضي، خلي القائمة تحتوي على mainImage فقط

                    SizedBox(
                    height: 250.h,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        final imageUrl = images[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: MyColors.dividerColor,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                             child: imageUrl != null && imageUrl.isNotEmpty
                                 ? Image.network(
                               imageUrl,
                               height: 250.h,
                              // width: 70.w,
                               errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
                               loadingBuilder: (context, child, loadingProgress) {
                                 if (loadingProgress == null) return child;
                                 return _buildImagePlaceholder();
                               },
                             )
                                 : _buildImagePlaceholder(),
                        //Image.network(
                            //   images[index],
                            //  // fit: BoxFit.cover,
                            //   height: 250.h,
                            // ),
                          ),
                        );
                      },
                    ),
                  ),
                        SizedBox(height: 4.h),

// Indicator
                    if (images.length > 1) // لو فيه أكثر من صورة بس
                Center(
                child: SmoothPageIndicator(
                controller: _pageController,
                count: images.length,
                effect: const ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: MyColors.primaryColor,
                  dotColor: MyColors.outColor,
                ),
              ),
            ),

          SizedBox(height: 16.h),
      
                        /// ---------- Book Info ----------
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Container(
                            padding: EdgeInsets.all(7.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              border: Border.all(color: MyColors.outColor),
                            ),
                            child: Text(
                              "📘 ${book.categoryId?.name}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: MyColors.blackColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
      
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            book.name ?? '',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                              color: MyColors.blackColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
      
                        Divider(color: MyColors.dividerColor, thickness: 10),
                        SizedBox(height: 12.h),
                        _buildRow("Stock", "${book.numberInStock} books"),
                        _buildRow("Borrowed by", "${book.borrowedBy} students"),
                        _buildRow("Publisher", "${book.publisher}"),
                        _buildRow("Writer", "${book.writer}"),
                        _buildRow("Language", "${book.language}"),
                        _buildRow("Year published", "${book.publishYear ?? ""}"),
                        _buildRow("Edition", book.edition ?? ""),
                        _buildRow("No. of pages", "${book.numPages ?? ""} pages"),
                        _buildRow("Condition", book.condition ?? ""),
                        _buildRow("Weight", "${book.weight ?? ""} gm"),
      
      
      
                        SizedBox(height: 24.h),
                        Divider(color: MyColors.dividerColor, thickness: 10),
                        SizedBox(height: 24.h),
      
                        /// ---------- Synopsis ----------
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            "Synopsis",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: MyColors.blackColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            "${book.synopsis}",
                            maxLines: showMore ? null : 3,
                            overflow:
                            showMore
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade700,
                              height: 1.5.h,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                showMore = !showMore;
                              });
                            },
                            child: Text(
                              showMore ? "Read less" : "Read more",
                              style: TextStyle(
                                color: MyColors.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Divider(color: MyColors.dividerColor, thickness: 10),
                        SizedBox(height: 24.h),

                        /// ---------- Reviews ----------
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Review",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: MyColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        BlocBuilder<ReviewCubit, States>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return Center(child: CircularProgressIndicator());
                            }
                            else if (state is ErrorState) {
                              final error = state.errorMessage;

                              if (error == "No Internet Connection") {
                                return Column(
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
                            else if (state is GetReviewSuccessState) {
                              final reviews =
                                  state.review; // الريفيوهات الجاية من الـ API
                              if (reviews.isEmpty) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: Center(
                                    child: Text(
                                      "No reviews yet",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final itemCount = min(2, reviews.length);
                              final itemHeight = 100.h;
                              return SizedBox(
                                height: itemHeight * itemCount + (itemCount - 1) * 10.h, // 16.h هي المسافة بين العناصر
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    final review = reviews[index];

                                    final parsedDate =
                                    DateTime.parse(review.createdAt!).toLocal();
                                    final formattedDate = DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(parsedDate);

                                    final formattedTime = DateFormat(
                                      'HH:mm',
                                    ).format(parsedDate);
                                    // final cubit = context.read<ProfileViewModel>();
                                    String? imageUrl = review.userId?.photo;
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              CircleAvatar(
                                                radius: 15.r,
                                                backgroundColor: MyColors.whiteColor,
                                                child: ClipOval(
                                                  child: (review.userId?.photo != null && review.userId!.photo!.startsWith("http"))
                                                      ? Image.network(
                                                    review.userId!.photo!,
                                                    key: UniqueKey(),
                                                    fit: BoxFit.cover,
                                                    width: 100.w,
                                                    height: 100.h,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Image.asset(
                                                        'assets/images/personalImage.png',
                                                        fit: BoxFit.cover,
                                                        width: 100.w,
                                                        height: 100.h,
                                                      );
                                                    },
                                                  )
                                                      : Image.asset(
                                                    'assets/images/personalImage.png',
                                                    fit: BoxFit.cover,
                                                    width: 100.w,
                                                    height: 100.h,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10.w,),
                                              Text(
                                                review.userId?.name ?? 'Anonymous',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 5.h,
                                                  horizontal: 7.w,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50.r),
                                                  border: Border.all(
                                                    color: MyColors.outColor,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/star.svg',
                                                    ),
                                                    Text(
                                                      "${review.rating}/5",
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: MyColors.blackColor,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6.h),
                                          Text(
                                            review.comment ?? 'no comment',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                formattedDate,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                              Text(
                                                formattedTime,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 6.h),

                                          GestureDetector(
                                            onTap: () {
                                              showCommonBottomSheet(
                                                context: context,
                                                imagePath:
                                                'assets/images/deleteImage.png',
                                                title: 'Delete this review?',
                                                description:
                                                'You sure you want to delete this review!',
                                                primaryButtonText: 'Yes, Delete',
                                                onPrimaryPressed: () async {
                                                  Navigator.pop(
                                                    context,
                                                  ); // اقفل الشيت

                                                  context
                                                      .read<ReviewCubit>()
                                                      .deleteReview(
                                                    review.id ?? '',
                                                  );
                                                },
                                                secondaryButtonText: 'No, Cancel',
                                                onSecondaryPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(width: 4.w),
                                                Text(
                                                  'delete review',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: MyColors.outColor,
                                      thickness: 1,
                                      height: 16.h, // المسافة الرأسية بين العناصر
                                      indent: 16.w, // بداية الخط من الشمال
                                      endIndent: 16.w, // نهاية الخط من اليمين
                                    );
                                  },
                                  itemCount: itemCount,

                                ),
                              );
                            }
                            return Container();
                          },
                        ),

                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: ElevatedButton(
                            onPressed: () {
                              showAllReviewsSheet(context, book.id!);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.whiteColor,
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 16.w,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.r),
                                side: BorderSide(color: MyColors.outColor),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "View all reviews",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: MyColors.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Divider(color: MyColors.dividerColor, thickness: 10),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) =>
                                      EditBookScreen(book: book,),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
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
                            // state is LoadingState
                            //     ? SizedBox(
                            //   width: 20.w,
                            //   height: 20.w,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       CircularProgressIndicator(
                            //         strokeWidth: 2,
                            //         valueColor:
                            //         AlwaysStoppedAnimation<Color>(
                            //           MyColors.whiteColor,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )
                            //     :
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit,color: MyColors.whiteColor ,size: 20.sp,),
                                SizedBox(width: 5.w,),
                                Text(
                                  "Edit",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: MyColors.whiteColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: ElevatedButton(
                            onPressed: (){

                              showCommonBottomSheet(
                                context: context,
                                imagePath: 'assets/images/deleteImage.png',
                                title: 'Delete this category?',
                                description:
                                'You sure you want to delete this category!',
                                primaryButtonText: 'Yes, Delete',
                                onPrimaryPressed: () async {
                                  Navigator.pop(context); // اقفل الشيت

                                  context.read<BookCubit>().deleteBook(book.id!);
                                },
                                secondaryButtonText: 'No, Cancel',
                                onSecondaryPressed: () {
                                  Navigator.pop(context);
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[100],
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 16.w,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                            ),
                            child:
                            // state is LoadingState
                            //     ? SizedBox(
                            //   width: 20.w,
                            //   height: 20.w,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       CircularProgressIndicator(
                            //         strokeWidth: 2,
                            //         valueColor:
                            //         AlwaysStoppedAnimation<Color>(
                            //           MyColors.whiteColor,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )
                            //     :
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delete,color: Colors.red ,size: 20.sp,),
                                SizedBox(width: 5.w,),
                                Text(
                                  "Delete",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                          ),
                        ),
                        SizedBox(height: 20.h),






                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      
          return Scaffold(
              backgroundColor: MyColors.whiteColor,
              body: Container());
        },
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العمود الأول (العناوين)
          SizedBox(
            width: 120.w, // 👈 حددي عرض ثابت لكل العناوين
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: MyColors.greyColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // العمود الثاني (القيم)
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: MyColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserPhoto(String? url) {
    if (url == null || url.isEmpty) {
      return CircleAvatar(
        radius: 22,
        backgroundImage: AssetImage("assets/images/user.png"),
      );
    }

    return CircleAvatar(
      radius: 22,
      backgroundImage: NetworkImage(url),
      onBackgroundImageError: (_, __) {},
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
     // width: 70.w,
      height: 250.h,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Icon(
        Icons.image_not_supported,
        size: 40,
        color: Colors.grey[500],
      ),
    );
  }

}
