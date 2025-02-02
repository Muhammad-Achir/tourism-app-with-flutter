import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/api/api_sevice.dart';
import 'package:tourism_app/data/model/tourism..dart';
import 'package:tourism_app/data/model/tourism_list_response.dart';
import 'package:tourism_app/provider/home/tourism_list_provider.dart';
import 'package:tourism_app/screen/home/tourism_card_widget.dart';
import 'package:tourism_app/static/navigation_route.dart';
import 'package:tourism_app/static/tourism_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late Future<TourismListResponse> _futureTourismResponse;

  @override
  void initState() {
    super.initState();
    // _futureTourismResponse = ApiService().getTourismList();
    // _futureTourismResponse.then((response) {
    //   print('home');
    // print(response.message);
    //   print('places');
    // print(response.places);
    // }).catchError((e){

    // });

    Future.microtask(() {
      context.read<TourismListProvider>().fetchTourismList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism List"),
      ),
      // body: FutureBuilder(
      //   future: _futureTourismResponse,
      //   builder: (context, snapshot) {
      //     switch (snapshot.connectionState) {
      //       case ConnectionState.waiting:
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       case ConnectionState.done:
      //         {
      //           if (snapshot.hasError) {
      //             return Center(
      //               child: Text(
      //                 snapshot.error.toString(),
      //               ),
      //             );
      //           }

      //           final listOfTourism = snapshot.data!.places;
      //           return ListView.builder(
      //             itemCount: listOfTourism.length,
      //             itemBuilder: (context, index) {
      //               final tourism = listOfTourism[index];

      //               return TourismCard(
      //                 tourism: tourism,
      //                 onTap: () {
      //                   Navigator.pushNamed(
      //                     context,
      //                     NavigationRoute.detailRoute.name,
      //                     arguments: tourism.id,
      //                   );
      //                 },
      //               );
      //             },
      //           );
      //         }
      //       default:
      //         return const SizedBox();
      //     }
      //   },
      // ),
      body: Consumer<TourismListProvider>(builder: (
        context,
        value,
        child,
      ) {
        return switch (value.resulstState) {
          TourismListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
          TourismListLoadedState(data: var tourismList) => ListView.builder(
              itemCount: tourismList.length,
              itemBuilder: (context, index) {
                final tourism = tourismList[index];

                return TourismCard(
                  tourism: tourism,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NavigationRoute.detailRoute.name,
                      arguments: tourism.id,
                    );
                  },
                );
              },
            ),
          TourismListErrorState(error: var message) => Center(
              child: Text(message),
            ),
          _ => const SizedBox(),
        };
      }),
    );
  }
}
