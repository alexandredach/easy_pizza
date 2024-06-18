import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_pizza/Data/pizzas.dart' as db;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../Models/discount.dart';
import '../likes_provider.dart';

class PizzasMaster extends StatelessWidget {
  const PizzasMaster({super.key});

  @override
  Widget build(BuildContext context) {

    Future<void> subscribeToDiscounts() async {
      await dotenv.load(fileName: ".env");

      final Uri wsUrl = Uri.parse(dotenv.env["WEBSOCKET_API"]!);
      final channel = WebSocketChannel.connect(wsUrl);

      await channel.ready;

      //abonnement au serveur websocket
      channel.sink.add(
        jsonEncode(
          {"collection": "discounts", "type": "subscribe"},
        ),
      );

      channel.stream.listen((data) {
        final Map<String, dynamic> response = jsonDecode(data);

        // print(response);

        if(response["type"]=="subscription") {
          // print(response["data"][0]);
          final Discount lastDiscount = Discount.fromJson(response["data"][0]);

          final snackBar = SnackBar(
            content: Text(lastDiscount.code),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }, onError: (error) {
        if (kDebugMode) {
          print(error);
        }
      });
    }

    subscribeToDiscounts();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
        title: const Text("Toutes nos pizzas"),
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
        child: Consumer<LikesProvider>(
            builder: (context, likesProvider, child)  {
              return ListView.builder(
                itemCount: db.pizzas.length,
                itemBuilder: (BuildContext context, int index){
                  final pizza = db.pizzas[index];
                  return ListTile(
                    leading: const Image(
                      image: AssetImage('img/pizza.png'),
                      width: 80,
                    ),
                    title: Text(db.pizzas[index].name),
                    subtitle: Text("${db.pizzas[index].ingredients.length.toString()} ingrédients"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${db.pizzas[index].price.toStringAsFixed(2)} € "),
                        Icon(
                          Icons.favorite,
                          size: 40,
                          color: likesProvider.isLiked(pizza.id) ?
                          const Color.fromRGBO(255, 0, 50, 1) : const Color.fromRGBO(0, 0, 0, 0.25),
                        ),
                      ],
                    ),
                    onTap: () => context.go('/details/${db.pizzas[index].id}'),
                  );
                },
              );
            }
        ),
      )
    );
  }
}
