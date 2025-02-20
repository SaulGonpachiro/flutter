import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Paw_authority/models/Pet.dart';
import 'package:Paw_authority/services/pet_service.dart';
import 'package:Paw_authority/UI/custom_text_input.dart'; // Importa tu widget CustomTextInput
import 'package:Paw_authority/UI/background_image.dart'; // Importa el fondo

class EditPetScreen extends StatefulWidget {
  final Pet pet;

  const EditPetScreen({super.key, required this.pet});

  @override
  _EditPetScreenState createState() => _EditPetScreenState();
}

class _EditPetScreenState extends State<EditPetScreen> {
  late TextEditingController _nombreController;
  late TextEditingController _razaController;
  late TextEditingController _pesoController;
  late TextEditingController _chipController;
  late TextEditingController _tipoController;
  late TextEditingController _idPropietarioController;
  late TextEditingController _fechaNacimientoController;
  late TextEditingController _observacionesController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.pet.nombre);
    _razaController = TextEditingController(text: widget.pet.raza);
    _pesoController = TextEditingController(text: widget.pet.peso.toString());
    _chipController = TextEditingController(text: widget.pet.chip);
    _tipoController = TextEditingController(text: widget.pet.tipo);
    _idPropietarioController = TextEditingController(text: widget.pet.idPropietario.toString());
    _fechaNacimientoController = TextEditingController(text: widget.pet.fechaNacimiento.toString());
    _observacionesController = TextEditingController(text: widget.pet.observaciones);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _razaController.dispose();
    _pesoController.dispose();
    _chipController.dispose();
    _tipoController.dispose();
    _idPropietarioController.dispose();
    _fechaNacimientoController.dispose();
    _observacionesController.dispose();
    super.dispose();
  }

  void _guardarCambios() {
    final petService = Provider.of<PetService>(context, listen: false);

    Pet updatedPet = Pet(
      id: widget.pet.id,
      chip: _chipController.text,
      tipo: _tipoController.text,
      raza: _razaController.text,
      nombre: _nombreController.text,
      peso: double.tryParse(_pesoController.text) ?? widget.pet.peso,
      idPropietario: int.tryParse(_idPropietarioController.text) ?? widget.pet.idPropietario,
      fechaNacimiento: DateTime.tryParse(_fechaNacimientoController.text) ?? widget.pet.fechaNacimiento,
      observaciones: _observacionesController.text,
    );

    petService.updatePet(updatedPet);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de la aplicación
          Positioned.fill(
            child: BackgroundImage(imagen: "huron.png"), // Fondo similar
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextInput(
                      controller: _nombreController,
                      label: "Nombre",
                      hint: "Nombre de la mascota",
                      onSaved: (value) => widget.pet.nombre = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _razaController,
                      label: "Raza",
                      hint: "Raza de la mascota",
                      onSaved: (value) => widget.pet.raza = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _pesoController,
                      label: "Peso",
                      keyboardType: TextInputType.number,
                      hint: "Peso de la mascota",
                      onSaved: (value) => widget.pet.peso = double.tryParse(value ?? "") ?? 0.0,
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _chipController,
                      label: "Chip",
                      hint: "Número de chip",
                      onSaved: (value) => widget.pet.chip = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _tipoController,
                      label: "Tipo",
                      hint: "Tipo de animal",
                      onSaved: (value) => widget.pet.tipo = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _idPropietarioController,
                      label: "ID Propietario",
                      hint: "ID del propietario",
                      onSaved: (value) => widget.pet.idPropietario = int.tryParse(value ?? "") ?? 0,
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _fechaNacimientoController,
                      label: "Fecha de Nacimiento",
                      hint: "Fecha de nacimiento",
                      onSaved: (value) => widget.pet.fechaNacimiento = DateTime.tryParse(value ?? "") ?? DateTime.now(),
                      validator: (value) => null,
                    ),
                    SizedBox(height: 10.0),
                    CustomTextInput(
                      controller: _observacionesController,
                      label: "Observaciones",
                      hint: "Observaciones sobre la mascota",
                      onSaved: (value) => widget.pet.observaciones = value ?? "",
                      validator: (value) => null,
                    ),
                    SizedBox(height: 20.0),
                    // Botones "Guardar Cambios" y "Cancelar"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _guardarCambios,
                          child: Text("Guardar Cambios"),
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
        ],
      ),
    );
  }
}
