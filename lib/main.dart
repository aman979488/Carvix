import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:car_market_app/core/router/app_router.dart';
import 'package:car_market_app/core/theme/app_theme.dart';
import 'package:car_market_app/data/services/auth_service.dart';
import 'package:car_market_app/data/repositories/auth_repository.dart';
import 'package:car_market_app/data/repositories/chat_repository.dart';
import 'package:car_market_app/data/repositories/offer_repository.dart';
import 'package:car_market_app/data/repositories/order_repository.dart';
import 'package:car_market_app/data/repositories/product_repository.dart';
import 'package:car_market_app/data/repositories/review_repository.dart';
import 'package:car_market_app/data/repositories/wallet_repository.dart';
import 'package:car_market_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:car_market_app/features/cart/viewmodel/cart_viewmodel.dart';
import 'package:car_market_app/features/catalog/viewmodel/catalog_viewmodel.dart';
import 'package:car_market_app/features/chat/viewmodel/chat_viewmodel.dart';
import 'package:car_market_app/features/checkout/viewmodel/checkout_viewmodel.dart';
import 'package:car_market_app/features/home/viewmodel/home_viewmodel.dart';
import 'package:car_market_app/features/more/viewmodel/more_viewmodel.dart';
import 'package:car_market_app/features/offer/viewmodel/offer_viewmodel.dart';
import 'package:car_market_app/features/orders/viewmodel/orders_viewmodel.dart';
import 'package:car_market_app/features/payment/viewmodel/payment_viewmodel.dart';
import 'package:car_market_app/features/profile/viewmodel/profile_viewmodel.dart';
import 'package:car_market_app/features/reviews/viewmodel/reviews_viewmodel.dart';
import 'package:car_market_app/features/search/viewmodel/search_viewmodel.dart';
import 'package:car_market_app/features/wallet/viewmodel/wallet_viewmodel.dart';
import 'package:car_market_app/features/wishlist/viewmodel/wishlist_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthRepository authRepo = AuthRepositoryImpl(
    AuthService(FirebaseAuth.instance),
    FirebaseFirestore.instance,
  );

  await GoogleSignIn.instance.initialize(
    serverClientId: '540891354796-31cq0690glv0m0l922r072td144ro3fs.apps.googleusercontent.com',
  );
  final productRepo = MockProductRepository();
  final offerRepo = MockOfferRepository();
  final orderRepo = MockOrderRepository();
  final chatRepo = MockChatRepository();
  final walletRepo = MockWalletRepository();
  final reviewRepo = MockReviewRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel(authRepo)),
        ChangeNotifierProvider(create: (_) => HomeViewModel(productRepo)),
        ChangeNotifierProvider(create: (_) => CatalogViewModel(productRepo)),
        ChangeNotifierProvider(create: (_) => SearchViewModel(productRepo)),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => WishlistViewModel()),
        ChangeNotifierProvider(create: (_) => OfferViewModel(offerRepo)),
        ChangeNotifierProvider(create: (_) => CheckoutViewModel()),
        ChangeNotifierProvider(create: (_) => PaymentViewModel()),
        ChangeNotifierProvider(create: (_) => OrdersViewModel(orderRepo)),
        ChangeNotifierProvider(create: (_) => ReviewsViewModel(reviewRepo)),
        ChangeNotifierProvider(create: (_) => ChatViewModel(chatRepo)),
        ChangeNotifierProvider(create: (_) => WalletViewModel(walletRepo)),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => MoreViewModel()),
      ],
      child: const BmwStoreApp(),
    ),
  );
}

class BmwStoreApp extends StatelessWidget {
  const BmwStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BMW Store',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
