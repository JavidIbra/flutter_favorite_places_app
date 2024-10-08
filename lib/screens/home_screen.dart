import 'package:flutter/material.dart';
import 'package:flutter_favorite_places_app/providers/user_places.dart';
import 'package:flutter_favorite_places_app/screens/add_new_place_screen.dart';
import 'package:flutter_favorite_places_app/widgets/places_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _placesFuture,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : PlacesList(
                        places: userPlaces,
                      ),
          ),
        ),
      ),
    );
  }
}
