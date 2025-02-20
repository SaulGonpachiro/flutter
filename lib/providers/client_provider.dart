import 'package:flutter/material.dart';

class ClientProvider extends ChangeNotifier {
  String id = "";
  String nombre = "";
  String apellidos = "";
  String dni = "";
  String telefono = "";
  String email = "";
  DateTime fechaNacimiento = DateTime.now();
  String direccion = "";
  String observaciones = "";

  // Métodos para actualizar los atributos y notificar a los listeners

  void setId(String valor) {
    id = valor;
    notifyListeners();
  }

  void setNombre(String valor) {
    nombre = valor;
    notifyListeners();
  }

  void setApellidos(String valor) {
    apellidos = valor;
    notifyListeners();
  }

  void setDni(String valor) {
    dni = valor;
    notifyListeners();
  }

  void setTelefono(String valor) {
    telefono = valor;
    notifyListeners();
  }

  void setEmail(String valor) {
    email = valor;
    notifyListeners();
  }

  void setFechaNacimiento(DateTime fecha) {
    fechaNacimiento = fecha;
    notifyListeners();
  }

  void setDireccion(String valor) {
    direccion = valor;
    notifyListeners();
  }

  void setObservaciones(String valor) {
    observaciones = valor;
    notifyListeners();
  }

  // Método para resetear todos los valores
  void reset() {
    id = "";
    nombre = "";
    apellidos = "";
    dni = "";
    telefono = "";
    email = "";
    fechaNacimiento = DateTime.now();
    direccion = "";
    observaciones = "";
    notifyListeners();
  }
}