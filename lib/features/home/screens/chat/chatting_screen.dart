import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/button/custom_outlined_button.dart';
import 'package:uniswap/common/widgets/custom_rating_bar.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/controllers/chat_controller.dart';
import 'package:uniswap/controllers/database_controller.dart';
import 'package:uniswap/controllers/user_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/features/personalization/screen/escrow_t_c_screen/escrow_t_c_screen.dart';
import 'package:uniswap/models/user.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key, this.sellerUserId});
  final String? sellerUserId;

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  bool isSelectedSwitch = false;

  final DatabaseController controller = Get.put(DatabaseController());
  final ChatController chatController = Get.put(ChatController());
  final UserController userController = Get.put(UserController());
  final TextEditingController messageController = TextEditingController();

  UserModel? _userDetails;

  bool _isSellerOnline = false;

  @override
  void initState() {
    super.initState();
     _fetchOnlineStatus();
    _fetchUserDetails();
    chatController.fetchMessages(SavedData.getUserId(), widget.sellerUserId!);
    chatController.markUserOnline(SavedData.getUserId()); // Mark current user as online
  }

   @override
  void dispose() {
    chatController.markUserOffline(SavedData.getUserId()); // Mark current user as offline
    super.dispose();
  }

  Future<void> _fetchOnlineStatus() async {
    final isOnline = await chatController.fetchOnlineStatus(widget.sellerUserId!);
    setState(() {
      _isSellerOnline = isOnline;
    });
  }

  Future<void> _fetchUserDetails() async {
    try {
      final user = await userController.getUserById(widget.sellerUserId);
      setState(() {
        _userDetails = user;
      });
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Error",
        message: e.toString(),
      );
    }
  }

  String formatTime(String timestamp) {
    // Parse the timestamp string into a DateTime object
    final dateTime = DateTime.parse(timestamp);

    // Format the DateTime object to "9:40 am" format
    return DateFormat('h:mm a').format(dateTime);
  }

  final userId = SavedData.getUserId();

  Future<void> _submitRating(
    context,
    double communicationRating,
    double productQualityRating,
    double easyGoingRating,
    String comment,
  ) async {
    final userId = widget.sellerUserId;
    final raterId = SavedData.getUserId();
    final userdata = SavedData.getUserData();
    final name = userdata['name'] ?? 0;
    final avatar = userdata['avatar'] ?? 0;
    final photo = userdata['photo'] ?? 0;

    if (userId == null || raterId == null) return;

    await controller.submitRating(
      userId: userId,
      raterId: raterId,
      name: name,
      photo: photo,
      avatar: avatar,
      communicationRating: communicationRating,
      productQualityRating: productQualityRating,
      easyGoingRating: easyGoingRating,
      comment: comment,
    );
    Navigator.pop(context); // Close the modal
  }

  void _sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatController.sendMessage(
        SavedData.getUserId(),
        widget.sellerUserId!,
        messageController.text,
      );
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: TAppBar(
          showBackArrow: true,
          title: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            children: [
              Container(
                height: 10.h,
                width: 10.h,
                decoration: BoxDecoration(
                  // color: appTheme.teal400,
                   color: _isSellerOnline ? appTheme.teal400 : Colors.yellow,
                  borderRadius: BorderRadius.circular(5.w),
                ),
              ),
              Text(
                _userDetails?.name ?? "Loading...",
                style: CustomTextStyles.text16Bold,
              ),
            ],
          ),
        ),
        body: _userDetails == null
            ? Center(child: CircularProgressIndicator()) // Show loading indicator
            : Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  children: [
                    _buildAppeal(context),
                    SizedBox(height: 24.h),
                    Obx(() {
                      return Expanded(
                        child: _buildResponderSMessage(context),
                      );
                    }),
                    _buildMessage(context),
                  ],
                ),
              ),
        // bottomNavigationBar: _buildMessage(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppeal(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomElevatedButton(
          height: 24.h,
          width: 85.w,
          text: "Appeal",
          buttonStyle: CustomButtonStyles.fillTealA,
          buttonTextStyle: CustomTextStyles.text14w400,
          onPressed: () {},
        ),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 1,
          children: [
            GestureDetector(
              onTap: () {
                final commentController = TextEditingController();
                double communicationRating = 0;
                double productQualityRating = 0;
                double easyGoingRating = 0;

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Text("Rate Seller", style: theme.textTheme.bodyMedium),
                          SizedBox(height: 34.h),
                          CustomTextFormField(
                            controller: commentController,
                            hintText: "Add comment",
                            hintStyle: theme.textTheme.bodyLarge!,
                            textInputAction: TextInputAction.done,
                            maxLines: 5,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                            borderDecoration: TextFormFieldStyleHelper.outlineOnErrorTL8,
                            filled: true,
                            fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                          ),
                          SizedBox(height: 44.h),
                          _buildRatingRow("Communication", communicationRating, (rating) {
                            communicationRating = rating;
                          }),
                          SizedBox(height: 23.h),
                          _buildRatingRow("Products quality", productQualityRating, (rating) {
                            productQualityRating = rating;
                          }),
                          SizedBox(height: 21.h),
                          _buildRatingRow("Easy going", easyGoingRating, (rating) {
                            easyGoingRating = rating;
                          }),
                          SizedBox(height: 52.h),
                          _buildOverallRating(),
                          SizedBox(height: 35.h),
                          CustomElevatedButton(
                            text: "Done",
                            onPressed: () async {
                              if (commentController.text.isEmpty) {
                                TLoaders.warningSnackBar(title: "Message field is required");
                              } else {
                                await _submitRating(
                                  context,
                                  communicationRating,
                                  productQualityRating,
                                  easyGoingRating,
                                  commentController.text,
                                );
                              }
                            },
                          ),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text("Review User", style: CustomTextStyles.text14w400cPrimary),
            ),
            const Icon(
              Icons.chevron_right,
              color: TColors.primary,
            )
          ],
        ),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: [
            GFToggle(
              onChanged: (val) {
                // Ensure val is not null before using it
                if (val != null) {
                  // Show the bottom sheet when the toggle is turned on
                  if (val) {
                    showModalBottomSheet(
                      showDragHandle: true,
                      context: context, // Make sure you have access to the BuildContext
                      builder: (BuildContext context) {
                        // Return the widget tree for the bottom sheet
                        return _buildEscrowModePopup(context);
                      },
                    );
                  }
                }
              },
              value: false, // Initial value of the toggle
              type: GFToggleType.android,
            ),
            Text(
              "Escrow",
              style: CustomTextStyles.text14w400,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingRow(String label, double initialRating, Function(double) onRatingUpdate) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          CustomRatingBar(
            initialRating: initialRating,
            color: appTheme.orange800,
            onRatingUpdate: onRatingUpdate,
          ),
        ],
      ),
    );
  }

  Widget _buildOverallRating() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF42D8B9)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text("Overall rating", style: theme.textTheme.bodyMedium),
          SizedBox(height: 14.h),
          Obx(() => Text(
                controller.overallRating.value.toStringAsFixed(1),
                style: CustomTextStyles.text20bold,
              )),
          SizedBox(height: 14.h),
          CustomRatingBar(
            initialRating: controller.overallRating.value,
            itemSize: 24,
            color: appTheme.orange800,
            ignoreGestures: true,
            onRatingUpdate: (p0) {},
          ),
          SizedBox(height: 25.h),
          Text(
            "Based on ${controller.ratings.length} reviews",
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildResponderSMessage(BuildContext context) {
    return ListView.builder(
      itemCount: chatController.messages.length,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final message = chatController.messages[index];
        final isMe = message['senderId'] == SavedData.getUserId();

        if (isMe) {
          // Sender's message UI
          return Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 42.w, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Text(
                    formatTime(message['timestamp']), // Formatted time
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 8.w),
                    padding: EdgeInsets.all(10.w),
                    decoration: TAppDecoration.fillCyan50.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderTL101,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),
                        Flexible(
                          child: Text(
                            message['message'],
                            maxLines: 5,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          // Receiver's message UI
          return Row(
            children: [
              _userDetails?.photo?.toString().isNotEmpty ?? false
                  ? FilePreviewImage(
                      bucketId: Credentials.userBucketId,
                      // fileId: widget.sellerImage.toString(),
                      fileId: _userDetails!.photo.toString(),
                      width: 42.h,
                      height: 42.h,
                      isCircular: true,
                    )
                  : CustomImageView(
                      // imagePath: widget.sellerAvatar, // Default profile image
                      imagePath: _userDetails!.avatar, // Default profile image
                      height: 42.h,
                      width: 42.w,
                      radius: BorderRadius.circular(50.w),
                    ),
              //  SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                  padding: EdgeInsets.all(10.w),
                  decoration: TAppDecoration.fillBluegray50.copyWith(
                    borderRadius: BorderRadiusStyle.customBorderBL101,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),
                      Flexible(
                        child: Text(
                          message['message'],
                          maxLines: 10,
                          softWrap: true,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const Spacer(flex: 8),
              Padding(
                padding: EdgeInsets.only(top: 14.h, bottom: 15.h),
                child: Text(
                  formatTime(message['timestamp']), // Formatted time
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          );
        }
      },
    );
  }

  /// Section Widget
  Widget _buildMessage(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 1.w,
        vertical: 24.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomTextFormField(
              autofocus: false,
              controller: messageController,
              hintText: "type a message here...",
              hintStyle: theme.textTheme.bodySmall!,
              textInputAction: TextInputAction.done,
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              borderDecoration: OutlineInputBorder(
                borderSide: BorderSide(color: appTheme.gray50),
                borderRadius: BorderRadius.circular(50),
              ),
              filled: true,
              fillColor: appTheme.gray50,
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () async {
              _sendMessage();
            },
            child: Container(
              alignment: Alignment.center,
              width: 50.h,
              height: 50.h,
              decoration: BoxDecoration(
                color: appTheme.teal400,
                borderRadius: BorderRadius.circular(50.w),
              ),
              child: Icon(
                Icons.send,
                size: 25.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEscrowModePopup(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      color: appTheme.gray10002,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 47.w),
        height: 305.h,
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              " Escrow Mode",
              style: CustomTextStyles.text16Bold,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: 286.h,
              child: Text(
                "Seller wants to switch to escrow payment Do you accept?",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.text14wbold.copyWith(
                  height: 1.43,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "No",
                    style: TextStyle(color: Color(0xFFFB647A), fontSize: 16.sp),
                  ),
                ),
                CustomOutlinedButton(
                    width: 108.w,
                    height: 40.h,
                    text: "Ok",
                    onPressed: () {
                      Get.to(() => EscrowTCScreen());
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
