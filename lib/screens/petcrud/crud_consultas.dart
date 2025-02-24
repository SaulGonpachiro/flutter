import 'dart:math';

import 'package:Paw_authority/screens/petcrud/edit_consultas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Paw_authority/models/Consultas.dart';
import 'package:Paw_authority/services/consulta_service.dart';
import 'package:Paw_authority/UI/background_image.dart';

class ConsultaCrud extends StatefulWidget {
  const ConsultaCrud({super.key});

  @override
  State<ConsultaCrud> createState() => _ConsultaCrudState();
}

class _ConsultaCrudState extends State<ConsultaCrud> {
  final Random _random = Random();
  final Map<String, Color> _consultaColors = {};

  Color _getRandomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  @override
  void initState() {
    super.initState();
    _obtenerConsultas(); // Obtiene las consultas al iniciar
  }

  Future<void> _obtenerConsultas() async {
    final consultaService = Provider.of<ConsultaService>(context, listen: false);
    await consultaService.fetchConsultas();

    // Asigna colores a las consultas si no están ya asignados
    for (var consulta in consultaService.consultas) {
      if (!_consultaColors.containsKey(consulta.id)) {
        _consultaColors[consulta.id] = _getRandomColor();
      }
    }

    setState(() {}); // Refresca la UI después de obtener los datos
  }

  // Función para mostrar la pantalla de edición de una consulta
  void _editarConsulta(Consulta consulta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditConsultaScreen(consulta: consulta), // Navega a la pantalla de edición
      ),
    );
  }

  // Función para mostrar la información completa de una consulta
  void _mostrarInformacionCompleta(Consulta consulta) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Consulta: ${consulta.id}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Fecha: ${consulta.fecha.toLocal()}"),
              Text("Diagnóstico: ${consulta.diagnostico}"),
              Text("Tratamiento: ${consulta.tratamiento}"),
              Text("Observaciones: ${consulta.observaciones}"),
              Text("ID Mascota: ${consulta.idMascota}"),
              Text("ID Veterinario: ${consulta.idVeterinario}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el diálogo
              },
              child: Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final consultaService = Provider.of<ConsultaService>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double maxCrossAxisExtent = screenWidth < 600 ? 150 : 200;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: const BackgroundImage(imagen: "huron.png"), // Cambiar por tu imagen
          ),
          Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(2),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: maxCrossAxisExtent,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 1,
                  ),
                  itemCount: consultaService.consultas.length,
                  itemBuilder: (context, index) {
                    final consulta = consultaService.consultas[index];
                    final color = _consultaColors[consulta.id] ?? Colors.grey;

                    return GestureDetector(
                      onTap: () {
                        _mostrarInformacionCompleta(consulta); // Muestra la información
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.all(4),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Consulta: ${consulta.id}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.white, size: 16),
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      _editarConsulta(consulta); // Llama a la función de edición
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.white, size: 16),
                                    padding: EdgeInsets.zero,
                                    onPressed: () async {
                                      await consultaService.deleteConsulta(consulta.id);
                                      _obtenerConsultas(); // Refresca la lista
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/consultatinsert'); // Asegúrate de tener esta ruta
                  _obtenerConsultas(); // Refresca la lista después de añadir una consulta
                },
                child: Text("Añadir Consulta"),
              ),
              SizedBox(height: 20), // Espaciado antes del botón de volver
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Volver a la pantalla anterior
                },
                child: Text("Volver"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
