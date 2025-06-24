// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import '../../models/menu_item.dart';
import '../../services/favourite_service.dart';
import '../../widgets/title_appbar.dart';
import '../menu/item_detail_page.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final FavouriteService _favouriteService = FavouriteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        'Favourites',
        actionType: AppBarActionType.none,
      ),
      body: ListenableBuilder(
        listenable: _favouriteService,
        builder: (context, child) {
          final favouriteItems = _favouriteService.favouriteItems;
          if (favouriteItems.isEmpty) {
            return const Center(
              child: Text('No favorites yet', style: TextStyle(fontSize: 18)),
            );
          }
          return ListView.builder(
            itemCount: favouriteItems.length,
            padding: const EdgeInsets.all(22),
            itemBuilder: (context, index) {
              final item = favouriteItems[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: Image.asset(item.imagePath,
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(item.name),
                  subtitle: Text(item.price),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _favouriteService.toggleFavourite(item);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailPage(menuItem: item),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
