import 'dart:convert';
import 'package:Paw_authority/models/Consultas.dart'; // Asegúrate de importar la clase Consulta
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ConsultaService extends ChangeNotifier {
  final String baseURL =
      "https://app-vet-95e2b-default-rtdb.europe-west1.firebasedatabase.app";

  String getConsultasUrl() => "$baseURL/consultas.json";

  List<Consulta> _consultas = [];
  List<Consulta> get consultas => _consultas;

  Future<void> fetchConsultas() async {
    final response = await http.get(Uri.parse(getConsultasUrl()));
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.isEmpty) {
        // No hay consultas en la base de datos
      } else {
        _consultas = data.entries.map((e) {
          final consultaData = e.value as Map<String, dynamic>;
          consultaData["id"] = e.key; // Agregar el ID de Firebase al objeto
          return Consulta.fromJson(consultaData);
        }).toList();

        print("Consultas cargadas: $_consultas");
      }
      notifyListeners();
    } else {
      throw Exception("Error al cargar las consultas");
    }
  }

  Future<Consulta?> getConsultaById(String consultaId) async {
    final url = "$baseURL/consultas/$consultaId.json";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(response.body);
      if (data == null) return null;
      return Consulta.fromJson(data);
    } else {
      throw Exception("Error al obtener la consulta con ID: $consultaId");
    }
  }

  Future<void> createConsulta(Consulta consulta) async {
    final response = await http.post(
      Uri.parse(getConsultasUrl()),
      body: json.encode(consulta.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);
      final String firebaseId = responseData["name"]; // ID generado por Firebase

      final consultaConId = Consulta(
        id: firebaseId,
        fecha: consulta.fecha,
        diagnostico: consulta.diagnostico,
        tratamiento: consulta.tratamiento,
        observaciones: consulta.observaciones,
        idMascota: consulta.idMascota,
        idVeterinario: consulta.idVeterinario,
      );
      _consultas.add(consultaConId);
      notifyListeners();
    } else {
      throw Exception("Error al crear la consulta");
    }
  }

  Future<void> updateConsulta(Consulta consulta) async {
    final url = "$baseURL/consultas/${consulta.id}.json";
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode(consulta.toJson()),
    );
    if (response.statusCode == 200) {
      final index = _consultas.indexWhere((c) => c.id == consulta.id);
      if (index != -1) {
        _consultas[index] = consulta;
        notifyListeners();
      }
    } else {
      throw Exception("Error al actualizar la consulta");
    }
  }

  Future<void> deleteConsulta(String id) async {
    final url = "$baseURL/consultas/$id.json";
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      _consultas.removeWhere((c) => c.id == id);
      notifyListeners();
    } else {
      throw Exception("Error al eliminar la consulta");
    }
  }
}