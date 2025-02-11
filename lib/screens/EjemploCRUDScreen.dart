import 'package:flutter/material.dart';
import 'package:flutter_appvet/services/pets_service.dart';
import 'package:flutter_appvet/models/Pet.dart';

class EjemploCRUD extends StatelessWidget {
  final PetsService petService = PetsService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('CRUD de Mascotas')),
        body: PetCrudExample(petService: petService),
      ),
    );
  }
}

class PetCrudExample extends StatefulWidget {
  final PetsService petService;

  PetCrudExample({required this.petService});

  @override
  _PetCrudExampleState createState() => _PetCrudExampleState();
}

class _PetCrudExampleState extends State<PetCrudExample> {
  List<Pet> pets = [];

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  Future<void> _loadPets() async {
    await widget.petService.fetchPets();
    setState(() {
      pets = widget.petService.pets;
    });
  }

  Future<void> _addPet() async {
    final pet = Pet(
      id: "1",
      chip: "123456",
      tipo: "Perro",
      raza: "Labrador",
      nombre: "Max",
      peso: 25.0,
      idPropietario: 101,
      fechaNacimiento: DateTime(2020, 5, 10),
      observaciones: "Energético y amigable",
    );
    await widget.petService.createPet(pet);
    _loadPets();
  }

  Future<void> _updatePet(Pet pet) async {
    pet.nombre = "Rocky";
    await widget.petService.updatePet(pet);
    _loadPets();
  }

  Future<void> _deletePet(String id) async {
    await widget.petService.deletePet(id);
    _loadPets();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _addPet,
          child: Text('Añadir Mascota'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: pets.length,
            itemBuilder: (context, index) {
              final pet = pets[index];
              return ListTile(
                title: Text(pet.nombre),
                subtitle: Text(pet.raza),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => {_addPet()} //_updatePet(pet),
                        ),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => {} //_updatePet(pet),
                        ),
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => {} // _deletePet(pet.id),
                        ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}