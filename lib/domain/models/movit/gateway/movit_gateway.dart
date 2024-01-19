import 'package:clean_arch_get/domain/models/movit/movit.dart';

abstract class MovitGateway {
   Future<Movit> getMovits();
}