import 'package:get/get_navigation/src/routes/get_route.dart';

import 'presentation/screens/auth/signin_screen.dart';
import 'presentation/screens/auth/signup_screen.dart';
import 'presentation/screens/home/admin/admin_home_screen.dart';
import 'presentation/screens/home/etudiant/etudiant_home_screen.dart';
import 'presentation/screens/home/formateur/formateur_home_screen.dart';
import 'presentation/screens/home/formateur/stepper_from_screen.dart';

class AppRoutes {
  static final routes = [
    // main routes
    GetPage(
      name: '/',
      page: () =>  SignInScreen(),
     // middlewares: [AuthMiddleware()],
    ),
    GetPage(name: '/admin', page: () => const AdminHomeScreen()),
    GetPage(name: '/etudiant', page: () => const EtudiantHomeScreen()),
    GetPage(name: '/formateur', page: () => const FormateurHomeScreen()),
    // sub routes
    GetPage(name: '/signup', page: () =>  SignUpScreen()),
    GetPage(name: '/addFormation', page: () => const StepperFormScreen())
  ];
}
