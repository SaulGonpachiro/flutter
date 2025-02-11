import 'dart:convert';
import 'package:flutter_appvet/models/Pet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PetsService extends ChangeNotifier {
  //final String _firebaseToken = 'AIzaSyCtmpnjxEAkoQLO68xAkboGo_4oUSR_7yA';
  final String baseUrl =
      "https://app-vet-1d0c2-default-rtdb.europe-west1.firebasedatabase.app/Pets.json";

  List<Pet> _pets = [];
  List<Pet> get pets => _pets;

  Future<void> fetchPets() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      _pets = data.entries.map((e) {
        final petData = e.value as Map<String, dynamic>;
        petData["id"] = e.key;
        return Pet.fromJson(petData);
      }).toList();
      notifyListeners();
    } else {
      throw Exception("Error al cargar las mascotas");
    }
  }

  Future<void> createPet(Pet pet) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: json.encode(pet.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);
      final String firebaseId =
          responseData["name"]; // Extrae el ID generado por Firebase

      final newPet = Pet(
        id: firebaseId, // Asigna el ID de Firebase
        chip: pet.chip,
        tipo: pet.tipo,
        raza: pet.raza,
        nombre: pet.nombre,
        peso: pet.peso,
        idPropietario: pet.idPropietario,
        fechaNacimiento: pet.fechaNacimiento,
        observaciones: pet.observaciones,
      );
      _pets.add(newPet);
      notifyListeners();
    } else {
      throw Exception("Error al crear la mascota");
    }
  }

  Future<void> updatePet(Pet pet) async {
    final url =
        "https://app-vet-1d0c2-default-rtdb.europe-west1.firebasedatabase.app/Pets/${pet.id}.json";
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode(pet.toJson()),
    );
    if (response.statusCode == 200) {
      final index = _pets.indexWhere((p) => p.id == pet.id);
      if (index != -1) {
        _pets[index] = pet;
        notifyListeners();
      }
    } else {
      throw Exception("Error al actualizar la mascota");
    }
  }

  Future<void> deletePet(String id) async {
    final url =
        "https://app-vet-1d0c2-default-rtdb.europe-west1.firebasedatabase.app/Pets/$id.json";
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      _pets.removeWhere((p) => p.id == id);
      notifyListeners();
    } else {
      throw Exception("Error al eliminar la mascota");
    }
  }
}
