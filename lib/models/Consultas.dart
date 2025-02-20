import 'dart:convert';

class Consulta {
  String id;
  DateTime fecha;
  String diagnostico;
  String tratamiento;
  String observaciones;
  String idMascota; // ID de la mascota asociada a la consulta
  String idVeterinario; // ID del veterinario que realiza la consulta

  Consulta({
    required this.id,
    required this.fecha,
    required this.diagnostico,
    required this.tratamiento,
    required this.observaciones,
    required this.idMascota,
    required this.idVeterinario,
  });

  factory Consulta.fromRawJson(String str) => Consulta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Consulta.fromJson(Map<String, dynamic> json) => Consulta(
        id: json["id"],
        fecha: DateTime.parse(json["fecha"]),
        diagnostico: json["diagnostico"],
        tratamiento: json["tratamiento"],
        observaciones: json["observaciones"],
        idMascota: json["id_mascota"],
        idVeterinario: json["id_veterinario"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "diagnostico": diagnostico,
        "tratamiento": tratamiento,
        "observaciones": observaciones,
        "id_mascota": idMascota,
        "id_veterinario": idVeterinario,
      };
}