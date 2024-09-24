import 'package:flutter/material.dart';
import 'package:flutter_favorite_places_app/providers/user_places.dart';
import 'package:flutter_favorite_places_app/screens/add_new_place_screen.dart';
import 'package:flutter_favorite_places_app/widgets/places_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Your places",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddNewPlaceScreen(),
                ));
              },
              icon: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 218, 216, 216),
                size: 25,
              ),
            )
          ],
        ),
        body: PlacesList(
          places: userPlaces,
        ),
      ),
    );
  }
}
