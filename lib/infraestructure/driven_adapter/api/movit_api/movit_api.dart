
import 'package:http/http.dart' as http;
import '../../../../domain/models/movit/gateway/movit_gateway.dart';
import '../../../../domain/models/movit/movit.dart';
import 'errors/movit_api_error.dart';

// class MovitDataApi extends MovitGateway{
//   @override
//   Future<Movit> getMovits() async {
//     Uri url = Uri.parse('https://beedrone-dev.abexa.pe/api/Otp/listarRutasOtp?from=-11.915728408209805%2C-77.05261230468751&to=-12.113515738274808%2C-77.02617645263673');
//     final response = await http.get(url);
//     if(response.statusCode == 200 ){
//       final movit = movitFromJson(response.body);
//       return movit;
//     }else {
//       throw MovitApiError();
//     }
//   }

// }
class MovitDataApi extends MovitGateway{
  @override
  Future<Movit> getMovits(double fromLat, double fromLon) async {
    Uri url = Uri.parse('https://beedrone-dev.abexa.pe/api/Otp/listarRutasOtp?from=$fromLat%2C$fromLon&to=-12.113515738274808%2C-77.02617645263673');
    final response = await http.get(url);
    if(response.statusCode == 200 ){
      final movit = movitFromJson(response.body);
      return movit;
    }else {
      throw MovitApiError();
    }
  }
}