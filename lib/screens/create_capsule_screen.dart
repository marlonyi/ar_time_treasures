import 'package:flutter/material.dart';
import '../models/capsule.dart';
import '../services/capsule_service.dart';

class CreateCapsuleScreen extends StatefulWidget {
  const CreateCapsuleScreen({super.key});

  @override
  State<CreateCapsuleScreen> createState() => _CreateCapsuleScreenState();
}

class _CreateCapsuleScreenState extends State<CreateCapsuleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _hintController = TextEditingController();
  DateTime _openDate = DateTime.now().add(const Duration(days: 1));
  bool _isPrivate = false;
  int _pointsReward = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cápsula del Tiempo'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Ingresa un título';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción (opcional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hintController,
                decoration: const InputDecoration(
                  labelText: 'Pista (opcional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Fecha de apertura:'),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _openDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() => _openDate = picked);
                      }
                    },
                    child: Text(_openDate.toString().split(' ')[0]),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Privada'),
                value: _isPrivate,
                onChanged: (value) => setState(() => _isPrivate = value),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _pointsReward,
                decoration: const InputDecoration(
                  labelText: 'Puntos de recompensa',
                  border: OutlineInputBorder(),
                ),
                items:
                    [10, 25, 50, 100].map((points) {
                      return DropdownMenuItem(
                        value: points,
                        child: Text('$points puntos'),
                      );
                    }).toList(),
                onChanged:
                    (value) => setState(() => _pointsReward = value ?? 10),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _createCapsule,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: const Text('Crear Cápsula'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createCapsule() async {
    if (!_formKey.currentState!.validate()) return;

    final capsule = Capsule(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      creatorId: 'currentUserId', // TODO: obtener del provider
      title: _titleController.text,
      description:
          _descriptionController.text.isEmpty
              ? null
              : _descriptionController.text,
      mediaUrls: [], // TODO: agregar fotos/videos
      latitude: 4.6097, // TODO: obtener GPS real
      longitude: -74.0817,
      openDate: _openDate,
      isPrivate: _isPrivate,
      pointsReward: _pointsReward,
      hint: _hintController.text.isEmpty ? null : _hintController.text,
    );

    final service = CapsuleService();
    await service.createCapsule(capsule);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Cápsula creada exitosamente!')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _hintController.dispose();
    super.dispose();
  }
}
