import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccueilController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxBool isDarkMode = false.obs;
  final RxInt currentPromoIndex = 0.obs;
  final PageController pageController = PageController();
  final ScrollController bestSellersScrollController = ScrollController();
  final RxDouble scrollProgress = 0.0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  void setTheme(bool darkMode) {
    isDarkMode.value = darkMode;
  }

  void calculateScrollProgress() {
    if (bestSellersScrollController.hasClients) {
      final maxScroll = bestSellersScrollController.position.maxScrollExtent;
      final currentScroll = bestSellersScrollController.position.pixels;

      if (maxScroll > 0) {
        scrollProgress.value = currentScroll / maxScroll;
      } else {
        scrollProgress.value = 0.0;
      }
    }
  }

  final List<Map<String, dynamic>> bestSellers = [
    {
      'imagePath': 'design/assets/Iphone14.png',
      'title': 'iPhone 14 Pro Max | 1To | 16GB RAM',
      'price': '702.500',
      'rating': 4.6,
      'reviews': '(128)',
      'deliveryInfo': 'Livraison gratuite',
      'freeDelivery': true,
    },
    {
      'imagePath': 'design/assets/SamsungA16.png',
      'title': 'Samsung Galaxy A16 5G A Series',
      'price': '80.800',
      'rating': 3.7,
      'reviews': '(64)',
      'deliveryInfo': 'Livraison à partir de 1.700 XOF/km',
      'freeDelivery': false,
    },
    {
      'imagePath': 'design/assets/Victus15.png',
      'title': 'HP Victus 15 RTX 2050 | 16GB DDR5',
      'price': '702.500',
      'rating': 4.8,
      'reviews': '(89)',
      'deliveryInfo': 'Livraison gratuite',
      'freeDelivery': true,
    },
    {
      'imagePath': 'design/assets/Macbook.png',
      'title': 'Apple 2025 MacBook Air 256GB SSD',
      'price': '604.800',
      'rating': 4.8,
      'reviews': '(42)',
      'deliveryInfo': 'Livraison à partir de 2.500 XOF/km',
      'freeDelivery': false,
    },
    {
      'imagePath': 'design/assets/Macbook.png',
      'title': 'Apple 2025 MacBook Air 256GB SSD',
      'price': '604.800',
      'rating': 4.8,
      'reviews': '(42)',
      'deliveryInfo': 'Livraison à partir de 2.500 XOF/km',
      'freeDelivery': false,
    },
    {
      'imagePath': 'design/assets/Macbook.png',
      'title': 'Apple 2025 MacBook Air 256GB SSD',
      'price': '604.800',
      'rating': 4.8,
      'reviews': '(42)',
      'deliveryInfo': 'Livraison à partir de 2.500 XOF/km',
      'freeDelivery': false,
    },
    {
      'imagePath': 'design/assets/Ps5.png',
      'title': 'PlayStation 5 1TB | Fortnite Flowering',
      'price': '485.800',
      'rating': 4.8,
      'reviews': '(156)',
      'deliveryInfo': 'Livraison à partir de 3.000 XOF/km',
      'freeDelivery': false,
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {'title': 'Casques'},
    {'title': 'Laptop'},
    {'title': 'Téléphones'},
    {'title': 'Consoles de Jeux'},
    {'title': 'Casques XR'},
  ];

  @override
  void onInit() {
    super.onInit();
    bestSellersScrollController.addListener(() {
      calculateScrollProgress();
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    bestSellersScrollController.dispose();
    super.onClose();
  }
}

class AccueilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccueilController());
  }
}