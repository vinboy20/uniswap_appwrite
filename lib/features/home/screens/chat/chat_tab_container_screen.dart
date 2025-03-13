import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/common/widgets/loaders/shimmer.dart';
import 'package:uniswap/controllers/chat_controller.dart';
import 'package:uniswap/controllers/user_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/features/home/screens/chat/chatting_screen.dart';
import 'package:uniswap/models/user.dart'; // Import your UserModel

class ChatTabContainerScreen extends StatefulWidget {
  const ChatTabContainerScreen({super.key});

  @override
  ChatTabContainerScreenState createState() => ChatTabContainerScreenState();
}

class ChatTabContainerScreenState extends State<ChatTabContainerScreen> {
  TextEditingController searchController = TextEditingController();

  final ChatController chatController = Get.put(ChatController());
  final UserController userController = Get.put(UserController());

  final userId = SavedData.getUserId();

  @override
  void initState() {
    super.initState();
    chatController.fetchChats(SavedData.getUserId());
  }

  @override
  Widget build(BuildContext context) {
    final total = chatController.chats.length;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Chats ",
                          style: CustomTextStyles.text24w600cmain,
                        ),
                        TextSpan(
                          text: "($total)",
                          style: CustomTextStyles.text14w400,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
            
              SizedBox(height: 12.h),
              SizedBox(
                height: 45.h,
                child: CustomTextFormField(
                  hintText: "Search People",
                  hintStyle: CustomTextStyles.text14w400,
                  textInputAction: TextInputAction.done,
                  prefix: const Icon(Icons.search),
                  borderDecoration: OutlineInputBorder(
                    borderSide: BorderSide(color: appTheme.gray50),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  filled: true,
                  fillColor: appTheme.gray50,
                ),
              ),
              SizedBox(height: 28.h),
              Expanded(
                child: Obx(
                  () {
                    if (chatController.chats.isEmpty) {
                      return Center(child: _noChat(context));
                    }
                    return ListView.builder(
                      itemCount: chatController.chats.length,
                      itemBuilder: (context, index) {
                        final chat = chatController.chats[index];
                        final isMe = chat['senderId'] == SavedData.getUserId();
                        final otherUserId = isMe ? chat['receiverId'] : chat['senderId'];

                        // Fetch seller details using the otherUserId
                        return FutureBuilder<UserModel?>(
                          future: userController.getUserById(otherUserId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                // child: CircularProgressIndicator()
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 0.5.w, color: TColors.gray50),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  margin: EdgeInsets.only(bottom: 12.h),
                                  child: TShimmerEffect(
                                    width: double.maxFinite,
                                    height: 50,
                                    radius: 10,
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(child: Text("Error loading user details"));
                            } else if (!snapshot.hasData || snapshot.data == null) {
                              return Center(child: Text("User not found"));
                            }

                            final user = snapshot.data!;

                            return GestureDetector(
                              onTap: () {
                                Get.to(() => ChattingScreen(sellerUserId: otherUserId));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(width: 0.5.w, color: TColors.gray50),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                margin: EdgeInsets.only(bottom: 12.h),
                                child: Column(
                                  children: [
                                    SizedBox(height: 11.h),
                                    Row(
                                      children: [
                                        // Display user image
                                        user.photo?.isNotEmpty ?? false
                                            ? FilePreviewImage(
                                                bucketId: Credentials.userBucketId,
                                                fileId: user.photo!,
                                                width: 48.h,
                                                height: 48.h,
                                                isCircular: true,
                                              )
                                            : CustomImageView(
                                                imagePath: user.avatar, // Default profile image
                                                height: 48.h,
                                                width: 48.h,
                                                radius: BorderRadius.circular(50.w),
                                              ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      user.name ?? "User Name", // Display user name
                                                      style: CustomTextStyles.text14wbold,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 2.h),
                                                      child: Text(
                                                        formatTime(chat['timestamp']), // Format timestamp
                                                        style: CustomTextStyles.text12w400.copyWith(
                                                          height: 1.43,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 13.h),
                                                SizedBox(
                                                  child: Text(
                                                    chat['message'],
                                                    style: CustomTextStyles.text12w400.copyWith(
                                                      height: 1.43,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 18.h),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _noChat(BuildContext context) {
    return Center(
      child: Container(
        width: 94.w,
        height: 36.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appTheme.gray50,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomImageView(
              imagePath: ImageConstant.chat,
              color: appTheme.tealA100,
            ),
            const Text('No Chat')
          ],
        ),
      ),
    );
  }

  String formatTime(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    return DateFormat('h:mm a').format(dateTime);
  }
}
