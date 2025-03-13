import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/button/custom_icon_button.dart';
import 'package:uniswap/core/app_export.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({
    super.key,
    this.index,
    this.onTapProductComponent,
  });

  final dynamic index;
  final VoidCallback? onTapProductComponent;

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: () {
        widget.onTapProductComponent!.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 116.h,
              width: 159.w,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  CustomImageView(
                    imagePath: TImages.kettleBlack,
                    //height: 124.h,
                    width: double.maxFinite,
                    radius: BorderRadius.only(topLeft: Radius.circular(8.w), topRight: Radius.circular(8.w)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h, right: 10.w),
                    child: CustomIconButton(
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked; // Toggle the like state
                        });
                      },
                      height: 25.h,
                      width: 25.w,
                      decoration: IconButtonStyleHelper.fillTeal,
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.favorite_sharp,
                        size: 18.sp,
                        // color: Color(0xFFE11D48),
                        color: isLiked ? const Color(0xFFE11D48) : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  text: "Electric Kettle ",
                  style: CustomTextStyles.text12w400,
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.index == 0
                          ? "(Used)"
                          : widget.index == 1
                              ? "(new)"
                              : "(Used)",
                      style: widget.index == 0
                          ? CustomTextStyles.text12w400cpink
                          : widget.index == 1
                              ? CustomTextStyles.text14w400cPrimary
                              : CustomTextStyles.text12w400cpink,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 147.w,
                child: const Divider(
                  color: Color(0xFFE2E8F0),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: Text(
                "₦3,000",
                style: CustomTextStyles.text12wBold,
              ),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ojo, Lagos",
                    style: CustomTextStyles.text12w400,
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    size: 18.sp,
                    color: TColors.gray200,
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}
