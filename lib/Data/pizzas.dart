import '../Models/pizza.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

final List<Pizza> pizzas = [
  Pizza(name: "Margherita", ingredients: ["tomate", "mozzarella", "basilic"], price: 7, category: Category.rossa, quantity: 0),
  Pizza(name: "Quatre fromages", ingredients: ["tomate", "fromage"], price: 8.5, category: Category.bianca, quantity: 0),
  Pizza(name: "Bolognaise", ingredients: ["tomate", "champignons", "boeuf", "oeuf"], price: 9, category: Category.rossa, quantity: 0),
  Pizza(name: "Flamm", ingredients: ["crème", "oignons", "lardons"], price: 7.5, category: Category.bianca, quantity: 0),
  Pizza(name: "Regina", ingredients: ["tomate", "mozarella", "jambon", "champignons", "olives"], price: 8, category: Category.rossa, quantity: 0),
  Pizza(name: "Calzone", ingredients: ["tomate", "mozarella", "jambon", "champignons"], price: 6.5, category: Category.rossa, quantity: 0),
  Pizza(name: "Romana", ingredients: ["tomate", "mozarella", "anchois", "câpres", "origan"], price: 6.9, category: Category.rossa, quantity: 0),
  Pizza(name: "Capricciosa", ingredients: ["jambon", "champignons", "artichauts", "olives"], price: 7.2, category: Category.rossa, quantity: 0),
  Pizza(name: "Hawaïenne", ingredients: ["jambon", "ananas", "fromage"], price: 7.9, category: Category.bianca, quantity: 0),
  Pizza(name: "Végétarienne", ingredients: ["poivrons", "champignons", "oignons", "tomate", "olives", "fromage"], price: 5.9, category: Category.veggie, quantity: 0),
];
