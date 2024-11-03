import 'package:favorite_location/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<List<Place>> {
  FavoritesNotifier() : super([]);
  void addNewPlace(Place newPlace) {
    state = [...state, newPlace];
  }
}

final favoritePlaceProvider =
    StateNotifierProvider<FavoritesNotifier, List<Place>>(
  (ref) => FavoritesNotifier(),
);
