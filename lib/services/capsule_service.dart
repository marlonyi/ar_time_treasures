import 'dart:math';
import '../models/capsule.dart';

class CapsuleService {
  // Mock data - reemplazar con Firebase después
  final List<Capsule> _capsules = [
    Capsule(
      id: '1',
      creatorId: 'user1',
      title: 'Tesoro del Pasado',
      description: 'Un recuerdo de hace un año',
      mediaUrls: [],
      latitude: 4.6097,
      longitude: -74.0817, // Bogotá
      openDate: DateTime.now().add(const Duration(days: 30)),
      pointsReward: 50,
      hint: 'Cerca del parque',
    ),
  ];

  Future<List<Capsule>> getNearbyCapsules(
    double lat,
    double lng,
    double radius,
  ) async {
    // Simular búsqueda
    await Future.delayed(const Duration(seconds: 1));
    return _capsules.where((c) {
      double distance = _calculateDistance(lat, lng, c.latitude, c.longitude);
      return distance <= radius && !c.isOpened;
    }).toList();
  }

  Future<Capsule?> getCapsuleById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _capsules.firstWhere((c) => c.id == id);
  }

  Future<void> createCapsule(Capsule capsule) async {
    await Future.delayed(const Duration(seconds: 1));
    _capsules.add(capsule);
  }

  Future<void> openCapsule(String capsuleId, String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    // final capsule = _capsules.firstWhere((c) => c.id == capsuleId);
    // Marcar como abierta (en mock, no persiste)
  }

  double _calculateDistance(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    // Fórmula de Haversine simplificada
    const double earthRadius = 6371; // km
    double dLat = (lat2 - lat1) * (pi / 180);
    double dLng = (lng2 - lng1) * (pi / 180);
    double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180) *
            cos(lat2 * pi / 180) *
            sin(dLng / 2) *
            sin(dLng / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }
}
