import 'package:get/get.dart';
import '../../../futures/profile/presentation/profile_view.dart';
import '/futures/ml/presentation/ml_view.dart';
import '/futures/chats/presentation/pages/conversation/conversation_view.dart';
import '/futures/chats/presentation/pages/chats/chat_view.dart';
import '../../../futures/home/presentation/pages/home/home_view.dart';
import '/futures/auth/presentation/pages/auth/auth_view.dart';
import '/futures/auth/presentation/pages/login/login_view.dart';
import '/futures/auth/presentation/pages/register/register_view.dart';
import '/futures/auth/presentation/pages/forget_password/forget_password_view.dart';
import '/futures/home/presentation/pages/home/home_view.dart';
import '/futures/home/presentation/pages/main/main_view.dart';
import '/core/services/binding/auth_binding.dart';
import '/futures/on_boarding/presentation/on_boarding/boarding_view.dart';
import '/futures/on_boarding/presentation/splash/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  static const String initial = Routes.splash;

  static final routes = <GetPage<dynamic>>[
    GetPage(name: Routes.splash, page: () => const SplashView()),
    GetPage(name: Routes.onBoarding, page: () => const BoardingView()),
    GetPage(
      name: Routes.auth,
      page: () => const AuthView(),
      binding: AuthBinding(),
      children: [
        GetPage(name: Routes.login, page: () => const LoginView()),
        GetPage(name: Routes.register, page: () => const RegisterView()),
        GetPage(
            name: Routes.forgetPassword,
            page: () => const ForgetPasswordView()),
      ],
    ),
    GetPage(name: Routes.main, page: () => const MainView(), children: [
      GetPage(name: Routes.profile, page: () => const ProfileView()),
      GetPage(name: Routes.home, page: () => const HomeView()),
      GetPage(name: Routes.chat, page: () => const ChatView(), children: [
        GetPage(name: Routes.conversation, page: () => const ConversationView())
      ]),
      GetPage(name: Routes.ml, page: () => const MlView()),
    ])
  ];
}
