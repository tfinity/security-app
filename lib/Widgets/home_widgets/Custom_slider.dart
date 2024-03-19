import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:secure_me/Utilities/iit_quotes.dart';

class Custom_slider extends StatelessWidget {
  const Custom_slider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Container(
        child: CarouselSlider(
            items: List.generate(
                images_slider.length,
                (index) => Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(images_slider[index]))),
                              // Ading quotes on the slider if needed
    
                      // child: Align(
                      //     alignment: Alignment.bottomLeft,
                      //     child: Text(
                      //       title_slider[index],
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.white,
                      //         fontSize:
                      //             MediaQuery.of(context).size.width * 0.05,
                      //       ),
                      //     )),
                    ))),
            options: CarouselOptions(aspectRatio: 2.0, autoPlay: true, enlargeCenterPage: true)),
      ),
    );
  }
}
