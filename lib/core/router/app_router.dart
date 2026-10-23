import 'package:go_router/go_router.dart';
import 'package:car_market_app/core/router/app_routes.dart';
import 'package:car_market_app/core/widgets/app_shell.dart';
import 'package:car_market_app/features/auth/view/check_email_screen.dart';
import 'package:car_market_app/features/auth/view/forgot_password_screen.dart';
import 'package:car_market_app/features/auth/view/register_screen.dart';
import 'package:car_market_app/features/auth/view/set_new_password_screen.dart';
import 'package:car_market_app/features/auth/view/sign_in_screen.dart';
import 'package:car_market_app/features/auth/view/splash_screen.dart';
import 'package:car_market_app/features/auth/view/verify_otp_screen.dart';
import 'package:car_market_app/features/auth/view/welcome_screen.dart';
import 'package:car_market_app/features/cart/view/cart_screen.dart';
import 'package:car_market_app/features/catalog/view/accessories_screen.dart';
import 'package:car_market_app/features/catalog/view/car_detail_screen.dart';
import 'package:car_market_app/features/catalog/view/cars_screen.dart';
import 'package:car_market_app/features/catalog/view/merchandise_screen.dart';
import 'package:car_market_app/features/checkout/view/checkout_screen.dart';
import 'package:car_market_app/features/home/view/home_screen.dart';
import 'package:car_market_app/features/home/view/notifications_screen.dart';
import 'package:car_market_app/features/offer/view/make_offer_screen.dart';
import 'package:car_market_app/features/offer/view/offer_accepted_screen.dart';
import 'package:car_market_app/features/offer/view/offer_processing_screen.dart';
import 'package:car_market_app/features/offer/view/offer_rejected_screen.dart';
import 'package:car_market_app/features/payment/view/order_success_screen.dart';
import 'package:car_market_app/features/search/view/search_screen.dart';
import 'package:car_market_app/features/wishlist/view/wishlist_screen.dart';
import 'package:car_market_app/features/orders/view/my_orders_screen.dart';
import 'package:car_market_app/features/profile/view/profile_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => AppShell(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/wishlist',
              builder: (context, state) => const WishlistScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/orders',
              builder: (context, state) => const MyOrdersScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/cars',
      builder: (context, state) => const CarsScreen(),
    ),
    GoRoute(
      path: '/car-detail',
      builder: (context, state) => const CarDetailScreen(),
    ),
    GoRoute(
      path: '/accessories',
      builder: (context, state) => const AccessoriesScreen(),
    ),
    GoRoute(
      path: '/merchandise',
      builder: (context, state) => const MerchandiseScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: '/make-offer',
      builder: (context, state) => const MakeOfferScreen(),
    ),
    GoRoute(
      path: '/offer-processing',
      builder: (context, state) => const OfferProcessingScreen(),
    ),
    GoRoute(
      path: '/offer-accepted',
      builder: (context, state) => const OfferAcceptedScreen(),
    ),
    GoRoute(
      path: '/offer-rejected',
      builder: (context, state) => const OfferRejectedScreen(),
    ),
    GoRoute(
      path: '/order-success',
      builder: (context, state) => const OrderSuccessScreen(),
    ),
    GoRoute(
      path: AppRoutes.checkEmail,
      builder: (_, state) =>
          CheckEmailScreen(email: (state.extra as String?) ?? ''),
    ),
    GoRoute(
      path: AppRoutes.verifyOtp,
      builder: (_, state) =>
          VerifyOtpScreen(email: (state.extra as String?) ?? ''),
    ),
    GoRoute(
      path: AppRoutes.setNewPassword,
      builder: (_, state) => const SetNewPasswordScreen(),
    ),
  ],
);
