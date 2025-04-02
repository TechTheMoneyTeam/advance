// REPOSITORY
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'async_value.dart';

// REPOS
abstract class PancakeRepository {
  Future<Pancake> addPancake({required String color, required double price});
  Future<bool> removePancake(String id);
  Future<Pancake?> updatePancake(
      {required String id, required String color, required double price});
  Future<List<Pancake>> getPancakes();
}

class FirebasePancakeRepository extends PancakeRepository {
  static const String baseUrl = 'YOUR URL';
  static const String pancakesCollection = "pancakes";
  static const String allPancakesUrl = '$baseUrl/$pancakesCollection.json';

  // Local cache for optimization
  final Map<String, Pancake> _cache = {};

  @override
  Future<Pancake> addPancake(
      {required String color, required double price}) async {
    Uri uri = Uri.parse(allPancakesUrl);

    // Create a new data
    final newPancakeData = {'color': color, 'price': price};
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newPancakeData),
    );

    // Handle errors
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to add pancake');
    }

    // Firebase returns the new ID in 'name'
    final newId = json.decode(response.body)['name'];

    // Add to cache
    final newPancake = Pancake(id: newId, color: color, price: price);
    _cache[newId] = newPancake;

    // Return created pancake
    return newPancake;
  }

  @override
  Future<bool> removePancake(String id) async {
    Uri uri = Uri.parse('$baseUrl/$pancakesCollection/$id.json');
    final http.Response response = await http.delete(uri);

    // Handle errors
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to remove pancake');
    }

    // Remove from cache (Option 2 optimization)
    _cache.remove(id);

    return true;
  }

  @override
  Future<Pancake?> updatePancake(
      {required String id,
      required String color,
      required double price}) async {
    Uri uri = Uri.parse('$baseUrl/$pancakesCollection/$id.json');

    final updatedPancakeData = {'color': color, 'price': price};
    final http.Response response = await http.patch(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedPancakeData),
    );

    // Handle errors
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to update pancake');
    }

    // Update cache
    final updatedPancake = Pancake(id: id, color: color, price: price);
    _cache[id] = updatedPancake;

    return updatedPancake;
  }

  @override
  Future<List<Pancake>> getPancakes() async {
    Uri uri = Uri.parse(allPancakesUrl);
    final http.Response response = await http.get(uri);

    // Handle errors
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load pancakes');
    }

    // Return all pancakes
    final data = json.decode(response.body) as Map<String, dynamic>?;

    if (data == null) return [];

    // Update cache while loading
    List<Pancake> pancakes = data.entries.map((entry) {
      final pancake = PancakeDto.fromJson(entry.key, entry.value);
      _cache[pancake.id] = pancake;
      return pancake;
    }).toList();

    return pancakes;
  }
}

class MockPancakeRepository extends PancakeRepository {
  final Map<String, Pancake> _pancakes = {};
  int _nextId = 1;

  @override
  Future<Pancake> addPancake({required String color, required double price}) {
    return Future.delayed(Duration(seconds: 1), () {
      String id = _nextId.toString();
      _nextId++;
      Pancake newPancake = Pancake(id: id, color: color, price: price);
      _pancakes[id] = newPancake;
      return newPancake;
    });
  }

  @override
  Future<bool> removePancake(String id) {
    return Future.delayed(Duration(milliseconds: 500), () {
      _pancakes.remove(id);
      return true;
    });
  }

  @override
  Future<Pancake?> updatePancake(
      {required String id, required String color, required double price}) {
    return Future.delayed(Duration(milliseconds: 800), () {
      if (!_pancakes.containsKey(id)) return null;

      Pancake updatedPancake = Pancake(id: id, color: color, price: price);
      _pancakes[id] = updatedPancake;
      return updatedPancake;
    });
  }

  @override
  Future<List<Pancake>> getPancakes() {
    return Future.delayed(
        Duration(seconds: 1), () => _pancakes.values.toList());
  }
}

// MODEL & DTO
class PancakeDto {
  static Pancake fromJson(String id, Map<String, dynamic> json) {
    return Pancake(id: id, color: json['color'], price: json['price']);
  }

  static Map<String, dynamic> toJson(Pancake pancake) {
    return {'color': pancake.color, 'price': pancake.price};
  }
}

// MODEL
class Pancake {
  final String id;
  final String color;
  final double price;

  Pancake({required this.id, required this.color, required this.price});

  @override
  bool operator ==(Object other) {
    return other is Pancake && other.id == id;
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode;
}

// PROVIDER
class PancakeProvider extends ChangeNotifier {
  final PancakeRepository _repository;
  AsyncValue<List<Pancake>>? pancakesState;

  Pancake? selectedPancake;

  PancakeProvider(this._repository) {
    fetchPancakes();
  }

  bool get isLoading =>
      pancakesState != null && pancakesState!.state == AsyncValueState.loading;
  bool get hasData =>
      pancakesState != null && pancakesState!.state == AsyncValueState.success;

  void fetchPancakes() async {
    try {
      pancakesState = AsyncValue.loading();
      notifyListeners();

      pancakesState = AsyncValue.success(await _repository.getPancakes());

      print("SUCCESS: list size ${pancakesState!.data!.length.toString()}");

      // 3 - Handle errors
    } catch (error) {
      print("ERROR: $error");
      pancakesState = AsyncValue.error(error);
    }

    notifyListeners();
  }

