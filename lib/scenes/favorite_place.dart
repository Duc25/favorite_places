import 'package:favorite_location/provider/place_detail.dart';
import 'package:favorite_location/scenes/new_place.dart';
import 'package:favorite_location/scenes/place_detail.dart';
import 'package:favorite_location/widget/place_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_location/provider/place.dart';

class FavoritePlace extends ConsumerStatefulWidget {
  const FavoritePlace({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return FavoritePlaceState();
  }
}

class FavoritePlaceState extends ConsumerState<FavoritePlace> {
  void onPressPlaceItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const PlaceDetail(),
      ),
    );
  }

  void onAddNewPlace() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewPlace(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoritePlace = ref.watch(favoritePlaceProvider);
    Widget content = const Center(
      child: Text(
        'No places added yet.',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
    if (favoritePlace.isNotEmpty) {
      content = Padding(
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            itemBuilder: (ctx, index) => PlaceItem(
                item: favoritePlace[index],
                onPress: (id) {
                  ref.read(getPlaceDetailProvider.notifier).setPlaceId(id);
                  onPressPlaceItem();
                }),
            itemCount: favoritePlace.length,
          ));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(onPressed: onAddNewPlace, icon: const Icon(Icons.add))
        ],
      ),
      body: content,
    );
  }
}
