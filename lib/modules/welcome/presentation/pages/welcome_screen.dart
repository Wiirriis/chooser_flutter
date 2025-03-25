import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:go_router/go_router.dart'; // Usando GoRouter para la navegación
import '../constants/presentation_constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'title': '¿Dificultades tomando decisiones?',
      'description': 'Selecciona, personaliza y gestiona tus ideas fácilmente.',
      'image': 'assets/welcome/image13.png'
    },
    {
      'title': 'Escoge la mejor opción',
      'description':
          'Filtra y encuentra la mejor opción según tus preferencias.',
      'image': 'assets/welcome/image12.png'
    },
    {
      'title': 'Guarda y comparte',
      'description': 'Almacena tus elecciones y compártelas con otros.',
      'image': 'assets/welcome/image11.png'
    },
  ];

  void _goToHome() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLastPage = _currentPage + 1 == pages.length;

    return Scaffold(
      backgroundColor: PresentationConstants.colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: pages.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            pages[i]['image']!,
                          ),
                        ),
                        SizedBox(
                          height: (height >= 840) ? 60 : 30,
                        ),
                        Text(
                          pages[i]['title']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            fontSize: (width <= 550) ? 30 : 35,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          pages[i]['description']!,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w300,
                            fontSize: (width <= 550) ? 17 : 25,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: pages.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.black,
                      dotColor: Colors.black,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        isLastPage
                            ? const SizedBox()
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: AnimatedCrossFade(
                                  duration: const Duration(milliseconds: 500),
                                  firstChild: TextButton(
                                    onPressed: () {
                                      _pageController.jumpToPage(2);
                                    },
                                    style: TextButton.styleFrom(
                                      elevation: 0,
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: (width <= 550) ? 13 : 17,
                                      ),
                                    ),
                                    child: const Text(
                                      "SALTAR",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  secondChild: const SizedBox.shrink(), 
                                  crossFadeState: isLastPage
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                ),
                              ),

                        // Botón "SIGUIENTE"
                        Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedAlign(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            alignment: isLastPage
                                ? Alignment.center
                                : Alignment.centerRight,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              width: isLastPage ? 300 : 150,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  textStyle: TextStyle(
                                      fontSize: (width <= 550) ? 13 : 17),
                                ),
                                child: Text(
                                  isLastPage ? 'EMPEZAR' : 'SIGUIENTE',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
