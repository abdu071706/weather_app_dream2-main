import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_app/constants/texts/app_text.dart';
import 'package:weather_app/views/search_view.dart';

import 'cubit/home_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).showWeather();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  context.read<HomeCubit>().showWeather();
                },
                child: Icon(
                  Icons.near_me,
                  size: 40,
                ),
              );
            },
          ),
          actions: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () async {
                    var result = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchView()));
                    context
                        .read<HomeCubit>()
                        .getTypedCityName(cityNamediBer: result );
                  },
                  icon: Icon(
                    Icons.location_city,
                    size: 40,
                  ),
                );
              },
            )
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: state.isLoading1 == true
                  ? Center(child: CircularProgressIndicator())
                  : Stack(
                      children: [
                        Positioned(
                          top: 90,
                          left: 40,
                          child: Text(
                            '${state.temp1}°C',
                            style: TextStyle(
                              fontSize: 75,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 40,
                          child: Text(
                            'Country: ${state.country1}',
                            style: TextStyle(
                              fontSize: 45,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 60,
                          left: 190,
                          child: Text(
                            ' ⛅',
                            style: TextStyle(
                              fontSize: 75,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 220,
                          left: 100,
                          right: 0,
                          child: Text(
                            'Jiluu \n kiyinip 👕   \n chyk',
                            style: TextStyle(
                              fontSize: 55,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '${state.cityName1}',
                            style: TextStyle(
                              fontSize: 55,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
