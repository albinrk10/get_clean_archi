
import 'package:http/http.dart' as http;
import '../../../../domain/models/movit/gateway/movit_gateway.dart';
import '../../../../domain/models/movit/movit.dart';
import 'errors/movit_api_error.dart';

class MovitDataApi extends MovitGateway{
  @override
  Future<Movit> getMovits() async {
    Uri url = Uri.parse('https://beedrone-dev.abexa.pe/api/Otp/listarRutasOtp?from=-11.977292208597389%2C%20-77.06823537444522&to=-12.040901909920489%2C%20-77.05962034374063');
    final response = await http.get(url);
    if(response.statusCode == 200 ){
      final movit = movitFromJson(response.body);
      return movit;
    }else {
      throw MovitApiError();
    }
  }

}