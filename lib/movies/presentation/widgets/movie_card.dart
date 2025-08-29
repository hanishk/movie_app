import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/movie/${movie.id}");
      },
      child: SizedBox(
        width: 140,
        child: Column(
          mainAxisSize: MainAxisSize.min, // 👈 prevents overflow
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                width: 140,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 140,
                  height: 220,
                  color: Colors.grey.shade800,
                  child: const Icon(Icons.broken_image, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
