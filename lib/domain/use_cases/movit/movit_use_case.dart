import '../../models/movit/gateway/movit_gateway.dart';
import '../../models/movit/movit.dart';

class MovitUseCase {
  final MovitGateway movitGateway;
  MovitUseCase(this.movitGateway);
  Future<Movit> getMovits() => movitGateway.getMovits();
}
