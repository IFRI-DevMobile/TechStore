import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:get/get.dart';
import 'package:code_initial/presentation/pages/Auth/CONNEXION/page_CONNEXION.dart';

class PageSplash extends StatelessWidget {
  const PageSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 3), // durée totale du splash
      onInit: () => debugPrint("Splash Init"),
      onEnd: () async {
        debugPrint("Splash End");
        // Pause courte avant le balayement
        await Future.delayed(const Duration(milliseconds: 500));
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
          const PageConnexion(),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
          transitionDuration: const Duration(milliseconds: 600),
        ));
      },
      childWidget: AnimatedLogo(),
    );
  }
}

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({super.key});

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // durée du fade+scale
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 90,
              width: 90,
              child: Image.asset("design/assets/NotreLogo.png"),
            ),
            const SizedBox(height: 10),
            const Text(
              "TechStore",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                inherit: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}








