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

class CleanArchExampleSepareteUsingFolderApp extends ConsumerWidget {
  const CleanArchExampleSepareteUsingFolderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ligthThemeWeincode,
      onGenerateRoute: (routeSetting) {
        switch (routeSetting.name) {
          case (AppRoutes.pokemon):
            return MaterialPageRoute(
                builder: ((context) => PokemonPage(
                      pokemonDetailList:
                          ref.watch(pokemonProvider).getAllPokemons(),
                    )));
          case (AppRoutes.astronomyDailyData):
            return MaterialPageRoute(
                builder: ((context) => ShowDailyDataPage(
                      astronomyDailyData: ref
                          .watch(astronomyDailyDataProvider)
                          .getAstronomydailyData(),
                    )));
          case (AppRoutes.movit):
            return MaterialPageRoute(
                builder: ((context) => Movitgape(
                      movit: ref.watch(moviProvider).getMovits(),
                    )));
          case (AppRoutes.mapaMovit):
            return MaterialPageRoute(
              builder: (context) => FutureBuilder<Movit>(
                future: ref.watch(moviProvider).getMovits(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se espera el resultado
                  } else if (snapshot.hasError) {
                    return Text(
                        'Error: ${snapshot.error}'); // Muestra un mensaje de error si algo sale mal
                  } else {
                    return MapScreen(
                        movit: snapshot
                            .data!); // Usa los datos cuando estén disponibles
                  }
                },
              ),
            );
          default:
            return MaterialPageRoute(builder: ((context) => const HomePage()));
        }
      },
    );
  }
}
