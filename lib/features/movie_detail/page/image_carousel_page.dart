import 'package:flutter/material.dart';

class ImageCarouselPage extends StatelessWidget {
  const ImageCarouselPage({super.key, required this.movieName, required this.images});

  final String movieName;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movieName)),
      body: CarouselView.weighted(
        flexWeights: [1],
        itemSnapping: true,
        children: List.generate(images.length, (index) {
          return Image.network(images[index]);
        }),
      ),
    );
  }
}
