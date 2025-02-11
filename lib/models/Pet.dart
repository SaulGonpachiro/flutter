import 'dart:convert';

class Pet {
  String id;
  String chip;
  String tipo;
  String raza;
  String nombre;
  double peso;
  int idPropietario;
  DateTime fechaNacimiento;
  String observaciones;

  Pet({
    required this.id,
    required this.chip,
    required this.tipo,
    required this.raza,
    required this.nombre,
    required this.peso,
    required this.idPropietario,
    required this.fechaNacimiento,
    required this.observaciones,
  });

  factory Pet.fromRawJson(String str) => Pet.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json["id"],
        chip: json["chip"],
        tipo: json["tipo"],
        raza: json["raza"],
        nombre: json["nombre"],
        peso: json["peso"]?.toDouble(),
        idPropietario: json["id_propietario"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        observaciones: json["observaciones"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chip": chip,
        "tipo": tipo,
        "raza": raza,
        "nombre": nombre,
        "peso": peso,
        "id_propietario": idPropietario,
        "fecha_nacimiento":
            "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "observaciones": observaciones,
      };
}