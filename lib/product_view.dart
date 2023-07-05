import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// ignore: camel_case_types, must_be_immutable
class ProductView extends StatelessWidget {
  List<String> image;
  String description;
  String brand;
  ProductView(
      {super.key,
      required this.image,
      required this.description,
      required this.brand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          CarouselSlider.builder(
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ImageView(
                      photo: image,
                    );
                  }));
                },
                child: Container(
                  height: 400,
                  width: 400,
                  margin: const EdgeInsets.only(top: 20.0, left: 20.0),
                  child: PhotoView(
                    backgroundDecoration: const BoxDecoration(color: Colors.white),
                    enableRotation: true,
                    //  disableGestures: true,
                    //   tightMode: true,
                    imageProvider: NetworkImage(image[index]),
                    maxScale: 200.0,
                  ),
                  // child: Image.network(image[index]),
                ),
              );
            },
            options: CarouselOptions(
              height: 400,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
            itemCount: image.length,
          ),
          Text(
            description,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Brand :$brand",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ImageView extends StatelessWidget {
  List<String> photo;
  ImageView({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      itemCount: photo.length,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(photo[index]),
             minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 2,);
      },
      scrollPhysics: const BouncingScrollPhysics(),
      backgroundDecoration: const BoxDecoration(color: Colors.white),
    );
  }
}
