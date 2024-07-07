// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:induktif/data/theme/induktif_theme.dart';

class DetailScreen extends StatefulWidget {
  final String? url;
  final Map<String, String>? cookies;

  const DetailScreen({super.key, this.url, this.cookies});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  double _rotation = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: InduktifTheme.dark_grey,
        title: const Text('Image Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              setState(() {
                _scale *= 1.5;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              setState(() {
                _scale /= 1.5;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.rotate_left),
            onPressed: () {
              setState(() {
                _rotation -= 90.0;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.rotate_right),
            onPressed: () {
              setState(() {
                _rotation += 90.0;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(20.0),
          minScale: 0.1,
          maxScale: 4.0,
          constrained: false,
          scaleEnabled: true,
          onInteractionStart: (ScaleStartDetails details) {
            _previousScale = _scale;
          },
          onInteractionUpdate: (ScaleUpdateDetails details) {
            setState(() {
              _scale = _previousScale * details.scale;
            });
          },
          child: Transform.rotate(
            angle: _rotation * math.pi / 180,
            child: Transform.scale(
                scale: _scale,
                child: CachedNetworkImage(
                  imageUrl: widget.url!,
                  httpHeaders: widget.cookies,
                )),
          ),
        ),
      ),
    );
  }
}
