import 'package:flutter/material.dart';
import 'package:movies_final/api/api.dart';

import '../basis/constants.dart';
import '../basis/components.dart';
import '../screens/details_screen.dart';



class MovieBrowse extends StatefulWidget {
  final String name;
  final List<int> genreIds;

  const MovieBrowse({super.key, required this.name, required this.genreIds});

  @override
  State<MovieBrowse> createState() => _MovieBrowseState();
}

class _MovieBrowseState extends State<MovieBrowse> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.background,
      appBar: AppBar(
        backgroundColor: constants.background,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)
        ),
        title: Text(widget.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder(
            future:api.fetchMoviesByGenres(widget.genreIds),
            builder: (context,snapshot){
              if(snapshot.hasData)
                {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,  // Number of columns in the grid
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.5,  // Adjust the aspect ratio of the grid items
                    ),
                    itemBuilder: (context,index){
                      final movie = snapshot.data!.movies[index];
                      return GestureDetector(
                        onTap: () {
                          navigateTo(context, DetailsScreen(id: movie.id, name: movie.title));
                        },
                        child: Card(
                          elevation: 2.0,
                          color: Colors.transparent,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(movie.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,color: Colors.amber,),
                                        const SizedBox(width: 10,),
                                        Text('${movie.vote_average}',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.movies.length,
                  );
                }
              else if(snapshot.hasError) {
                return const Center(child: Text('Error'),);
              }
              else{return const CircularProgressIndicator();}
            }
          ),
        ),
      ),
    );
  }
}
