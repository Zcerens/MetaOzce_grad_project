

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:metaozce/const/constant.dart';

import 'package:metaozce/pages/HomePage/components/widgets/data.dart';


import 'package:metaozce/pages/HomePage/widgets/city_item.dart';

import 'package:metaozce/pages/HomePage/widgets/recommend_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCity = "Phnom Penh";
   void onCitySelected(String city) {
    setState(() {
      selectedCity = city; // Seçilen şehri güncelle
    });
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
            child: _buildBody(),
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

  _buildBody() {
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
          ),_buildSearchBar()
          ,
          _buildCities(),
          const SizedBox(
            height: 10,
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Text(
              "Featured",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
          ),
          // _buildFeatured(),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommended",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Text(
                  "See all",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
          _getRecommend(),
        ],
      ),
    );
  }

  // _buildFeatured() {
  //   return CarouselSlider(
  //     options: CarouselOptions(
  //       height: 300,
  //       enlargeCenterPage: true,
  //       disableCenter: true,
  //       viewportFraction: .75,
  //     ),
  //     items: List.generate(
  //       features.length,
  //       (index) => FeatureItem(
  //         data: features[index],
  //         onTapFavorite: () {
  //           setState(() {
  //             features[index]["is_favorited"] =
  //                 !features[index]["is_favorited"];
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }
Widget _buildSearchBar() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    height: 40.0, // Arama çubuğunun yüksekliği
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0), // Köşelerin yuvarlanma yarıçapı
      border: Border.all(color: Color.fromARGB(255, 215, 239, 243),), // Kenar çizgisi rengi ve kalınlığı
    ),
    child: Theme(
      data: ThemeData(
        // Arama çubuğunun arka plan rengini sıfıra ayarla
        primaryColor: Colors.transparent,
        hintColor: Colors.transparent,
      ),
      child: const TextField(
        cursorColor: Colors.black, // Metin imlecinin rengi
        decoration: InputDecoration(
          hintText: "Search for hotels...",
          hintStyle: TextStyle(color: Colors.black87, fontSize: 14.0, fontWeight: FontWeight.w500), // Placeholder metin stili
          prefixIcon: Icon(Icons.search, color: iconColor), // Arama simgesi rengi
          border: InputBorder.none, // Kenar çizgisini kaldır
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0), // İçerik dolgusu
        ),
      ),
    ),
  );
}
  _getRecommend() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          recommends.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: RecommendItem(
              data: recommends[index],
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
               }
            ),
          ),
        ),
      ),
    );
  }
}