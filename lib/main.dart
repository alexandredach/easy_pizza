import 'package:easy_pizza/cart_provider.dart';
import 'package:easy_pizza/Data/pizzas.dart';
import 'package:easy_pizza/likes_provider.dart';
import 'package:easy_pizza/screens/cart.dart';
import 'package:easy_pizza/screens/pizza_details.dart';
import 'package:easy_pizza/screens/pizzas_master.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'Models/pizza.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PizzasMaster(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final pizzaId = state.pathParameters['id'];
        final pizzaToFind = pizzas.where((p) => p.id == (pizzaId!));
        final Pizza p = pizzaToFind.first;
        return PizzaDetails(pizza: p);
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const Cart(),
    ),
  ],
);

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LikesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        )
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
              routerConfig: _router,
    );
  }
}