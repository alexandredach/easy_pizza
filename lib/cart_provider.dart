import 'package:flutter/material.dart';
import 'Models/pizza.dart';

class CartProvider extends ChangeNotifier {
  final List<Pizza> _cartPizzas = [];
  late double _priceTotal = 0;

  // consulter le contenu du panier (non modifiable)
  List<Pizza> get cartPizzas => _cartPizzas;
  double get priceTotal => _priceTotal;

  // ajouter une pizza
  void add(Pizza pizza) {
    pizza.quantity ++;
    if (_cartPizzas.contains(pizza)) {
      _priceTotal += pizza.price;
    } else {
      _cartPizzas.add(pizza);
      _priceTotal += pizza.price;
      notifyListeners();
    }
  }

  // supprimer une pizza
  void remove(Pizza pizza) {
    if(_cartPizzas.isNotEmpty) {
      // s'il reste une seule de cette pizza, on la retire de la liste
      if(pizza.quantity == 1) {
        pizza.quantity --;
        _priceTotal -= pizza.price;
        _cartPizzas.remove(pizza);
        notifyListeners();
      } else {
        // s'il y a + d'une pizza, on la laisse dans la liste et retire juste une quantité et son prix
        pizza.quantity --;
        _priceTotal -= pizza.price;
        notifyListeners();
      }
    }
  }

  void clearCart() {
    _cartPizzas.clear();
    _priceTotal = 0;
    notifyListeners();
  }

  // // savoir si une pizza est likée
  // bool isLiked(Pizza pizza){
  //   return _cartPizzas.contains(pizza);
  // }

}