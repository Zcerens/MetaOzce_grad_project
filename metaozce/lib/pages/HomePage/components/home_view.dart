import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:metaozce/const/constant.dart';

import 'package:metaozce/pages/HomePage/components/widgets/city_item.dart';
import 'package:metaozce/pages/HomePage/components/widgets/data.dart';
import 'package:metaozce/pages/HomePage/components/widgets/feauture_item.dart';

import 'package:metaozce/pages/HomePage/components/widgets/recommend_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedCity = "İstanbul";
  List filteredRecommends = [];
  final TextEditingController searchController = TextEditingController();
  List searchHotels = [];

  void queryListener() {
    search(searchController.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        searchHotels = recommends;
      });
    } else {
      setState(() {
        searchHotels = recommends
            .where((e) => e.toLowerCase().contains(query.toLowerCase()))
            .toList();
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
  }

  @override
  void dispose() {
    searchController.removeListener(queryListener);
    searchController.dispose();
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
        // buildSearch(),
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
          _buildSearchBar(),
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

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      height: MediaQuery.of(context).size.width * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.transparent,
          hintColor: Colors.transparent,
        ),
        child: TextField(
          onChanged: (value) {
            // Kullanıcının girdiği değeri al
            String filterText = value.toLowerCase();
            // Önerileri filtrele
            List filteredRecommends = recommends.where((recommend) {
              return recommend['name'].toLowerCase().contains(filterText);
            }).toList();

            setState(() {
              this.filteredRecommends = filteredRecommends;
            });
          },
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            hintText: "Search for hotels...",
            hintStyle: TextStyle(
                color: Colors.black87,
                fontSize: 14.0,
                fontWeight: FontWeight.w500), // Placeholder metin stili
            prefixIcon: Icon(Icons.search, color: iconColor),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
          ),
        ),
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

  buildSearch(){
     return Column(
            children: [ 
              SearchBar(
            controller: searchController,
            hintText: "Search..",
            leading: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ),
         
              ListView.builder(
                itemCount: searchHotels.isEmpty ? searchHotels.length : recommends.length,
                itemBuilder: (context,index){
                  final hotel = searchHotels.isEmpty ? recommends[index]  : searchHotels[index];
                  return Card(
                    child: Column(
                      children: [
                        Text(hotel)
                      ],
                    ),
                  );
              
                },
              ),
            ],
          );
  }
}
