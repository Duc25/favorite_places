import 'package:favorite_location/model/place.dart';
import 'package:flutter/material.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({super.key, required this.item, required this.onPress});
  final void Function(String id) onPress;
  final Place item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(item.id),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: FileImage(item.image),
          radius: 24,
        ),
        title: Text(
          item.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
