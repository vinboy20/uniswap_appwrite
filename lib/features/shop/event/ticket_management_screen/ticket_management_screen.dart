import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/form/custom_search_view.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/home/screens/home_container/widgets/drawer_widget.dart';
import 'package:uniswap/features/shop/event/ticket_management_screen/widgets/productcard3_item_widget.dart';
import 'package:uniswap/features/shop/event/ticket_screen/ticket_screen.dart';
import 'package:uniswap/features/shop/event/ticket_upload_screen/ticket_upload_screen.dart';

class TicketManagementScreen extends StatefulWidget {
  const TicketManagementScreen({super.key});

  @override
  State<TicketManagementScreen> createState() => _TicketManagementScreenState();
}

class _TicketManagementScreenState extends State<TicketManagementScreen> with TickerProviderStateMixin {
  late TabController tabviewController;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final List<Map<String, dynamic>> items = [
    {'label': 'Sell Ticket', 'route': () => TicketUploadScreen()},
    {'label': 'Upcoming', 'route': () => TicketScreen()},
  ];
  String? selectedValue;
  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        drawer: Drawer(
          width: 271.w,
          child: DrawerWidget(),
        ),
        body: Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
              image: AssetImage(TImages.ticketBg),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 16.h),
            child: Column(
              children: [
                CustomSearchView(
                  autofocus: false,
                  //controller: searchController,
                  hintText: "Search",
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF94A3B8),
                  ),
                  borderDecoration: SearchViewStyleHelper.fillTeal,
                  filled: true,
                  fillColor: appTheme.gray50,
                ),
                SizedBox(height: 20.h),
                _buildTabview(context),
                SizedBox(height: 20.h),

                Expanded(
                  //height: 536.v,
                  child: TabBarView(
                    controller: tabviewController,
                    children: [...List.generate(2, (index) => Productcard3ItemWidget(index: index))],
                  ),
                ),
                // Expanded(
                //   child: ListView.separated(
                //     scrollDirection: Axis.vertical,
                //     physics: const AlwaysScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     separatorBuilder: (context, index) {
                //       return SizedBox(
                //         height: 24.v,
                //       );
                //     },
                //     itemCount: 4,
                //     itemBuilder: (context, index) {
                //       return Productcard3ItemWidget(index: index);
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
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
      centerTitle: true,
      title: Text(
        "Manage Events",
        style: CustomTextStyles.text14wbold,
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10.h),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Sell Ticket',
                style: CustomTextStyles.text14w400cPrimary.copyWith(
                  height: 1.43,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item['label'],
                        child: Text(
                          item['label']!,
                          style: CustomTextStyles.text12w400.copyWith(
                            height: 1.43,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });

                
              final selectedItem = items.firstWhere((e) => e['label'] == value);
              Get.to(selectedItem['route']);
              },
              buttonStyleData: ButtonStyleData(
                height: 34.h,
                width: 100,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xFFF1F5F9),
                ),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.expand_more,
                ),
                iconSize: 25,
                iconEnabledColor: Colors.grey,
                iconDisabledColor: Colors.grey,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: WidgetStateProperty.all(6),
                  thumbVisibility: WidgetStateProperty.all(true),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.only(left: 14, right: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildTabview(BuildContext context) {
    return SizedBox(
      height: 40.h,
      //width: 342.h,

      child: TabBar(
        controller: tabviewController,
        labelPadding: EdgeInsets.zero,
        labelColor: theme.colorScheme.primary,
        dividerColor: appTheme.gray6003f,
        labelStyle: TextStyle(
          fontSize: 16.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelColor: theme.colorScheme.onSecondaryContainer,
        unselectedLabelStyle: TextStyle(
          fontSize: 16.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: appTheme.teal30001,
              width: 2.h,
            ),
          ),
        ),
        tabs: const [
          Tab(
            child: Text(
              "Upcoming",
            ),
          ),
          Tab(
            child: Text(
              "Past",
            ),
          ),
        ],
      ),
    );
  }
}