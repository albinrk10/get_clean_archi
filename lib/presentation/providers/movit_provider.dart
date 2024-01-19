import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../domain/use_cases/movit/movit_use_case.dart';
import '../../infraestructure/driven_adapter/api/movit_api/movit_api.dart';

final moviProvider = Provider<MovitUseCase>((ref) {
  return MovitUseCase(MovitDataApi());
});
final geolocatorProvider = Provider<Geolocator>((ref) => Geolocator());