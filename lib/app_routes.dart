
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'presentation/screens/auth/signin_screen.dart';
import 'presentation/screens/auth/signup_screen.dart';
import 'presentation/screens/home/admin/admin_home_screen.dart';
import 'presentation/screens/home/etudiant/etudiant_home_screen.dart';
import 'presentation/screens/home/formateur/formateur_home_screen.dart';
import 'presentation/screens/home/formateur/stepper_from_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const SignInScreen()),
    GetPage(name: '/signup', page: () => const SignUpScreen()),
    GetPage(name: '/admin', page: () => const AdminHomeScreen()),
    GetPage(name: '/etudiant', page: () => const EtudiantHomeScreen()),
    GetPage(name: '/formateur', page: () => const FormateurHomeScreen()),
    GetPage(name: '/addFormation', page: ()=> const StepperFormScreen())
  ];
}
