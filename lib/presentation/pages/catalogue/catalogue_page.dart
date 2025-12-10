import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'catalogue_controller.dart';

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
        bottomNavigationBar: _buildBottomNavBar(),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        onChanged: controller.updateSearch,
        decoration: InputDecoration(
          hintText: 'ex : iPhone 15 pro max',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            fontFamily: 'Poppins',
            fontStyle: FontStyle.italic,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 22),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Color.fromARGB(121, 51, 51, 51),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
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
        _buildProductCard(
          'design/assets/Iphone14.png',
          'iPhone 14 Pro Max 1To | 16Gb RAM',
          4.8,
          '702.500',
          'Livraison à partir de 1.700 F/km',
          false,
        ),
        _buildProductCard(
          'design/assets/SamsungA16.png',
          'Samsung Galaxy A16 5G A Series',
          3.7,
          '80.800',
          'Livraison à partir de 1.700 F/km',
          false,
        ),
      ];
    } else if (category == 'Ordinateurs') {
      return [
        _buildProductCard(
          'design/assets/Victus15.png',
          'HP Victus 15 RTX 2050 | 16GB DDR5',
          4.8,
          '702.500',
          'Livraison gratuite',
          true,
        ),
        _buildProductCard(
          'design/assets/Macbook.png',
          'Apple 2025 MacBook Air 256GB SSD',
          4.8,
          '604.800',
          'Livraison à partir de 2.500 F/km',
          false,
        ),
      ];
    } else if (category == 'Consoles de Jeux') {
      return [
        _buildProductCard(
          'design/assets/Ps4.png',
          'Sony PlayStation 4 1TB Gaming Console',
          4.8,
          '101.500',
          'Livraison gratuite',
          true,
        ),
        _buildProductCard(
          'design/assets/Ps5.png',
          'PlayStation 5 1TB | Fortnite Flowering',
          4.8,
          '485.800',
          'Livraison à partir de 3.000 F/km',
          false,
        ),
      ];
    }
    return [];
  }

  Widget _buildProductCard(
    String imagePath,
    String name,
    double rating,
    String price,
    String deliveryInfo,
    bool freeDelivery,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[100],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[400],
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      if (index < rating.floor()) {
                        return const Icon(Icons.star, color: Color(0xFFFFC107), size: 14);
                      } else if (index < rating) {
                        return const Icon(Icons.star_half, color: Color(0xFFFFC107), size: 14);
                      } else {
                        return Icon(Icons.star_border, color: Colors.grey[400], size: 14);
                      }
                    }),
                    const SizedBox(width: 4),
                    Text(
                      '($rating)',
                      style: TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[600],
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.top,
                        child: Transform.translate(
                          offset: const Offset(1, -4),
                          child: Text(
                            'XOF',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  deliveryInfo,
                  style: TextStyle(
                    fontSize: 9,
                    color: freeDelivery
                        ? const Color(0xFF4CAF50)
                        : Colors.grey[600],
                    fontFamily: 'Poppins',
                    fontWeight: freeDelivery ? FontWeight.w600 : FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, 'Accueil', false),
          _buildNavItem(Icons.storefront, 'Catalogue', true),
          _buildNavItem(Icons.person_outline, 'Mon profil', false),
          _buildNavItem(Icons.shopping_cart_outlined, 'Panier', false),
          _buildNavItem(Icons.attach_money, 'A propos', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    final routes = {
      'Accueil': '/home',
      'Catalogue': '/catalogue',
      'Mon profil': '/profil',
      'Panier': '/cart',
      'A propos': '/about',
    };

    return InkWell(
      onTap: () {
        if (!isActive && routes.containsKey(label)) {
          Get.toNamed(routes[label]!);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF5B4EFF) : Colors.grey,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? const Color(0xFF5B4EFF) : Colors.grey,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
