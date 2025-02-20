import 'dart:convert';
import 'package:Paw_authority/models/Pet.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PetService extends ChangeNotifier {
  final String baseURL =
      "https://app-vet-95e2b-default-rtdb.europe-west1.firebasedatabase.app";

  String getPetsUrl() => "$baseURL/pets.json";

  List<Pet> _pets = [];
  List<Pet> get pets => _pets;

  Future<void> fetchPets() async {
    final response = await http.get(Uri.parse(getPetsUrl()));
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final Map<String, dynamic> data = json.decode(response.body);
      print("CARGA DE DATOS");
      if (data.isEmpty) {
        print("MASCOTAS VACÍO");
      } else {
        print("CONVERTIR VALORES");
        _pets = data.entries.map((e) {
          final petData = e.value as Map<String, dynamic>;
          print(petData["nombre"]);
          petData["id"] = e.key;
          return Pet.fromJson(petData);
        }).toList();

        print("Mascotas cargadas: $_pets");
      }
      notifyListeners();
    } else {
      throw Exception("Error al cargar las mascotas");
    }
  }

  Future<Pet?> getPetById(String petId) async {
    final url = "$baseURL/pets/$petId.json";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(response.body);
      if (data == null) return null;
      return Pet.fromJson(data);
    } else {
      throw Exception("Error al obtener la mascota con ID: $petId");
    }
  }

  Future<void> createPet(Pet pet) async {
    final response = await http.post(
      Uri.parse(getPetsUrl()),
      body: json.encode(pet.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);
      final String firebaseId = responseData["name"];

      final petConId = Pet(
        id: firebaseId,
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
    final url = "$baseURL/pets/${pet.id}.json";
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
    final url = "$baseURL/pets/$id.json";
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      _pets.removeWhere((p) => p.id == id);
      notifyListeners();
    } else {
      throw Exception("Error al eliminar la mascota");
    }
  }
}
