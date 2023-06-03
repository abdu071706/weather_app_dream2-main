import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_app/constants/texts/app_text.dart';
import 'package:weather_app/data/services/get_geolocation.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(
            cityName1: '', country1: '', isLoading1: true, temp1: ''));

  void showWeather() async {
    final position = await GetGeoLocation().getPosition();
    log('position latitude ====> ${position.latitude}');
    log('position longitude ====> ${position.longitude}');
    getCurrentWeatherHttp(position: position);
  }

  Future<void> getCurrentWeatherHttp({Position? position}) async {
    final client = Client();
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${position!.latitude}&lon=${position.longitude}&appid=${AppText.myApiKey}';
    final uri = Uri.parse(url);
    try {
      final joop = await client.get(uri);
      if (joop.statusCode == 200 || joop.statusCode == 201) {
        final data = joop.body;
        final jsonData = jsonDecode(data);
        final double kelvin = jsonData['main']['temp'];
        emit(state.copyWith(
          cityName: jsonData['name'],
          country: jsonData['sys']['country'],
          temp:  (kelvin - 273.15).toStringAsFixed(0),
          isLoading: false,
        ));
    // final cityName1 = jsonData['name'];
    //     final country1 = jsonData['sys']['country'];
        // final kelvin1 = (kelvin - 273.15).toStringAsFixed(0);
        // log('kelvin ===> $state.kelvin');
        // log('temp ===> ${state.kelvin1.toString()}');
      }

      log('Cityname  ====> ${state.cityName1}');

      // state.isLoading1 = f;
    } catch (e) {
      log('===>  $e');
    }
  }

  Future<void> getTypedCityName({String? cityNamediBer}) async {
    state.isLoading1 = true;
    try {
      final client = Client();
      final String apiUrl =
          'https://api.openweathermap.org/data/2.5/weather?q=${cityNamediBer!}&appid=${AppText.myApiKey}';

      final uri = Uri.parse(apiUrl);
      final joop = await client.get(uri);
      if (joop.statusCode == 200 || joop.statusCode == 201) {
        final data = joop.body;
        final jsonData = jsonDecode(data);
        final double kelvin = jsonData['main']['temp'];
        emit(state.copyWith(
cityName: jsonData['name'], 
country: jsonData['sys']['country'], 
temp: (kelvin - 273.15).toStringAsFixed(0),
isLoading: false, 

       
        ));
        // state.cityName1 = jsonData['name'];
        // state.country1 = jsonData['sys']['country'];
        // state.kelvin1 = (kelvin - 273.15).toStringAsFixed(0);
        // log('kelvin ===> $kelvin');
        // log('temp ===> ${state.kelvin1.toString()}');
        // state.isLoading1 = false;
      }
    } catch (e) {}
  }
}
