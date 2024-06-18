import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../cart_provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

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
          title: const Text("Panier"),
        ),
        body: Center(
          child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return Stack(
                  children: [
                     ListView.builder(
                      itemCount: cartProvider.cartPizzas.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: const Image(
                              image: AssetImage('img/pizza.png'),
                              width: 50,
                            ),
                            title: Text(cartProvider.cartPizzas[index].name),
                            subtitle: Text("${cartProvider.cartPizzas[index].ingredients.length
                                .toString()} ingrédients"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("${cartProvider.cartPizzas[index].price.toStringAsFixed(2)} €"),
                                Card(
                                    color: Colors.grey,
                                    child: SizedBox(
                                      height: 50,
                                      width: 110,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: () {
                                              setState(() {
                                                cartProvider.remove(cartProvider.cartPizzas[index]);
                                              });
                                            },
                                          ),
                                          Text('${cartProvider.cartPizzas[index].quantity}'),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              setState(() {
                                                cartProvider.add(cartProvider.cartPizzas[index]);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ],
                            )
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0, // Positionne en bas
                      left: 0,
                      right: 0,
                      child: Container( // Ou SafeArea pour gérer l'encoche
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_shopping_cart),
                              onPressed:(){
                                setState((){
                                  cartProvider.clearCart();
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "TOTAL",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                                ),
                                Text(
                                  "${cartProvider.priceTotal.toStringAsFixed(2)} €",
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                                ),
                              ],
                            ),
                          ]
                        ),
                      ),
                    ),
                  ]
                );
              }
          ),
        )
    );
  }
}