import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CartController extends GetxController {
  final RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;

  void addToCart({
    required String imagePath,
    required String title,
    required String price,
  }) {
    // Vérifie si le produit existe déjà
    final existingIndex = cartItems.indexWhere(
      (item) => item['title'] == title,
    );

    if (existingIndex != -1) {
      // Si le produit existe, augmente la quantité
      cartItems[existingIndex]['quantity']++;
      cartItems.refresh();
    } else {
      // Sinon, ajoute le nouveau produit
      cartItems.add({
        'imagePath': imagePath,
        'title': title,
        'price': price,
        'quantity': 1,
      });
    }

    Get.snackbar(
      'Ajouté au panier',
      title,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: Color(0xFF4CAF50),
      colorText: Color(0xFFFFFFFF),
      margin: EdgeInsets.all(16),
    );
  }

  void incrementQuantity(int index) {
    cartItems[index]['quantity']++;
    cartItems.refresh();
  }

  void decrementQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity']--;
      cartItems.refresh();
    }
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }

  double get totalPrice {
    double total = 0.0;
    for (var item in cartItems) {
      final price = double.parse(item['price'].replaceAll('.', ''));
      final quantity = item['quantity'] as int;
      total += price * quantity;
    }
    return total;
  }

  String get formattedTotal {
    final total = totalPrice;
    return total.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}
