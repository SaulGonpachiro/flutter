import 'dart:convert';
import 'package:Paw_authority/models/Pet.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:Paw_authority/models/Pet.dart';

class PetService extends ChangeNotifier {
  final String baseURL =
      "https://app-vet-1d0c2-default-rtdb.europe-west1.firebasedatabase.app/";

  String getPetsUrl() =>
      "https://app-vet-1d0c2-default-rtdb.europe-west1.firebasedatabase.app/pets.json";

  //String getPetUrl(String id) => "$baseURL/pets/$id.json";

  List<Pet> _pets = [];
  List<Pet> get pets => _pets;

  Future<void> fetchPets() async {
    final response = await http.get(Uri.parse(getPetsUrl()));
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.isEmpty) {
        print("No hay mascotas en la base de datos.");
      } else {
        _pets = data.entries.map((e) {
          final petData = e.value as Map<String, dynamic>;
          petData["id"] = e.key;
          return Pet.fromJson(petData);
        }).toList();

        print(
            "Mascotas cargadas: $_pets"); 
      }
      notifyListeners();
    } else {
      throw Exception("Error al cargar las mascotas");
    }
  }

  Future<Pet?> getPetById(String petId) async {
    final url = "$baseURL/pet/$petId.json"; //URL específica para cada mascota
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(response.body);

      if (data == null) return null; //Si no existe la mascota

      return Pet.fromJson(data); // Convertir JSON a objeto Pet
    } else {
      throw Exception("Error al obtener la mascota con ID: $petId");
    }
  }

  Future<void> createPet(Pet pet) async {
    print("AGREGAR MASCOTA");
    final response = await http.post(
      Uri.parse(getPetsUrl()),
      body: json.encode(pet.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);
      final String firebaseId = responseData["name"]; //ID GENERADO POR FIREBASE

      print("FIREBASE ID: ${firebaseId}");
      final petConId = Pet(
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
      _pets.add(petConId);
      notifyListeners();
    } else {
      throw Exception("Error al crear la mascota");
    }
  }

  Future<void> updatePet(Pet pet) async {
    final url =
        "https://app-vet-1d0c2-default-rtdb.europe-west1.firebasedatabase.app/pets/${pet.id}.json";
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
        "https://app-vet-1d0c2-default-rtdb.europe-west1.firebasedatabase.app/pets/$id.json";
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      _pets.removeWhere((p) => p.id == id);
      notifyListeners();
    } else {
      throw Exception("Error al eliminar la mascota");
    }
  }
}
