import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/home/screens/home_container/widgets/drawer_widget.dart';
import 'package:uniswap/features/shop/screen/bid_screen/widget/bid_empty_screen.dart';
import 'package:uniswap/features/shop/screen/bid_screen/widget/bid_item.dart';

class BidScreen extends StatefulWidget {
  const BidScreen({super.key});

  @override
  State<BidScreen> createState() => _BidScreenState();
}

class _BidScreenState extends State<BidScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // final ProductController controller = Get.find<ProductController>();
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            "My Bid",
            style: CustomTextStyles.text14wbold,
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
              padding: const EdgeInsets.all(5),
              width: 34.w,
              height: 34.h,
              margin: EdgeInsets.only(
                right: 18.w,
              ),
              decoration: ShapeDecoration(
                color: const Color(0xFFF1F5F9),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Icon(
                Icons.notifications_outlined,
                color: TColors.gray200,
                size: 22.sp,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          width: 271.w,
          child: DrawerWidget(),
        ),
        body: Obx(() {
          // ignore: unrelated_type_equality_checks
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.userBids.isEmpty) {
            return BidEmptyScreen();
          } else {
            return Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 248.h,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.w,
                  crossAxisSpacing: 20.w,
                ),
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: controller.userBids.length,
                itemBuilder: (context, int index) {
                  final bid = controller.userBids[index];
                  final product = controller.products.firstWhereOrNull((element) => element.docId == bid.productId);
                  return BidItem(product: product, bid: bid);
                },
              ),
            );
          }
        }),
      ),
    );
  }

//   Column bidItem(BuildContext context, ProductModel? product, String bidStatus, BidModel bid) {

//   }
}
