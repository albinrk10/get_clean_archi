import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_cases/astronomy_daily_data/astronomy_detail_data.dart';
import '../../infraestructure/driven_adapter/api/astronomy_daily_data_api/astronomy_daily_data_api.dart';


final astronomyDailyDataProvider = Provider<AstronomyDailyDataUseCase> ((ref) {
  return AstronomyDailyDataUseCase(AstronomyDailyDataApi());
},);