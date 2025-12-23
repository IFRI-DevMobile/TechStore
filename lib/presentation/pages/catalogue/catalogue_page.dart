import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'catalogue_controller.dart';
import '/utils/custom_search_bar.dart';
import '/utils/product_card.dart';
import '/utils/custom_bottom_navbar.dart';

class CataloguePage extends GetView<CatalogueController> {
  const CataloguePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Force la création du controller s'il n'existe pas
    Get.put(CatalogueController());
    
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildSearchBar(),
              _buildCategoriesLabel(),
              _buildCategoriesChips(),
              Expanded(
                child: GetBuilder<CatalogueController>(
                  builder: (ctrl) => ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      ...ctrl.getCategoriesToDisplay().map(
                        (category) => _buildCategorySection(category),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentRoute: '/catalogue'),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Catalogue',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Découvrez encore plus de produits High-Tech',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return CustomSearchBar(
      onChanged: controller.updateSearch,
    );
  }

  Widget _buildCategoriesLabel() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 40,
        child: GetBuilder<CatalogueController>(
          builder: (ctrl) => ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: ctrl.categories.length,
            itemBuilder: (context, index) {
              final category = ctrl.categories[index];
              final isSelected = ctrl.isSelected(category);

              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () => ctrl.selectCategory(category),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color.fromARGB(255, 80, 71, 215)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String categoryName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoryName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Colors.black,
              ),
            ),
            const Icon(Icons.tune, color: Colors.black, size: 24),
          ],
        ),
        const SizedBox(height: 15),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: _getProductsForCategory(categoryName),
        ),
      ],
    );
  }

  List<Widget> _getProductsForCategory(String category) {
    if (category == 'Smartphones') {
      return [
        ProductCard(
          imagePath: 'design/assets/Iphone14.png',
          title: 'iPhone 14 Pro Max 1To | 16Gb RAM',
          rating: 4.8,
          price: '702.500',
          deliveryInfo: 'Livraison à partir de 1.700 F/km',
          freeDelivery: false,
        ),
        ProductCard(
          imagePath: 'design/assets/SamsungA16.png',
          title: 'Samsung Galaxy A16 5G A Series',
          rating: 3.7,
          price: '80.800',
          deliveryInfo: 'Livraison à partir de 1.700 F/km',
          freeDelivery: false,
        ),
      ];
    } else if (category == 'Ordinateurs') {
      return [
        ProductCard(
          imagePath: 'design/assets/Victus15.png',
          title: 'HP Victus 15 RTX 2050 | 16GB DDR5',
          rating: 4.8,
          price: '702.500',
          deliveryInfo: 'Livraison gratuite',
          freeDelivery: true,
        ),
        ProductCard(
          imagePath: 'design/assets/Macbook.png',
          title: 'Apple 2025 MacBook Air 256GB SSD',
          rating: 4.8,
          price: '604.800',
          deliveryInfo: 'Livraison à partir de 2.500 F/km',
          freeDelivery: false,
        ),
      ];
    } else if (category == 'Consoles de Jeux') {
      return [
        ProductCard(
          imagePath: 'design/assets/Ps4.png',
          title: 'Sony PlayStation 4 1TB Gaming Console',
          rating: 4.8,
          price: '101.500',
          deliveryInfo: 'Livraison gratuite',
          freeDelivery: true,
        ),
        ProductCard(
          imagePath: 'design/assets/Ps5.png',
          title: 'PlayStation 5 1TB | Fortnite Flowering',
          rating: 4.8,
          price: '485.800',
          deliveryInfo: 'Livraison à partir de 3.000 F/km',
          freeDelivery: false,
        ),
      ];
    }
    return [];
  }
}