  void addPancake(String color, double price) async {
    try {
      if (pancakesState?.state != AsyncValueState.success) {
        pancakesState = AsyncValue.loading();
        notifyListeners();
      }

      final newPancake =
          await _repository.addPancake(color: color, price: price);

      if (pancakesState?.state == AsyncValueState.success &&
          pancakesState?.data != null) {
        List<Pancake> updatedPancakes = List.from(pancakesState!.data!);
        updatedPancakes.add(newPancake);
        pancakesState = AsyncValue.success(updatedPancakes);
      } else {
        fetchPancakes();
        return;
      }
    } catch (error) {
      print("ERROR adding pancake: $error");
      pancakesState = AsyncValue.error(error);
    }

    notifyListeners();
  }

  void removePancake(String id) async {
    if (pancakesState?.state != AsyncValueState.success ||
        pancakesState?.data == null) {
      return;
    }

    List<Pancake> currentPancakes = List.from(pancakesState!.data!);
    int index = currentPancakes.indexWhere((pancake) => pancake.id == id);

    if (index != -1) {
      Pancake removedPancake = currentPancakes[index];
      currentPancakes.removeAt(index);
      pancakesState = AsyncValue.success(currentPancakes);
      notifyListeners();

      _repository.removePancake(id).catchError((error) {
        print("ERROR removing pancake: $error");
        if (pancakesState?.state == AsyncValueState.success) {
          List<Pancake> revertedPancakes = List.from(pancakesState!.data!);
          revertedPancakes.add(removedPancake);
          pancakesState = AsyncValue.success(revertedPancakes);
          notifyListeners();
        }
      });
    }
  }

  void selectPancakeForEdit(Pancake pancake) {
    selectedPancake = pancake;
    notifyListeners();
  }

  void clearSelectedPancake() {
    selectedPancake = null;
    notifyListeners();
  }

  Future<bool> updatePancake(
      {required String id,
      required String color,
      required double price}) async {
    try {
      final updatedPancake =
          await _repository.updatePancake(id: id, color: color, price: price);

      if (updatedPancake == null) return false;

      if (pancakesState?.state == AsyncValueState.success &&
          pancakesState?.data != null) {
        List<Pancake> updatedPancakes = List.from(pancakesState!.data!);
        int index = updatedPancakes.indexWhere((pancake) => pancake.id == id);

        if (index != -1) {
          updatedPancakes[index] = updatedPancake;
          pancakesState = AsyncValue.success(updatedPancakes);
          clearSelectedPancake();
          notifyListeners();
          return true;
        }
      }

      fetchPancakes();
      clearSelectedPancake();
      return true;
    } catch (error) {
      print("ERROR updating pancake: $error");
      return false;
    }
  }
}

// FORM DIALOG
class PancakeFormDialog extends StatefulWidget {
  final Pancake? pancake;

  const PancakeFormDialog({Key? key, this.pancake}) : super(key: key);

  @override
  _PancakeFormDialogState createState() => _PancakeFormDialogState();
}

class _PancakeFormDialogState extends State<PancakeFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _colorController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.pancake != null) {
      _colorController.text = widget.pancake!.color;
      _priceController.text = widget.pancake!.price.toString();
    }
  }

  @override
  void dispose() {
    _colorController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PancakeProvider>(context);
    final isEditing = widget.pancake != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Pancake' : 'Add Pancake'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _colorController,
              decoration: InputDecoration(labelText: 'Color'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a color';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a price';
                }
                try {
                  double.parse(value);
                } catch (e) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final color = _colorController.text;
              final price = double.parse(_priceController.text);

              if (isEditing) {
                provider
                    .updatePancake(
                        id: widget.pancake!.id, color: color, price: price)
                    .then((success) {
                  if (success) {
                    Navigator.of(context).pop();
                  }
                });
              } else {
                provider.addPancake(color, price);
                Navigator.of(context).pop();
              }
            }
          },
          child: Text(isEditing ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  void _showAddPancakeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PancakeFormDialog(),
    );
  }

  void _showEditPancakeDialog(BuildContext context, Pancake pancake) {
    final provider = Provider.of<PancakeProvider>(context, listen: false);
    provider.selectPancakeForEdit(pancake);

    showDialog(
      context: context,
      builder: (context) => PancakeFormDialog(pancake: pancake),
    ).then((_) {
      provider.clearSelectedPancake();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pancakeProvider = Provider.of<PancakeProvider>(context);

    Widget content = Text('');
    if (pancakeProvider.isLoading) {
      content = CircularProgressIndicator();
    } else if (pancakeProvider.hasData) {
      List<Pancake> pancakes = pancakeProvider.pancakesState!.data!;

      if (pancakes.isEmpty) {
        content = Text("No pancakes yet");
      } else {
        content = ListView.builder(
          itemCount: pancakes.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(pancakes[index].color),
            subtitle: Text("\$${pancakes[index].price}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () =>
                      _showEditPancakeDialog(context, pancakes[index]),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      pancakeProvider.removePancake(pancakes[index].id),
                ),
              ],
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Pancake App"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () => _showAddPancakeDialog(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: Center(child: content),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPancakeDialog(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

void main() async {
  final PancakeRepository pancakeRepository = MockPancakeRepository();
  // final PancakeRepository pancakeRepository = FirebasePancakeRepository();

  runApp(
    ChangeNotifierProvider(
      create: (context) => PancakeProvider(pancakeRepository),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: const App()),
    ),
  );
}
