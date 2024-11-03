import 'package:favorite_location/provider/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetPlaceDetailNotifier extends StateNotifier<String> {
  GetPlaceDetailNotifier() : super('');
  void setPlaceId(String id) {
    state = id;
  }
}

final getPlaceDetailProvider =
    StateNotifierProvider<GetPlaceDetailNotifier, String>(
  (ref) => GetPlaceDetailNotifier(),
);

final placeDetailProvider = Provider(
  (ref) {
    final placeList = ref.watch(favoritePlaceProvider);
    final idPlace = ref.watch(getPlaceDetailProvider);
    final place = placeList.firstWhere(
      (placeItem) => placeItem.id == idPlace,
    );
    return place;
  },
);
