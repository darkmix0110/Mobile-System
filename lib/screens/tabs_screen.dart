import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'genres_screen.dart';
import 'tracks_screen.dart'; // Створимо порожнім на наступному кроці

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Список екранів для перемикання
    final List<Widget> pages = [
      const GenresScreen(),
      const TracksScreen(), // Екран з повним списком треків
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Музичні Жанри' : 'Усі Треки'),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Жанри'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Треки'),
        ],
      ),
    );
  }
}