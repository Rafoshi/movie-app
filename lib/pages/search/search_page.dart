import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/top_rated/widgets/top_rated_movie.dart';
import 'package:movie_app/services/api_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ApiServices apiServices = ApiServices();
  var searchInput = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CupertinoSearchTextField(
                  padding: const EdgeInsets.all(10.0),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                  style: const TextStyle(color: Colors.white),
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  onChanged: (value) {
                    setState(() {
                      searchInput = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<Result>(
                future: apiServices.getSearchedMovie(searchInput),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  if(snapshot.hasData && snapshot.data!.movies.isEmpty) {
                    return const Center(
                      child: Text('No data found'),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.movies.length,
                      itemBuilder: (context, index) {
                          return TopRatedMovie(movie: snapshot.data!.movies[index]);
                      },
                    );
                  }
                  return const Center(
                    child: Text('No data found'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
