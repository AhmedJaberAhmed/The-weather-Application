import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 import '../../../utils/AppTheme.dart';
import '../cubits/WeatherCubit.dart';
import '../cubits/weather_cubit/weather_state.dart';
import '../widgets/SearchField.dart';
import '../widgets/WeatherCard.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Weather')),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          List<Color> gradient = const [Color(0xFF4A90E2), Color(0xFF7B68EE)];
          if (state is WeatherLoaded) {
            gradient = WeatherVisuals.gradientFor(state.weather.condition);
          }

          return AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth > 600 ? 480.0 : double.infinity;
                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                        child: Column(
                          children: [
                            const SearchField(),
                            const SizedBox(height: 32),
                            Expanded(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                child: _buildContent(context, state),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, WeatherState state) {
    if (state is WeatherLoading) {
      return const Center(
        key: ValueKey('loading'),
        child: CircularProgressIndicator(color: Colors.white),
      );
    }
    if (state is WeatherLoaded) {
      return SingleChildScrollView(
        key: const ValueKey('loaded'),
        child: WeatherCard(weather: state.weather, isOffline: state.isOffline),
      );
    }
    if (state is WeatherError) {
      return Center(
        key: const ValueKey('error'),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded, color: Colors.white, size: 40),
              const SizedBox(height: 12),
              Text(
                state.message,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
    return Center(
      key: const ValueKey('initial'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.wb_sunny_rounded, color: Colors.white, size: 72),
          SizedBox(height: 16),
          Text(
            'Search for a city to see the weather',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}