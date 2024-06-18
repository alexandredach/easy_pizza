import 'package:flutter/material.dart';

class LikesProvider extends ChangeNotifier {
  final List<String> _likedPizzas = [];

  // consulter la liste
  List<String> get likedPizzas => _likedPizzas;

  // ajouter une pizza selon son id
  void add(String pizzaId) {
    _likedPizzas.add(pizzaId);
    notifyListeners();
  }

  // supprimer une pizza selon id
  void remove(String pizzaId) {
    _likedPizzas.remove(pizzaId);
    notifyListeners();
  }

  // savoir si une pizza est likée selon son id
  bool isLiked(String pizzaId){
    return _likedPizzas.contains(pizzaId);
  }

}