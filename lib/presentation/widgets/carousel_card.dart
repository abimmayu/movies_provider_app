import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_propnext/common/constant.dart';
import 'package:movie_propnext/domain/dummy_movie.dart';
import 'package:movie_propnext/domain/entities/movies/movie.dart';
import 'package:movie_propnext/domain/entities/tv/tv.dart';
import 'package:movie_propnext/presentation/pages/movies/movie_detail_page.dart';
import 'package:movie_propnext/presentation/pages/tv/tv_detail_page.dart';

Widget carouselCard(dynamic data, BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: GestureDetector(
          onTap: () {
            if (data is Tv) {
              Navigator.pushNamed(
                context,
                TelevisionDetailPage.ROUTE_NAME,
                arguments: data.id,
              );
            } else if (data is Movie) {
              Navigator.pushNamed(
                context,
                MovieDetailPage.ROUTE_NAME,
                arguments: data.id,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            child: Container(
              // height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      '$BASE_IMAGE_URL${data.posterPath}'),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 20),
        child: Text(
          data.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}
