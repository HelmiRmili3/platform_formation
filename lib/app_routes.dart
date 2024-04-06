import 'package:eplatfrom/presentation/screens/auth/login_screen.dart';
import 'package:eplatfrom/presentation/screens/auth/signup_screen.dart';
import 'package:eplatfrom/presentation/screens/home/admin/admin_home_screen.dart';
import 'package:eplatfrom/presentation/screens/home/etudiant/etudiant_home_screen.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/formateur_home_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const LoginScreen()),
    GetPage(name: '/signup', page: () => const SignupScreen()),
    GetPage(name: '/admin', page: () => const AdminHomeScreen()),
    GetPage(name: '/etudiant', page: () => const EtudiantHomeScreen()),
    GetPage(name: '/formateur', page: () => const FormateurHomeScreen()),
  ];
}
