import 'dart:convert';
import 'package:Paw_authority/models/Client.dart'; // Asegúrate de importar la clase Client
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ClientService extends ChangeNotifier {
  final String baseURL =
      "https://app-vet-95e2b-default-rtdb.europe-west1.firebasedatabase.app";

  String getClientsUrl() => "$baseURL/clients.json";

  List<Client> _clients = [];
  List<Client> get clients => _clients;

  Future<void> fetchClients() async {
    final response = await http.get(Uri.parse(getClientsUrl()));
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.isEmpty) {
        // No hay clientes en la base de datos
      } else {
        _clients = data.entries.map((e) {
          final clientData = e.value as Map<String, dynamic>;
          clientData["id"] = e.key; // Agregar el ID de Firebase al objeto
          return Client.fromJson(clientData);
        }).toList();

        print("Clientes cargados: $_clients");
      }
      notifyListeners();
    } else {
      throw Exception("Error al cargar los clientes");
    }
  }

  Future<Client?> getClientById(String clientId) async {
    final url = "$baseURL/clients/$clientId.json";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(response.body);
      if (data == null) return null;
      return Client.fromJson(data);
    } else {
      throw Exception("Error al obtener el cliente con ID: $clientId");
    }
  }

  Future<void> createClient(Client client) async {
    final response = await http.post(
      Uri.parse(getClientsUrl()),
      body: json.encode(client.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);
      final String firebaseId = responseData["name"]; // ID generado por Firebase

      final clientConId = Client(
        id: firebaseId,
        nombre: client.nombre,
        apellidos: client.apellidos,
        dni: client.dni,
        telefono: client.telefono,
        email: client.email,
        fechaNacimiento: client.fechaNacimiento,
        direccion: client.direccion,
        observaciones: client.observaciones,
      );
      _clients.add(clientConId);
      notifyListeners();
    } else {
      throw Exception("Error al crear el cliente");
    }
  }

  Future<void> updateClient(Client client) async {
    final url = "$baseURL/clients/${client.id}.json";
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode(client.toJson()),
    );
    if (response.statusCode == 200) {
      final index = _clients.indexWhere((c) => c.id == client.id);
      if (index != -1) {
        _clients[index] = client;
        notifyListeners();
      }
    } else {
      throw Exception("Error al actualizar el cliente");
    }
  }

  Future<void> deleteClient(String id) async {
    final url = "$baseURL/clients/$id.json";
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      _clients.removeWhere((c) => c.id == id);
      notifyListeners();
    } else {
      throw Exception("Error al eliminar el cliente");
    }
  }
}