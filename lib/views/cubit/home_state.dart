part of 'home_cubit.dart';

class HomeState extends Equatable {
  HomeState({
    this.cityName1,
    this.temp1 ,
    this.country1 ,
    this.isLoading1,
  });

  String? cityName1;

  dynamic temp1;

  String? country1;
  bool? isLoading1;

  @override
  List<Object> get props => [cityName1!, temp1!, country1!, isLoading1!];
  HomeState copyWith({
   String? cityName,
   dynamic temp,
   String? country,
   bool? isLoading,
  }) {
    return HomeState(
      cityName1: cityName ?? cityName1,
      temp1: temp ?? temp1,
      country1: country ?? country1,
      isLoading1: isLoading ?? isLoading1,
    );
  }
}
