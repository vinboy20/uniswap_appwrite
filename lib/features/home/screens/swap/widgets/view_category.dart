import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:uniswap/common/widgets/custom_dash_line_painter.dart';
import 'package:uniswap/core/app_export.dart';

class ViewCategory extends StatefulWidget {
  const ViewCategory({
    super.key,
    // required this.categories,
  });

  // final Category categories;
  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: GFAccordion(
            titleChild: Row(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: CustomImageView(
                    imagePath: "images",
                    height: 25.h,
                    width: 25.w,
                    margin: EdgeInsets.only(right: 10.w),
                  ),
                ),
                Text("title"),
              ],
            ),
            collapsedTitleBackgroundColor: Colors.transparent,
            contentChild: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 2,
              separatorBuilder: (BuildContext context, index) => SizedBox(
                height: 10.h,
              ),
              itemBuilder: (BuildContext context, index) {
                // var sub = widget.categories.subCategory[index];
                return GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   selectedCategory = sub;
                    // });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Text("sub"),
                  ),
                );
              },
            ),
            collapsedIcon: Icon(
              Icons.keyboard_arrow_down,
              size: 18.sp,
            ),
            expandedIcon: Icon(
              Icons.keyboard_arrow_up,
              size: 18.sp,
            ),
          ),
        ),
        SizedBox(
          height: 1.0, // Thickness of the dashed line
          width: double.infinity,
          child: CustomPaint(
            painter: CustomDashLinePainter(
              dashWidth: 5.0,
              dashSpace: 3.0,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
