import 'package:flutter/material.dart';
import 'package:flutter_favorite_places_app/providers/user_places.dart';
import 'package:flutter_favorite_places_app/widgets/image_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewPlaceScreen extends ConsumerStatefulWidget {
  const AddNewPlaceScreen({super.key});

  @override
  ConsumerState<AddNewPlaceScreen> createState() => _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends ConsumerState<AddNewPlaceScreen> {
  final textEditingController = TextEditingController();

  void _addItem() {
    String text = textEditingController.value.text;

    if (text.isEmpty) {
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(text);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add new Place"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: textEditingController,
                          autocorrect: true,
                          maxLength: 50,
                          keyboardAppearance: Brightness.light,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              // hintText: "Title",
                              label: Text("Title"),
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(height: 10),
                        const ImageInput(),
                        const SizedBox(height: 15),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.add,
                          ),
                          onPressed: _addItem,
                          label: const Text("Add Place"),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
