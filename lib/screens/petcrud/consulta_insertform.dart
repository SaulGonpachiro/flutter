import 'package:Paw_authority/models/Consultas.dart';
import 'package:Paw_authority/providers/consulta_provider.dart';
import 'package:Paw_authority/services/consulta_service.dart';
import 'package:flutter/material.dart';
import 'package:Paw_authority/UI/custom_text_input.dart';
import 'package:provider/provider.dart';
import 'package:Paw_authority/UI/background_image.dart'; // Importa el fondo

class ConsultaInsertForm extends StatefulWidget {
  const ConsultaInsertForm({super.key});

  @override
  State<ConsultaInsertForm> createState() => _ConsultaInsertFormState();
}

class _ConsultaInsertFormState extends State<ConsultaInsertForm> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _addConsulta(BuildContext context) async {
    final consultaProvider = Provider.of<ConsultaProvider>(context, listen: false);
    final consultaService = Provider.of<ConsultaService>(context, listen: false);

    _formKey.currentState!.save(); // Activar el método onSaved

    final nuevaConsulta = Consulta(
      id: "", // Firebase asignará un ID automáticamente
      fecha: DateTime.now(), // Fecha actual
      diagnostico: consultaProvider.diagnostico,
      tratamiento: consultaProvider.tratamiento,
      observaciones: consultaProvider.observaciones,
      idVeterinario: consultaProvider.idVeterinario,
      idMascota: consultaProvider.idMascota, // ID de la mascota que se consulta
    );

    try {
      await consultaService.createConsulta(nuevaConsulta); // Sube la consulta a Firebase
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Consulta guardada exitosamente")),
      );
      Navigator.pop(context); // Regresa a la pantalla anterior
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar la consulta: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final consultaProvider = Provider.of<ConsultaProvider>(context, listen: false);

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
                  color: const Color.fromARGB(255, 229, 157, 64).withOpacity(0.7), // Fondo verde semitransparente
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Campo de ID de mascota
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "ID de Mascota",
                        hint: "Introduce el ID de la mascota",
                        onSaved: (value) => consultaProvider.setIdMascota(value ?? ""),
                        validator: (value) => value!.isEmpty ? "El ID de la mascota es obligatorio" : null,
                      ),
                      const SizedBox(height: 10.0),

                      // Campo de ID del veterinario
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "ID Veterinario",
                        hint: "Introduce el ID del veterinario",
                        onSaved: (value) => consultaProvider.setIdVeterinario(value ?? ""),
                        validator: (value) => value!.isEmpty ? "El ID del veterinario es obligatorio" : null,
                      ),
                      const SizedBox(height: 10.0),

                      // Campo de diagnóstico
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Diagnóstico",
                        hint: "Ingrese el diagnóstico",
                        onSaved: (value) => consultaProvider.setDiagnostico(value ?? ""),
                        validator: (value) => value!.isEmpty ? "El diagnóstico es obligatorio" : null,
                      ),
                      const SizedBox(height: 10.0),

                      // Campo de tratamiento
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Tratamiento",
                        hint: "Ingrese el tratamiento",
                        onSaved: (value) => consultaProvider.setTratamiento(value ?? ""),
                        validator: (value) => value!.isEmpty ? "El tratamiento es obligatorio" : null,
                      ),
                      const SizedBox(height: 10.0),

                      // Campo de observaciones
                      CustomTextInput(
                        controller: TextEditingController(),
                        label: "Observaciones",
                        hint: "Introduce las observaciones",
                        onSaved: (value) => consultaProvider.setObservaciones(value ?? ""),
                        validator: (value) => null,
                      ),
                      const SizedBox(height: 20.0),

                      // Botones "Guardar Consulta" y "Cancelar"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _addConsulta(context);
                              }
                            },
                            child: Text("Guardar Consulta"),
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
