import 'package:get/get.dart';

class CatalogueController extends GetxController {
  // Liste des catégories
  final List<String> categories = [
    'Tout',
    'Smartphones',
    'Ordinateurs',
    'Consoles'
  ];

  // Catégorie sélectionnée (observable pour réactivité)
  final selectedCategory = 'Tout'.obs;

  // Texte de recherche
  final searchQuery = ''.obs;

  /// Vérifie si une catégorie est sélectionnée
  bool isSelected(String category) {
    return selectedCategory.value == category;
  }

  /// Change la catégorie sélectionnée
  void selectCategory(String category) {
    selectedCategory.value = category;
    update(); // Notifie GetBuilder
    print('✅ Catégorie sélectionnée : $category');
  }

  /// Met à jour le texte de recherche
  void updateSearch(String query) {
    searchQuery.value = query;
    print('🔍 Recherche : $query');
  }

  /// Retourne les catégories de produits à afficher selon le filtre
  List<String> getCategoriesToDisplay() {
    if (selectedCategory.value == 'Tout') {
      return ['Smartphones', 'Ordinateurs', 'Consoles de Jeux'];
    } else if (selectedCategory.value == 'Smartphones') {
      return ['Smartphones'];
    } else if (selectedCategory.value == 'Ordinateurs') {
      return ['Ordinateurs'];
    } else if (selectedCategory.value == 'Consoles') {
      return ['Consoles de Jeux'];
    }
    return [];
  }

  @override
  void onInit() {
    super.onInit();
    print('🚀 CatalogueController initialisé');
  }

  @override
  void onClose() {
    print('🔴 CatalogueController fermé');
    super.onClose();
  }
}
