import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'accueil_controller.dart';
import '/utils/product_card.dart';
import '/utils/custom_search_bar.dart';
import '/utils/custom_bottom_navbar.dart';

class AccueilPage extends GetView<AccueilController> {
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentRoute: '/home'),
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
    return const CustomSearchBar();
  }

  Widget _buildPromoCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: controller.pageController,
            onPageChanged: (index) {
              if (controller.pageController.hasClients) {
                controller.currentPromoIndex.value = index;
              }
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
          height: 320,
          child: ListView.builder(
            controller: controller.bestSellersScrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 10),
            itemCount: controller.bestSellers.length,
            itemBuilder: (context, index) {
              final product = controller.bestSellers[index];
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SizedBox(
                  width: 180,
                  child: ProductCard(
                    imagePath: product['imagePath'] ?? 'design/assets/Iphone14.png',
                    title: product['title'] ?? '',
                    price: product['price'] ?? '0',
                    rating: (product['rating'] ?? 0.0).toDouble(),
                    deliveryInfo: product['deliveryInfo'] ?? '',
                    freeDelivery: product['freeDelivery'] ?? false,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Indicateur de scroll horizontal
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<AccueilController>(
            builder: (ctrl) => Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final indicatorWidth = constraints.maxWidth * 0.3; // 30% de la largeur
                  final maxPosition = constraints.maxWidth - indicatorWidth;
                  final position = ctrl.scrollProgress.value * maxPosition;
                  
                  return Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 100),
                        left: position,
                        child: Container(
                          width: indicatorWidth,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF5B67FF),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
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
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              fontSize: 18,
              color: Colors.black,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x99251CD9), // #251CD9 avec 60% d'opacité
            Color(0xFF251CD9), // #251CD9 avec 100% d'opacité
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF251CD9).withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 3),
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