import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter/core/components/custom/weather_text.dart';
import 'package:weather_flutter/features/weather/application/weather_viewmodel.dart';

import '../../../../core/util/location_helper.dart';

class SelectableCityBottomSheet extends StatelessWidget {
  const SelectableCityBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = context.watch<WeatherViewModel>();

    return ListView.separated(
      padding: const EdgeInsets.only(top: 32, left: 24, right: 24),
      itemCount: weatherViewModel.selectableCitiesGeo.length,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.grey,
        height: 1,
      ),
      itemBuilder: (context, index) {
        final e = weatherViewModel.selectableCitiesGeo[index];

        return FutureBuilder<String?>(
            future: LocationHelper.cityNameFromCoordinates(e.lat, e.long),
            builder: (context, snapshot) {
              if (snapshot.data == null) return const CircularProgressIndicator.adaptive();

              return GestureDetector(
                onTap: () {
                  weatherViewModel.updateSelectedChangableGeo(weatherViewModel.selectableCitiesGeo.indexWhere((element) => element == e));
                },
                child: AnimatedContainer(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  duration: const Duration(milliseconds: 300),
                  height: 60,
                  width: double.maxFinite,
                  color: weatherViewModel.selectedChangableGeo == weatherViewModel.selectableCitiesGeo.firstWhere((element) => element == e) ? Colors.blue : Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        WeatherText(
                          text: snapshot.requireData ?? "-",
                          size: 18,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
