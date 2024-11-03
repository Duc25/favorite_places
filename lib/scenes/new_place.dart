import 'dart:io';

import 'package:favorite_location/model/place.dart';
import 'package:favorite_location/provider/place.dart';
import 'package:favorite_location/widget/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlace extends ConsumerWidget {
  const NewPlace({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    String title = '';
    File? selectedImage;
    void onChoseImage(File _imagePicked) {
      selectedImage = _imagePicked;
    }

    void onSubmitPlace() {
      if (selectedImage == null) {
        return;
      }
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        ref.read(favoritePlaceProvider.notifier).addNewPlace(
              Place(
                title: title,
                image: selectedImage!,
              ),
            );
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Must be a valid, positive number.';
                  }
                  return null;
                },
                onSaved: (newValue) => title = newValue!,
              ),
              const SizedBox(
                height: 16,
              ),
              ImageInput(
                onChoseImage: onChoseImage,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: onSubmitPlace,
                    child: const Text('Add Place'),
                  ),
                  TextButton(
                    onPressed: () {
                      formKey.currentState!.reset();
                    },
                    child: const Text('Reset'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
