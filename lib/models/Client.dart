import 'dart:convert';

class Client {
  String id;
  String nombre;
  String apellidos;
  String dni;
  String telefono;
  String email;
  DateTime fechaNacimiento;
  String direccion;
  String observaciones;

  Client({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.dni,
    required this.telefono,
    required this.email,
    required this.fechaNacimiento,
    required this.direccion,
    required this.observaciones,
  });

  factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        dni: json["dni"],
        telefono: json["telefono"],
        email: json["email"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        direccion: json["direccion"],
        observaciones: json["observaciones"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellidos": apellidos,
        "dni": dni,
        "telefono": telefono,
        "email": email,
        "fecha_nacimiento":
            "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "direccion": direccion,
        "observaciones": observaciones,
      };
}