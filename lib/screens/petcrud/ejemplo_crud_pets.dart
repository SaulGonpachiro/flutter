import 'package:flutter/material.dart';
import 'dart:math';
import 'package:Paw_authority/models/Pet.dart';
import 'package:Paw_authority/services/pet_service.dart';
import 'package:Paw_authority/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:Paw_authority/UI/background_image.dart';
import 'package:Paw_authority/models/Pet.dart';

class EjemploCrudPets extends StatefulWidget {
  const EjemploCrudPets({super.key});

  @override
  State<EjemploCrudPets> createState() => _EjemploCrudPetsState();
}

class _EjemploCrudPetsState extends State<EjemploCrudPets> {
  final Random _random = Random();
  final Map<String, Color> _petColors = {}; // Cambiamos la clave de int a String

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
    _obtenerMascotas();
  }

  Future<void> _obtenerMascotas() async {
    final petService = Provider.of<PetService>(context, listen: false);
    await petService.fetchPets();

    // Asigna colores a las mascotas si no están ya asignados
    for (var pet in petService.pets) {
    if (!_petColors.containsKey(pet.id)) {
      _petColors[pet.id] = _getRandomColor();
    }
    }

    setState(() {}); // Refresca la UI después de obtener los datos
  }

  // Función para mostrar la información completa de la mascota
  void _mostrarInformacionCompleta(Pet pet) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(pet.nombre),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Raza: ${pet.id}"),
              Text("Edad: ${pet.chip}"),
              Text("Tipo: ${pet.tipo}"),
              Text("Raza: ${pet.raza}"),
              Text("Nombre: ${pet.nombre}"),
              Text("Peso: ${pet.peso}"),
              Text("Propietario: ${pet.idPropietario}"),
              Text("Fecha Nacimiento: ${pet.fechaNacimiento}"),
              Text("Observaciones: ${pet.observaciones}"),
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
    final petService = Provider.of<PetService>(context);
    // Obtener el ancho de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;

    // Ajustar el tamaño máximo de cada ítem según el tamaño de la pantalla
    double maxCrossAxisExtent = screenWidth < 600 ? 150 : 200;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: const BackgroundImage(imagen: "huron.png"), // Imagen de fondo
          ),
          Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(2), // Padding mínimo
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: maxCrossAxisExtent, // Tamaño ajustado dinámicamente
                    crossAxisSpacing: 2, // Espaciado mínimo
                    mainAxisSpacing: 2, // Espaciado mínimo
                    childAspectRatio: 1, // Relación de aspecto cuadrada
                  ),
                  itemCount: petService.pets.length,
                  itemBuilder: (context, index) {
                    final pet = petService.pets[index];
                    final color = _petColors[pet.id] ?? Colors.grey;

                    return GestureDetector(
                      onTap: () {
                        _mostrarInformacionCompleta(pet); // Muestra la información al hacer clic
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: color, // Usa el color almacenado
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.all(4), // Padding interno pequeño
                        child: Stack(
                          children: [
                            // Nombre de la mascota
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                pet.nombre,
                                style: TextStyle(
                                  fontSize: 12, // Fuente más grande
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1, // Evita que el texto ocupe más de una línea
                                overflow: TextOverflow.ellipsis, // Puntos suspensivos si el texto es largo
                              ),
                            ),
                            // Botones de editar y eliminar
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.white, size: 16), // Ícono más grande
                                    padding: EdgeInsets.zero, // Sin padding
                                    onPressed: () async {
                                      final Pet? p = await petService.getPetById(pet.id);
                                      // Acción de editar
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.white, size: 16), // Ícono más grande
                                    padding: EdgeInsets.zero, // Sin padding
                                    onPressed: () async {
                                      await petService.deletePet(pet.id);
                                      _obtenerMascotas(); // Refresca la lista tras eliminar
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
                  await Navigator.pushNamed(context, '/petinsert');
                  _obtenerMascotas(); // Refresca la lista tras añadir una mascota
                },
                child: Text("Añadir Mascota"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}