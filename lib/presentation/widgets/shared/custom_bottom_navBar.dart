import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          label: 'Inicio',
          icon: Icon(Icons.home_filled)),
        
        BottomNavigationBarItem(
          label: 'Categorias',
          icon: Icon(Icons.add_box_sharp)),
        BottomNavigationBarItem(
          label: 'Favoritos',
          icon: Icon(Icons.favorite)),
          
      ],
    );
  }
}