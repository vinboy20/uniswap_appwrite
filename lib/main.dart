import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uniswap/bindings/general_bindings.dart';
import 'package:uniswap/controllers/appwrite_controller.dart';
import 'package:uniswap/routes/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  // await Monnify.initialize(
  //   applicationMode: ApplicationMode.TEST, // Change to LIVE in production
  //   apiKey: _apiKey,
  //   contractCode: _contractCode,
  // );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Get.put(AppwriteController()); // Initialize Appwrite in the controller
  ThemeHelper().changeTheme('primary');
  configLoading();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 55.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.white
    ..indicatorColor = const Color(0xFF7BF2DA)
    ..textColor = Colors.black
    // ignore: deprecated_member_use
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          theme: theme,
          // theme: TAppTheme.lightTheme,
          title: 'uniswap',
          debugShowCheckedModeBanner: false,
          initialRoute: TRoutes.splash,
          initialBinding: GeneralBindings(),
          navigatorKey: navigatorKey,
          getPages: AppRoutes.pages,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}