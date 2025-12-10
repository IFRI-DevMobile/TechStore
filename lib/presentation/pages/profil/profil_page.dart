import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profil_controller.dart';

class ProfilPage extends GetView<ProfilController> {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Assure l'initialisation du controller
    final ctrl = Get.put(ProfilController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildProfileHeader(ctrl),
                const SizedBox(height: 30),
                _buildMenuOptions(ctrl),
                const SizedBox(height: 20),
                _buildLogoutButton(ctrl),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildProfileHeader(ProfilController ctrl) {
    return Obx(() => Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFCE4D8),
            ),
            child: ClipOval(
              child: Image.asset(
                ctrl.userAvatar.value,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset("design/assets/Avatar1.png");
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Nom
          Text(
            ctrl.userName.value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          // Email
          Text(
            ctrl.userEmail.value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildMenuOptions(ProfilController ctrl) {
    return Column(
      children: ctrl.menuOptions.map((option) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildMenuItem(
            icon: _getIconData(option['icon']),
            title: option['title'],
            subtitle: option['subtitle'],
            onTap: () => ctrl.navigateToOption(option['route']),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icône
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.grey[700],
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Texte
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            // Flèche
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(ProfilController ctrl) {
    return InkWell(
      onTap: ctrl.logout,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFE53935),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.logout,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            const Text(
              'Deconnexion',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
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
          _buildNavItem(Icons.home_outlined, 'Accueil', false, '/home'),
          _buildNavItem(Icons.storefront, 'Catalogue', false, '/catalogue'),
          _buildNavItem(Icons.person, 'Mon profil', true, '/profil'),
          _buildNavItem(Icons.shopping_cart_outlined, 'Panier', false, '/cart'),
          _buildNavItem(Icons.attach_money, 'A propos', false, '/about'),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, String route) {
    return InkWell(
      onTap: () {
        if (!isActive) {
          Get.toNamed(route);
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

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'package':
        return Icons.inventory_2_outlined;
      case 'settings':
        return Icons.settings_outlined;
      case 'person':
        return Icons.person_outline;
      default:
        return Icons.help_outline;
    }
  }
}
