import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/application/address_bloc/address_bloc.dart';
import 'package:hrx_store/application/cart_bloc/cart_bloc_bloc.dart';
import 'package:hrx_store/application/categories_bloc/categories_bloc.dart';
import 'package:hrx_store/application/delivery_bloc/delivery_bloc.dart';
import 'package:hrx_store/application/home_bloc/home_bloc.dart';
import 'package:hrx_store/application/order_bloc/order_bloc.dart';
import 'package:hrx_store/application/orderhistory_bloc/orderhistory_bloc.dart';
import 'package:hrx_store/application/product_bloc/product_bloc.dart';
import 'package:hrx_store/application/return_bloc/returns_bloc.dart';
import 'package:hrx_store/application/search_bloc/search_bloc.dart';
import 'package:hrx_store/application/viewall_bloc/viewall_bloc.dart';
import 'package:hrx_store/application/wishlist_bloc/wishlist_bloc.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_splash/screen_splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => CartBlocBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => WishlistBloc(),
        ),
        BlocProvider(
          create: (context) => ViewallBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => AddressBloc(),
        ),
        BlocProvider(
          create: (context) => OrderhistoryBloc(),
        ),
        BlocProvider(
          create: (context) => ReturnsBloc(),
        ),
        BlocProvider(
          create: (context) => DeliveryBloc(),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'HRX Store',
        theme: themeData,
        home: const ScreenSplash(),
      ),
    );
  }
}
