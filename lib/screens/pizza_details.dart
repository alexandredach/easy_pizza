import 'package:easy_pizza/cart_provider.dart';
import 'package:easy_pizza/likes_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../Models/pizza.dart';

class PizzaDetails extends StatelessWidget {
  final Pizza pizza;
  const PizzaDetails({super.key, required this.pizza});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
          context.go('/');
            },
          ),
        title: Text('Pizza ${pizza.name}'),
        actions: <Widget> [
          IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                context.go('/cart');
              }
          ),
        ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pizza.name,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.orange
                ),
              ),
            const Image(
                image: AssetImage('img/pizza.png'),
                width: 350,
                fit: BoxFit.contain,
              ),
            Text('Prix : ${pizza.price.toStringAsFixed(2)} €', style: const TextStyle(fontSize: 25)),
            Text('Ingrédients : ${pizza.ingredients.join(', ')}', style: const TextStyle(fontSize: 15)),
            Text('Catégorie : ${pizza.category}', style: const TextStyle(fontSize: 15)),

            Consumer<LikesProvider>(
                builder: (context, likesProvider, child) {
                  return IconButton(
                    icon: const Icon(Icons.favorite, size: 40),
                    color: likesProvider.isLiked(pizza.id) ?
                    const Color.fromRGBO(255, 0, 50, 1) : const Color.fromRGBO(
                        0, 0, 0, 0.25),
                    onPressed: () {
                      if (likesProvider.isLiked(pizza.id)) {
                        likesProvider.remove(pizza.id);
                      } else {
                        likesProvider.add(pizza.id);
                      }
                    },
                  );
                }
            ),
            Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  return IconButton(
                    icon: const Icon(Icons.add_shopping_cart, size: 40),
                    onPressed: () {
                      cartProvider.add(pizza);
                      }
                  );
                }
            )
          ]
        )
      )
    );
  }
}
