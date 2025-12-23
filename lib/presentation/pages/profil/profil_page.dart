import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profil_controller.dart';
import '/utils/custom_bottom_navbar.dart';

class ProfilPage extends GetView<ProfilController> {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(() {
                // Afficher l'indicateur de chargement
                if (controller.isLoading.value && controller.userName.isEmpty) {
                  return _buildLoadingState();
                }

                // Afficher le message d'erreur
                if (controller.errorMessage.isNotEmpty) {
                  return _buildErrorState();
                }

                // Afficher le contenu normal
                return _buildContent();
              }),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentRoute: '/profil'),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(Get.context!).size.height * 0.3),
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 37, 28, 217)),
        ),
        const SizedBox(height: 20),
        const Text(
          'Chargement de votre profil...',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(Get.context!).size.height * 0.3),
        const Icon(
          Icons.error_outline,
          size: 60,
          color: Colors.red,
        ),
        const SizedBox(height: 20),
        Text(
          controller.errorMessage.value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.red,
          ),
        ),
       /* const SizedBox(height: 20),
       ElevatedButton(
          onPressed: () => controller.refreshProfile(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 37, 28, 217),
          ),
          child: const Text(
            'Réessayer',
            style: TextStyle(color: Colors.white),
          ),
        ),*/
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildProfileHeader(),
        const SizedBox(height: 30),
        _buildMenuOptions(),
        const SizedBox(height: 20),
        _buildLogoutButton(),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Obx(() => Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFCE4D8),
            ),
            child: ClipOval(
              child: controller.userAvatar.value.isNotEmpty
                  ? Image.asset(
                controller.userAvatar.value,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildDefaultAvatar();
                },
              )
                  : _buildDefaultAvatar(),
            ),
          )),
          const SizedBox(height: 16),
          // Nom
          Obx(() => Text(
            controller.userName.value.isNotEmpty
                ? controller.userName.value
                : 'Utilisateur',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          )),
          const SizedBox(height: 4),
          // Email
          Obx(() => Text(
            controller.userEmail.value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontFamily: 'Poppins',
            ),
          )),
         /* const SizedBox(height: 16),
          // Bouton pour rafraîchir
          IconButton(
            onPressed: () => controller.refreshProfile(),
            icon: const Icon(Icons.refresh, color: Colors.blue),
            tooltip: 'Rafraîchir',
          ),*/
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return const Icon(
      Icons.person,
      size: 50,
      color: Colors.grey,
    );
  }

  Widget _buildMenuOptions() {
    return Column(
      children: controller.menuOptions.map((option) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildMenuItem(
            icon: _getIconData(option['icon']),
            title: option['title'],
            subtitle: option['subtitle'],
            onTap: () => controller.navigateToOption(option['route']),
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

  Widget _buildLogoutButton() {
    return Obx(() => InkWell(
      onTap: controller.isLoading.value ? null : () => controller.logout(),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: controller.isLoading.value ? Colors.grey : const Color(0xFFE53935),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (controller.isLoading.value)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            else
              const Icon(
                Icons.logout,
                color: Colors.white,
                size: 20,
              ),
            const SizedBox(width: 8),
            Text(
              controller.isLoading.value ? 'Déconnexion...' : 'Déconnexion',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    ));
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