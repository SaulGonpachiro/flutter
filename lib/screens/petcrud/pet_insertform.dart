import 'package:Paw_authority/providers/pet_provider.dart';
import 'package:Paw_authority/services/pet_service.dart';
import 'package:flutter/material.dart';
import 'package:Paw_authority/UI/custom_text_input.dart';
import 'package:provider/provider.dart';
import 'package:Paw_authority/models/Pet.dart';
import 'package:Paw_authority/UI/background_image.dart'; // Importa el fondo

class PetInsertForm extends StatefulWidget {
  const PetInsertForm({super.key});

  @override
  State<PetInsertForm> createState() => _PetInsertFormState();
}

class _PetInsertFormState extends State<PetInsertForm> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _addPet(BuildContext context) async {
    final petProvider = Provider.of<PetProvider>(context, listen: false);
    final petService = Provider.of<PetService>(context, listen: false);

    _formKey.currentState!.save(); // Activa el método onSaved
    final nuevaMascota = Pet(
      id: "", // Firebase asignará un ID automáticamente
      chip: petProvider.chip,
      tipo: petProvider.tipo,
      raza: petProvider.raza,
      nombre: petProvider.nombre,
      peso: petProvider.peso,
      idPropietario: petProvider.idPropietario,
      fechaNacimiento: petProvider.fechaNacimiento,
      observaciones: petProvider.observaciones,
    );
    try {
      await petService.createPet(nuevaMascota); // Sube a Firebase
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Mascota guardada exitosamente")),
      );
      Navigator.pop(context); // Regresa a la pantalla anterior
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar la mascota: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final petProvider = Provider.of<PetProvider>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          // Fondo de la aplicación
          Positioned.fill(
            child: BackgroundImage(imagen: "huron.png"),
          ),
          // Formulario centrado
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9, // Ancho del 90% de la pantalla
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.7), // Fondo verde semitransparente
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Propietario",
                        hint: "Introduce el propietario",
                        onSaved: (value) => petProvider.setIdPropietario(value ?? ""),
                        validator: (value) => null,
                      ),
                      const SizedBox(height: 10.0),
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Chip",
                        hint: "Ingrese el Chip",
                        onChanged: (value) => petProvider.setChip(value),
                        onSaved: (value) => petProvider.setChip(value ?? ""),
                        validator: (value) => value!.isEmpty ? "El chip es obligatorio" : null,
                      ),
                      SizedBox(height: 10.0),
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Tipo",
                        hint: "Ingresa el tipo de animal",
                        onChanged: (value) => petProvider.setTipo(value),
                        onSaved: (value) => petProvider.setTipo(value ?? ""),
                        validator: (value) => value!.isEmpty ? "El tipo es obligatorio" : null,
                      ),
                      SizedBox(height: 10.0),
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Raza",
                        hint: "Ingresa la raza",
                        onChanged: (value) => petProvider.setRaza(value),
                        onSaved: (value) => petProvider.setRaza(value ?? ""),
                        validator: (value) => value!.isEmpty ? "La raza es obligatoria" : null,
                      ),
                      SizedBox(height: 10.0),
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Nombre",
                        hint: "Ingrese el nombre de la mascota",
                        onSaved: (value) => petProvider.setNombre(value ?? ""),
                        validator: (value) => value!.isEmpty ? "El nombre es obligatorio" : null,
                      ),
                      SizedBox(height: 10.0),
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Peso",
                        keyboardType: TextInputType.number,
                        hint: "Peso de la mascota",
                        onSaved: (value) => petProvider.setPeso(value ?? ""),
                        validator: (value) => null,
                      ),
                      SizedBox(height: 10.0),
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Observaciones",
                        hint: "Introduce las observaciones",
                        onSaved: (value) => petProvider.setObservaciones(value ?? ""),
                        validator: (value) => null,
                      ),
                      SizedBox(height: 20.0),
                      // Botones "Guardar Mascota" y "Cancelar"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _addPet(context);
                              }
                            },
                            child: Text("Guardar Mascota"),
                          ),
                          SizedBox(width: 10), // Espacio entre botones
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Volver atrás
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // Color rojo para el botón de cancelar
                            ),
                            child: Text("Cancelar"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}