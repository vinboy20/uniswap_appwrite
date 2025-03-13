import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uniswap/common/widgets/search/search_button_field.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/home/screens/home_container/widgets/drawer_widget.dart';
import 'package:uniswap/features/home/screens/homepage/widget/all_cat_popup.dart';
import 'package:uniswap/features/home/screens/homepage/widget/carousel_widget.dart';
import 'package:uniswap/features/home/screens/homepage/widget/category_widget.dart';
import 'package:uniswap/features/home/screens/homepage/widget/popular_product.dart';
import 'package:uniswap/features/home/screens/homepage/widget/title_heading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  bool profileLoading = false;

  String? username;

  String? mail;

  String? image;

  void shareContent() {
    String text = 'Check out this amazing product!';
    String link = 'https://example.com/product/123';
    String shareText = '$text\n$link';

    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Let\'s buy and sell',
          style: CustomTextStyles.text18BoldcPrimary,
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.notes_sharp), // Your custom icon
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            );
          },
        ),
        actions: [
          Container(
            width: 34.h,
            height: 34.h,
            margin: EdgeInsets.only(right: 18.w),
            decoration: ShapeDecoration(
              color: const Color(0xFFF1F5F9),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFE2E8F0)),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.notifications_none,
                size: 24.sp,
                color: TColors.gray200,
              ),
             
              onPressed: () => shareContent(),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        width: 271.w,
        child: DrawerWidget(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // searchbar
            SearchButtonField(),

            SizedBox(height: 26.h),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    titleHeading(
                      context,
                      popular: "Shop by Category",
                      viewAll: "View All",
                      isDisabled: false,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return const AllCatWidget();
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    categoryWidget(context),
                    SizedBox(height: 20.h),
                    carouselWidget(context),
                    SizedBox(height: 31.h),
                    titleHeading(
                      context,
                      popular: "Popular",
                      viewAll: "View All",
                      isDisabled: true,
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    PopularProduct(),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
