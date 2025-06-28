import 'package:e_shop_app/provider/auth.dart';
import 'package:e_shop_app/screens/auth_screen.dart';
import 'package:e_shop_app/screens/products_overview_screen.dart';
import 'package:e_shop_app/screens/splash_screen.dart';

import './screens/edit_products_screen.dart';
import './screens/order_screen.dart';
import './screens/user_products_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './provider/orders.dart';
import './provider/cart_provider.dart';
import './screens/cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './provider/products_provider.dart';
import './screens/product_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Comment /Provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders('', [], ''),
          update:
              (ctx, auth, previousOrders) => Orders(
                auth.token ?? '',
                previousOrders == null ? [] : previousOrders.orders,
                auth.userId ?? '',
              ),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: (ctx) => ProductsProvider('', '', []),
          update:
              (ctx, auth, previousProducts) => ProductsProvider(
                auth.token ?? '',
                auth.userId ?? '',
                previousProducts == null ? [] : previousProducts.items,
              ),
        ),
      ],
      child: Consumer<Auth>(
        builder:
            (ctx, auth, _) => MaterialApp(
              title: 'MyShop',
              theme: ThemeData(
                hoverColor: Colors.purple,
                primaryColor: Colors.deepOrange,
              ),
              home:
                  auth.isAuth
                      ? ProductsOverviewScreen()
                      : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, authResultSnapshot) {
                          if (authResultSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SplashScreen();
                          } else {
                            if (authResultSnapshot.hasError) {
                              // Log the error for debugging
                              print(
                                'Error during auto login: ${authResultSnapshot.error}',
                              );
                            }
                            return AuthScreen();
                          }
                        },
                      ),
              routes: {
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                CartScreen.routeName: (ctx) => CartScreen(),
                OrderScreen.routeName: (ctx) => OrderScreen(),
                UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                EditProductsScreen.routeName: (ctx) => EditProductsScreen(),
              },
            ),
      ),
    );
  }
}
