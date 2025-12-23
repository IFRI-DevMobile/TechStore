import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'accueil_controller.dart';

class AccueilPage extends GetView<AccueilController> {
  @override
  final AccueilController controller = Get.put(AccueilController());
  AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 25),
              _buildPromoCarousel(),
              const SizedBox(height: 30),
              _buildBestSellersSection(),
              const SizedBox(height: 30),
              _buildCategoriesSection(),
              const SizedBox(height: 30),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Accueil",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Découvrez nos produits tech",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            const SizedBox(width: 15),
            Icon(
              Icons.search,
              color: Colors.grey[400],
              size: 22,
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'ex : iPhone 15 pro max',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: controller.pageController,
            onPageChanged: (index) {
              controller.currentPromoIndex.value = index;
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildPromoBanner();
            },
          ),
        ),
        const SizedBox(height: 10),
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
                (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: controller.currentPromoIndex.value == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: controller.currentPromoIndex.value == index
                    ? const Color(0xFF5B67FF)
                    : Colors.grey[400],
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'design/assets/Iphone14.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Badge promo en haut à droite
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: const Text(
                "-50%",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Icône panier en bas à gauche
          Positioned(
            left: 15,
            bottom: 15,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.shopping_cart,
                  color: Color(0xFF5B67FF),
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestSellersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "MEILLEURES VENTES",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 310,
          child: ListView.builder(
            controller: controller.bestSellersScrollController, // Ajout du contrôleur
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 10),
            itemCount: controller.bestSellers.length,
            itemBuilder: (context, index) {
              final product = controller.bestSellers[index];
              return _buildProductCard(
                title: product['title'] ?? '',
                price: product['price'] ?? '0',
                rating: (product['rating'] ?? 0.0).toDouble(),
                reviews: product['reviews'] ?? '(0)',
                deliveryInfo: product['deliveryInfo'] ?? '',
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        // Barre de progression fonctionnelle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() => ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: controller.scrollProgress.value,
              backgroundColor: Colors.grey[300],
              color: const Color(0xFF5B67FF), // Couleur de progression
              minHeight: 4,
            ),
          )),
        ),
      ],
    );
  }

  Widget _buildProductCard({
    required String title,
    required String price,
    required double rating,
    required String reviews,
    required String deliveryInfo,
  }) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Image du produit
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.grey[100],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                'design/assets/Iphone14.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                // Étoiles et avis
                Row(
                  children: [
                    _buildStarRating(rating),
                    const SizedBox(width: 4),
                    Text(
                      reviews,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Prix
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: price,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: ' XOF',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Info livraison
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    deliveryInfo,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(
            Icons.star,
            size: 13,
            color: Colors.amber,
          );
        } else if (index < rating) {
          return const Icon(
            Icons.star_half,
            size: 13,
            color: Colors.amber,
          );
        } else {
          return Icon(
            Icons.star_border,
            size: 13,
            color: Colors.grey[400],
          );
        }
      }),
    );
  }

  Widget _buildCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "NOS CATEGORIES DE PRODUITS",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.spaceBetween,
            children: controller.categories.map((category) {
              return _buildCategoryButton(
                title: category['title'] ?? '',
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton({required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0x98251CD9), // Couleur de début (plus claire en haut)
            Color(0xFF251CD9), // Couleur de fin (plus foncée en bas)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5B67FF).withOpacity(0.4), // Opacité augmentée
            spreadRadius: 0,
            blurRadius: 10, // Flou augmenté
            offset: const Offset(0, 4), // Décalage léger vers le bas
          ),
        ],
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}