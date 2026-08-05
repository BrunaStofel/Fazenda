import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'talhoes_page.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 420,
          height: 140,
          child: Image.asset(
            'assets/v2-itagiba-3-8.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(140, 160),
                            padding: EdgeInsets.zero,
                            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const TalhoesPage()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 72,
                                height: 72,
                                child: Lottie.asset('animations/map.json', fit: BoxFit.contain),
                              ),
                              const SizedBox(height: 12),
                              const Text('Talhões'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(140, 160),
                            padding: EdgeInsets.zero,
                            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const TalhoesPage()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 72,
                                height: 72,
                                child: Lottie.asset('animations/grafico.json', fit: BoxFit.contain),
                              ),
                              const SizedBox(height: 12),
                              const Text('Relatórios'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(140, 160),
                        padding: EdgeInsets.zero,
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const TalhoesPage()),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 72,
                            height: 72,
                            child: Lottie.asset('animations/plant.json', fit: BoxFit.contain),
                          ),
                          const SizedBox(height: 12),
                          const Text('Colheitas'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 360,
                height: 360,
                child: Lottie.asset(
                  'animations/corn.json',
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
