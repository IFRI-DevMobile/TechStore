import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavBar extends StatelessWidget {
  final String currentRoute;

  const CustomBottomNavBar({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
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
          _buildNavItem(Icons.home_outlined, 'Accueil', '/home'),
          _buildNavItem(Icons.storefront, 'Catalogue', '/catalogue'),
          _buildAvatarNavItem('Mon profil', '/profil'),
          _buildNavItem(Icons.shopping_cart_outlined, 'Panier', '/cart'),
          _buildNavItem(Icons.attach_money, 'A propos', '/about'),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, String route) {
    final isActive = currentRoute == route;

    return InkWell(
      onTap: () {
        if (!isActive) {
          _navigateWithTransition(route);
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

  Widget _buildAvatarNavItem(String label, String route) {
    final isActive = currentRoute == route;

    return InkWell(
      onTap: () {
        if (!isActive) {
          _navigateWithTransition(route);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? const Color(0xFF5B67FF) : Colors.transparent,
                width: 2.5,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'design/assets/Avatar1.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.person,
                    size: 24,
                    color: isActive ? const Color(0xFF5B67FF) : Colors.grey,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? const Color(0xFF5B67FF) : Colors.grey,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  void _navigateWithTransition(String targetRoute) {
    Get.offNamed(targetRoute);
  }
}
