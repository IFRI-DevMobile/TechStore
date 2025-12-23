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

  // Liste des meilleures ventes - TOUTES LES VALEURS DÉFINIES
  final List<Map<String, dynamic>> bestSellers = [
    {
      'title': 'iPhone 14 Pro Max | 1To |16GB RAM',
      'price': '702.500',
      'rating': 4.6,
      'reviews': '(4.6)',
      'deliveryInfo': 'Livraison gratuite',
    },
    {
      'title': 'JBL Charge 6 | Portable Waterproof',
      'price': '52.500',
      'rating': 3.7,
      'reviews': '(3.7)',
      'deliveryInfo': 'Livraison à partir de 1.500 XOF/km',
    },
    {
      'title': 'JBL Charge 8 | Portable Waterproof',
      'price': '52.500',
      'rating': 2,
      'reviews': '(3.7)',
      'deliveryInfo': 'Livraison à partir de 1.500 XOF/km',
    },
    // Ajoutez plus d'éléments pour voir l'effet du défilement
    {
      'title': 'Samsung Galaxy S23 Ultra',
      'price': '650.000',
      'rating': 4.8,
      'reviews': '(4.8)',
      'deliveryInfo': 'Livraison gratuite',
    },
    {
      'title': 'MacBook Pro M2',
      'price': '1.200.000',
      'rating': 4.9,
      'reviews': '(4.9)',
      'deliveryInfo': 'Livraison à partir de 2.500 XOF/km',
    },
  ];

  // Liste des catégories
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
    // Écouter le défilement de la liste des meilleures ventes
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