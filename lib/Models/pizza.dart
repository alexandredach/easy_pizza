import 'package:uuid/uuid.dart';

var uuid = const Uuid();
enum Category {rossa, bianca, veggie}

class Pizza {
  String id;
  String name;
  List<String> ingredients;
  double price;
  Category category;
  int quantity;

  Pizza({
    required this.name,
    required this.ingredients,
    required this.price,
    required this.category,
    required this.quantity
  })
      :id = uuid.v4();
}