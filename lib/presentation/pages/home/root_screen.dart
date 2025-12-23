import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'accueil_controller.dart';
import 'accueil_page.dart';
import '../catalogue/catalogue_page.dart';
import '../profil/profil_page.dart';
import '../../../navigation.dart';

class RootScreen extends StatelessWidget {
  RootScreen({super.key});

  final AccueilController controller = Get.find<AccueilController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.selectedIndex.value) {
          case 0:
            return AccueilPage();
          case 1:
            return const CataloguePage();
          case 2:
            return const ProfilPage();
          case 3:
            return _buildPlaceholderPage("Panier", Icons.shopping_cart, controller);
          case 4:
            return _buildPlaceholderPage("À Propos", Icons.info, controller);
          default:
            return AccueilPage();
        }
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: BottomAppBar(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: Colors.white,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Accueil',
                  isActive: controller.selectedIndex.value == 0,
                  onTap: () => controller.changeTabIndex(0),
                ),
                _buildNavItem(
                  icon: Icons.category_outlined,
                  activeIcon: Icons.category,
                  label: 'Catalogue',
                  isActive: controller.selectedIndex.value == 1,
                  onTap: () {
                    Get.toNamed(Routes.CATALOGUE);
                  },
                ),
                _buildNavItemWithAvatar(
                  label: 'Mon profil',
                  isActive: controller.selectedIndex.value == 2,
                  onTap: () {
                    Get.toNamed(Routes.PROFIL);
                  },
                ),
                _buildNavItem(
                  icon: Icons.shopping_cart_outlined,
                  activeIcon: Icons.shopping_cart,
                  label: 'Panier',
                  isActive: controller.selectedIndex.value == 3,
                  onTap: () => controller.changeTabIndex(3),
                ),
                _buildNavItem(
                  icon: Icons.info_outline,
                  activeIcon: Icons.info,
                  label: 'À propos',
                  isActive: controller.selectedIndex.value == 4,
                  onTap: () => controller.changeTabIndex(4),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ligne bleue au-dessus si actif
          Container(
            height: 3,
            width: 40,
            color: isActive ? const Color(0xFF5B67FF) : Colors.transparent,
            margin: const EdgeInsets.only(bottom: 5),
          ),
          Icon(
            isActive ? activeIcon : icon,
            color: isActive ? const Color(0xFF5B67FF) : Colors.grey,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isActive ? const Color(0xFF5B67FF) : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItemWithAvatar({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ligne bleue au-dessus si actif
          Container(
            height: 3,
            width: 40,
            color: isActive ? const Color(0xFF5B67FF) : Colors.transparent,
            margin: const EdgeInsets.only(bottom: 5),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? const Color(0xFF5B67FF) : Colors.grey,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'design/assets/Avatar1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isActive ? const Color(0xFF5B67FF) : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderPage(String title, IconData icon, AccueilController controller) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => controller.changeTabIndex(0),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: const Color(0xFF5B67FF).withOpacity(0.5)),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Cette page est en cours de développement",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => controller.changeTabIndex(0),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B67FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                "Retour à l'accueil",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}