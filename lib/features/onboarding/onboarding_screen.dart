import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/datasources/local_datasource.dart';
import 'package:takip/features/onboarding/onboarding_notifier.dart';
import 'package:takip/features/splash_screen/splash_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    _checkOnboarding();
    Future.microtask(() {
      ref.read(onboardingNotifierProvider.notifier).getOnboardingData();
    });
  }

  final PageController _controller = PageController();
  int _currentIndex = 0;

  void _nextPage(int length) {
    if (_currentIndex < length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _basla() async {
    final localDataSource = sl<LocalDataSource>();
    await localDataSource.setOnboardingSeen();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }

  Future<void> _checkOnboarding() async {
    final localDataSource = sl<LocalDataSource>();
    final isOnboardingSeen = await localDataSource.getOnboardingSeen();

    if (isOnboardingSeen != null && isOnboardingSeen) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer(
            builder: (context, provider, child) {
              final state = ref.watch(onboardingNotifierProvider);
              final allItems = state.data;
              if (state.isLoading && allItems.length == 0) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (!state.isLoading && allItems.length == 0) {
                return Center(
                  child: Text(
                    LocalizationHelper.of(context).herhangiveribulunamadi,
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemCount: allItems.length,
                      itemBuilder: (_, index) {
                        final page = allItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                page.baslik,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Image.network(page.resim, height: 320),
                              const SizedBox(height: 32),
                              Text(
                                page.description,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: allItems.length,
                    effect: WormEffect(
                      activeDotColor: Colors.deepPurple,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (_currentIndex != allItems.length - 1)
                          ElevatedButton(
                            onPressed: () => _nextPage(allItems.length),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: Text(
                              LocalizationHelper.of(context).ileri,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (_currentIndex == allItems.length - 1)
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _basla();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          LocalizationHelper.of(context).basla,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
