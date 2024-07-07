import 'package:flutter/material.dart';
import 'package:induktif/data/theme/material_theme.dart';

class TestWarna extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Warna Berbeda'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ColorBox(color: MaterialTheme.athensGray),
              ColorBox(color: MaterialTheme.brandy),
              ColorBox(color: MaterialTheme.casper),
              ColorBox(color: MaterialTheme.lilac),
              ColorBox(color: MaterialTheme.limedOak),
              ColorBox(color: MaterialTheme.mariner),
              ColorBox(color: MaterialTheme.mojo),
              ColorBox(color: MaterialTheme.puertoRico),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorBox extends StatelessWidget {
  final Color color;

  const ColorBox({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}
