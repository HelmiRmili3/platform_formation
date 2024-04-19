import 'package:eplatfrom/bindings.dart';
import 'package:eplatfrom/firebase_options.dart';
import 'package:eplatfrom/presentation/controllers/auth_controller.dart';
import 'package:eplatfrom/presentation/screens/auth/signin_screen.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/formateur_home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final w = MediaQuery.of(context).size.width;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ePlatform',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialBinding: AppBindings(),
      home: Obx(
        () => Get.find<AuthController>().isAuthenticated
            ? const FormateurHomeScreen()
            : const SignInScreen(),
      ),
      // getPages: AppRoutes.routes,
    );
  }
}
