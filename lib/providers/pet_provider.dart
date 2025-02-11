import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';

class PetProvider extends ChangeNotifier {
  String chip = "";
  String tipo = "";
  String raza = "";
  String nombre = "";
  double peso = 0.0;
  int idPropietario = 0;
  DateTime fechaNacimiento = DateTime.now();
  String observaciones = "";

  void setChip(String valor) {
    chip = valor;
    notifyListeners();
  }

  void setTipo(String valor) {
    tipo = valor;
    notifyListeners();
  }

  void setRaza(String valor) {
    raza = valor;
    notifyListeners();
  }

  void setNombre(String valor) {
    nombre = valor;
    notifyListeners();
  }

  void setPeso(String valor) {
    peso = double.tryParse(valor) ?? 0.0;
    notifyListeners();
  }

  void setIdPropietario(String valor) {
    idPropietario = int.tryParse(valor) ?? 0;
    notifyListeners();
  }

  void setFechaNacimiento(DateTime fecha) {
    fechaNacimiento = fecha;
    notifyListeners();
  }

  void setObservaciones(String valor) {
    observaciones = valor;
    notifyListeners();
  }
}