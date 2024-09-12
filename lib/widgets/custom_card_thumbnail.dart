import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/movie_detail/movie_detail_page.dart';

class CustomCardThumbnail extends StatelessWidget {
  final String imageAsset;
  final Movie movie;

  const CustomCardThumbnail({super.key, required this.imageAsset, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return MovieDetailPage(movieId: movie.id);
          }),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(
              '$imageUrl$imageAsset',
            ),
            fit: BoxFit.cover,
          ),
        ),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 30),
      ),
    );
  }
}
