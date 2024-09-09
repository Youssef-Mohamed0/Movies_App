import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';

import '../basis/constants.dart';
import '../api/api.dart';
import '../basis/components.dart';
import '../models/movie_browse.dart';

class Browse extends StatefulWidget {
  const Browse({super.key});

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.background,
      body: Center(
        child: FutureBuilder(
            future: api.fetchGenres(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 3,
                  ),
                  itemBuilder: (context, index) {
                    return EasyContainer(
                        color: Colors.transparent,
                        showBorder: true,
                        borderColor: Colors.white,
                        borderRadius: 20,
                        borderWidth: 1,
                        onTap: () {
                          navigateTo(
                              context,
                              MovieBrowse(
                                name: snapshot.data!.genres[index].name,
                                genreIds: [snapshot.data!.genres[index].id],
                              ));
                        },
                        child: Center(
                          child: Text(
                            snapshot.data!.genres[index].name,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ));
                  },
                  itemCount: snapshot.data!.genres.length,
                );
              } else {
                return const Center(
                  child: Text(
                    'wait a moment',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                );
              }
            }),
      ),
    );
  }
}
