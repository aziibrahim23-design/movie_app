import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MovieApp());

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData.dark(useMaterial3: true)
          .copyWith(scaffoldBackgroundColor: const Color(0xFF0D0D0D)),
      home: const HomePage(),
    );
  }
}

// ---------------------------------------------------------------------------
// Model & dummy data
// ---------------------------------------------------------------------------
class Movie {
  final String title;
  final String year;
  final String genre;
  final String overview;
  final String poster;

  const Movie({
    required this.title,
    required this.year,
    required this.genre,
    required this.poster,
    this.overview = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  });
}

// Poster.
String _img(String seed, {int w = 400, int h = 600}) =>
    'https://picsum.photos/seed/$seed/$w/$h';

final List<Movie> nowPlaying = [
  Movie(
    title: 'Deadpool & Wolverine',
    year: '2024',
    genre: 'Action',
    poster: _img('deadpool', w: 800, h: 600),
  ),
  Movie(
    title: 'Inside Out 2',
    year: '2024',
    genre: 'Animation',
    poster: _img('insideout', w: 800, h: 600),
  ),
  Movie(
    title: 'Twisters',
    year: '2024',
    genre: 'Adventure',
    poster: _img('twisters', w: 800, h: 600),
  ),
  Movie(
    title: 'Alien: Romulus',
    year: '2024',
    genre: 'Sci-Fi',
    poster: _img('alien', w: 800, h: 600),
  ),
];

final List<Movie> trending = List.generate(
  8,
  (i) => Movie(
    title: 'Trending ${i + 1}',
    year: '2024',
    genre: 'Action',
    poster: _img('trending$i'),
  ),
);

final List<Movie> popular = List.generate(
  8,
  (i) => Movie(
    title: 'Popular ${i + 1}',
    year: '2024',
    genre: 'Drama',
    poster: _img('popular$i'),
  ),
);

final List<Movie> topRated = List.generate(
  8,
  (i) => Movie(
    title: 'Top Rated ${i + 1}',
    year: '2023',
    genre: 'Drama',
    poster: _img('toprated$i'),
  ),
);

// ---------------------------------------------------------------------------
// Home page
// ---------------------------------------------------------------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Now Playing',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF151515),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const NowPlayingCarousel(),
          const SizedBox(height: 16),
          MovieSection(title: 'Trending', movies: trending),
          MovieSection(title: 'Popular', movies: popular),
          MovieSection(title: 'Top Rated', movies: topRated),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Now Playing carousel (carousel_slider)
// ---------------------------------------------------------------------------
class NowPlayingCarousel extends StatelessWidget {
  const NowPlayingCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: nowPlaying.length,
      options: CarouselOptions(
        height: 230,
        viewportFraction: 0.92,
        enlargeCenterPage: false,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
      ),
      itemBuilder: (context, index, realIndex) {
        final movie = nowPlaying[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  movie.poster,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: Colors.grey[850]),
                ),
                // gradient agar teks terbaca
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black87],
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  right: 60,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${movie.year}   ${movie.genre}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        movie.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 16,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Section (judul + "More" + list poster horizontal)
// ---------------------------------------------------------------------------
class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const MovieSection({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'More',
                    style: TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 140,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: Image.network(
                      movie.poster,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: Colors.grey[850]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
