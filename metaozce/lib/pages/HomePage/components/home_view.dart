import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/DetailPage/detail_screen.dart';

import 'package:metaozce/pages/HomePage/components/widgets/city_item.dart';
import 'package:metaozce/pages/HomePage/components/widgets/data.dart';
import 'package:metaozce/pages/HomePage/components/widgets/feauture_item.dart';

import 'package:metaozce/pages/HomePage/components/widgets/recommend_item.dart';
import 'package:metaozce/pages/HomePage/components/widgets/search_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedCity = "İstanbul";
  List filteredRecommends = [];
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> searchHotels = [];
  bool tiklandi = false;
  FocusNode focusNode = FocusNode();

  void queryListener() {
    search(searchController.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        searchHotels = List<Map<String, dynamic>>.from(
            recommends); // recommends listesini searchHotels'e atar.
      });
    } else {
      setState(() {
        searchHotels = recommends
            .where((e) => (e['name'] as String)
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList(); // Query'ye göre otel isimlerini filtreler ve searchHotels'e atar.
      });
    }
  }

  void onCitySelected(String city) {
    setState(() {
      selectedCity = city; // Seçilen şehri güncelle
    });
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(queryListener);
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          tiklandi = false; // Klavye kapatıldığında tiklandi'yi false yap
        });
      }
    });
  }

  @override
  void dispose() {
    searchController.removeListener(queryListener);
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            snap: true,
            floating: true,
            title: _builAppBar(),
          ),
          SliverToBoxAdapter(
            child: _buildBody(context),
          ),
        ],
      ),
    );
  }

  Widget _builAppBar() {
    return Row(
      children: [
        Icon(
          Icons.place_outlined,
          color: Colors.blue,
          size: 20,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          selectedCity,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 13,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Text(
              "The Best Hotel Rooms",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
          _buildSearch(),
         
          _buildCities(),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Text(
              "Reccommended",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
          ),
          _buildReccommended(),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Feautured",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          _buildFeauture(),
        ],
      ),
    );
  }

  _buildReccommended() {
    List<Map<String, dynamic>> favoritedFeatures = [];

    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.4,
        enlargeCenterPage: true,
        disableCenter: true,
        viewportFraction: .75,
      ),
      items: List.generate(
        recommends.length,
        (index) {
          if (recommends[index]["is_favorited"]) {
            favoritedFeatures.add(recommends[index]);
          }
          return RecommendItem(
            data: recommends[index],
            onTapFavorite: () {
              setState(() {
                recommends[index]["is_favorited"] =
                    !recommends[index]["is_favorited"];
                if (recommends[index]["is_favorited"]) {
                  favoritedFeatures.add(recommends[index]);
                } else {
                  favoritedFeatures.remove(recommends[index]);
                }
              });
            },
          );
        },
      ),
    );
  }



  
  _buildFeauture() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(
          features.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FeautureItem(
              data: features[index],
            ),
          ),
        ),
      ),
    );
  }

  _buildCities() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 5, 0, 10),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          cities.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CityItem(
                data: cities[index],
                onCitySelected: (String cityName) {
                  setState(() {
                    selectedCity = cityName;
                  });
                }),
          ),
        ),
      ),
    );
  }



  _buildSearch() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.06,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: SearchBar(
              focusNode: focusNode,
              onTap: () {
                setState(() {
                  tiklandi = true;
                });
              },
              onSubmitted: (value) {
                setState(() {
                  tiklandi = false;
                });
              },
              controller: searchController,
              hintText: "Search..",
              leading: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left:8.0, right:8.0),
          child: Container(
            height: tiklandi
                ? MediaQuery.of(context).size.height * 0.2
                : MediaQuery.of(context).size.height * 0.01,
            child: ListView.builder(
              itemCount: tiklandi ? searchHotels.length : recommends.length,
              itemBuilder: (context, index) {
                final hotel = tiklandi ? searchHotels[index] : recommends[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(hotel["image"]),
                    ),
                    title: Text(hotel["name"]),
                    subtitle: Text(hotel["location"]),
                    
                    onTap: () {
                      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(data: hotel)), 
        );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  
}
