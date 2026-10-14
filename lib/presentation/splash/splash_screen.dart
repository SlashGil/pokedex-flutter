import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../pokedex_list/pokedex_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _transformController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _debugToProdProgress;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _transformController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeIn),
    );

    _debugToProdProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _transformController, curve: Curves.easeInOutCubic),
    );

    _entranceController.forward();

    if (kDebugMode) {
      // In Debug Mode: Entrance -> Transform Debug to Prod -> Navigate
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          _transformController.forward();
        }
      });

      Future.delayed(const Duration(milliseconds: 2100), () {
        _navigateToMain();
      });
    } else {
      // In Release Mode: Direct Prod Theme -> Navigate
      _transformController.value = 1.0;
      Future.delayed(const Duration(milliseconds: 1200), () {
        _navigateToMain();
      });
    }
  }

  void _navigateToMain() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) =>
              const PokedexListScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    }
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _transformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_entranceController, _transformController]),
      builder: (context, child) {
        final double t = _debugToProdProgress.value;

        // Interpolate background color: Dark Terminal (#0F172A) -> Clean Light (#F6F8FC)
        final Color bgColor = Color.lerp(
          const Color(0xFF0F172A),
          const Color(0xFFF6F8FC),
          t,
        )!;

        // Interpolate title color: Cyan (#38BDF8) -> Dark Grey (#2A2A2A)
        final Color textColor = Color.lerp(
          const Color(0xFF38BDF8),
          const Color(0xFF2A2A2A),
          t,
        )!;

        // Interpolate spinner color: Cyan (#38BDF8) -> Pokeball Red (#EE1515)
        final Color spinnerColor = Color.lerp(
          const Color(0xFF38BDF8),
          const Color(0xFFEE1515),
          t,
        )!;

        return Scaffold(
          backgroundColor: bgColor,
          body: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Morphing SVG Icon (Debug Wireframe -> Prod Pokeball)
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Opacity(
                            opacity: (1.0 - t).clamp(0.0, 1.0),
                            child: SvgPicture.asset(
                              'assets/icons/ic_pokedex_debug.svg',
                              width: 180,
                              height: 180,
                            ),
                          ),
                          Opacity(
                            opacity: t.clamp(0.0, 1.0),
                            child: SvgPicture.asset(
                              'assets/icons/ic_pokedex_prod.svg',
                              width: 180,
                              height: 180,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // App Title
                    Text(
                      'Pokédex',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Subtitle morph (DEBUG BUILD badge -> "Gotta Catch 'Em All!")
                    SizedBox(
                      height: 28,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Opacity(
                            opacity: (1.0 - t).clamp(0.0, 1.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E293B),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF38BDF8),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'DEBUG BUILD',
                                style: TextStyle(
                                  color: Color(0xFFFACC15),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: t.clamp(0.0, 1.0),
                            child: const Text(
                              'Gotta Catch \'Em All!',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF757575),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 48),

                    // Progress indicator
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: spinnerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
