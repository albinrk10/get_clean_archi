import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_system_weincode/foundations/themes/weincode_themes.dart';
import '../config/routers/app_routes.dart';
import '../domain/models/movit/movit.dart';
import '../presentation/providers/astronomy_daily_data_provider.dart';
import '../presentation/providers/movit_provider.dart';
import '../presentation/providers/pokemon_provider.dart';
import '../presentation/screen/home_page.dart';
import '../presentation/screen/mapa_movit_page.dart';
import '../presentation/screen/movit_ruta_page.dart';
import '../presentation/screen/pokemon_page.dart';
import '../presentation/screen/show_dayli_data.dart';
import 'package:geolocator/geolocator.dart';

class CleanArchExampleSepareteUsingFolderApp extends ConsumerWidget {
  const CleanArchExampleSepareteUsingFolderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    

    return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ligthThemeWeincode,
    home: FutureBuilder<Position>(
      future: Geolocator.getCurrentPosition(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se espera el resultado
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Muestra un mensaje de error si algo sale mal
        } else {
          Position position = snapshot.data!;
          final fromLat = position.latitude;
          final fromLon = position.longitude;

          return Navigator(
            pages: [
              // Agrega tus rutas aquí
              MaterialPage(
                child: PokemonPage(
                  pokemonDetailList: ref.watch(pokemonProvider).getAllPokemons(),
                ),
              ),
              MaterialPage(
                child: ShowDailyDataPage(
                  astronomyDailyData: ref.watch(astronomyDailyDataProvider).getAstronomydailyData(),
                ),
              ),
              MaterialPage(
                child: Movitgape(
                  movit: ref.watch(moviProvider).getMovits(fromLat, fromLon),
                ),
              ),
              MaterialPage(
                child: MapScreen(
                  movit: ref.watch(moviProvider).getMovits(fromLat, fromLon),
                ),
              ),
            ],
            onPopPage: (route, result) => route.didPop(result),
          );
        }
      },
    ),
  );
  }
}
