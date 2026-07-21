import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theweatherapplication/presentation/views/cubits/WeatherCubit.dart';
import 'package:theweatherapplication/presentation/views/pages/WeatherPage.dart';
import 'package:theweatherapplication/utils/AppTheme.dart';
import 'package:theweatherapplication/utils/GetWeatherUseCase.dart';
import 'package:theweatherapplication/utils/GetCachedWeatherUseCase.dart';

import 'data/repos_imp/WeatherLocalDataSource.dart';
import 'data/repos_imp/WeatherRemoteDataSource.dart';
import 'data/repos_imp/weather_repo_imp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final remoteDataSource = WeatherRemoteDataSourceImpl(dio);
    final localDataSource = WeatherLocalDataSourceImpl(sharedPreferences);
    final repository = WeatherRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
    final getWeatherUseCase = GetWeatherUseCase(repository);
    final getCachedWeatherUseCase = GetCachedWeatherUseCase(repository);

    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: BlocProvider(
        create: (_) => WeatherCubit(getWeatherUseCase, getCachedWeatherUseCase),
        child: const WeatherPage(),
      ),
    );
  }
}