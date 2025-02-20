import 'package:flutter/material.dart';

class ConsultaProvider extends ChangeNotifier {
  String id = "";
  DateTime fecha = DateTime.now();
  String diagnostico = "";
  String tratamiento = "";
  String observaciones = "";
  String idMascota = "";
  String idVeterinario = "";

  // Métodos para actualizar los atributos y notificar a los listeners

  void setId(String valor) {
    id = valor;
    notifyListeners();
  }

  void setFecha(DateTime valor) {
    fecha = valor;
    notifyListeners();
  }

  void setDiagnostico(String valor) {
    diagnostico = valor;
    notifyListeners();
  }

  void setTratamiento(String valor) {
    tratamiento = valor;
    notifyListeners();
  }

  void setObservaciones(String valor) {
    observaciones = valor;
    notifyListeners();
  }

  void setIdMascota(String valor) {
    idMascota = valor;
    notifyListeners();
  }

  void setIdVeterinario(String valor) {
    idVeterinario = valor;
    notifyListeners();
  }

  // Método para resetear todos los valores
  void reset() {
    id = "";
    fecha = DateTime.now();
    diagnostico = "";
    tratamiento = "";
    observaciones = "";
    idMascota = "";
    idVeterinario = "";
    notifyListeners();
  }
}