import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/DetailPage/detail_screen.dart';

import 'package:metaozce/pages/HomePage/components/widgets/city_item.dart';
import 'package:metaozce/pages/HomePage/components/widgets/data.dart';
import 'package:metaozce/pages/HomePage/components/widgets/feauture_item.dart';

import 'package:metaozce/pages/HomePage/components/widgets/recommend_item.dart';
import 'package:metaozce/pages/HomePage/components/widgets/search_item.dart';
import 'package:metaozce/service/hotel_service.dart';
import 'package:metaozce/service/hotel_user_history_service.dart';
import 'package:metaozce/service/python_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedCity = "İstanbul";
  List filteredRecommends = [];
  final TextEditingController searchController = TextEditingController();
  List<dynamic> searchHotels = [];
  bool tiklandi = false;
  FocusNode focusNode = FocusNode();
  List<dynamic> allUserHistoryHotels = [];
  List<dynamic> allRecommendsHotels = [];

  fetchAllHotelUserHistory() async {
    final HotelUserHistoryService hotelUserHistoryService =
        HotelUserHistoryService();
    // HotelUserHistoryService'deki getHotelHistoryById metodunu çağırarak bir otel al
    try {
      final hotelData =
          await hotelUserHistoryService.getHotelHistoryByUserId(102);
      allUserHistoryHotels = List<dynamic>.from(hotelData);
      //print(allUserHistoryHotels);
      //print('Hotel Data: $hotelData');
      //fetchAllRecommendHotels();
    } catch (e) {
      print('Error: $e');
    }
  }

  fetchAllRecommendHotels() async {
    final PythonEntegration pythonEntegration = PythonEntegration();
    // HotelUserHistoryService'deki getHotelHistoryById metodunu çağırarak bir otel al
    try {
      final recommendsData = await pythonEntegration
          .getAllRecommendHotels(allUserHistoryHotels[0]['hotel']['otelAd']);
      allRecommendsHotels = List<dynamic>.from(recommendsData);
      //print(allRecommendsHotels);
      //print('Hotel Data: $recommendsData');
    } catch (e) {
      print('Error: $e');
    }
  }

  List<dynamic> allHotels = [];

  fetchAllHotels() async {
    final HotelService hotelService = HotelService();

    // HotelService'deki getHotelWithId metodunu çağırarak bir otel al
    try {
      List<dynamic> oteller = await hotelService.getHotelAll();
      setState(() {
        allHotels = List<dynamic>.from(oteller); // Tüm otelleri güncelle
        searchHotels = List<dynamic>.from(
            allHotels); // Başlangıçta tüm otelleri arama sonuçları olarak ayarla
      });
      //print('Hotel Data: $allHotels');
      return allHotels;
    } catch (e) {
      print('Error: $e');
    }
  }

  void queryListener() {
    search(searchController.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        searchHotels = List<Map<String, dynamic>>.from(
            allHotels); // all Hotel listesini searchHotels'e atar.
      });
    } else {
      setState(() {
        searchHotels = allHotels
            .where((e) => (e['otelAd'] as String)
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
    fetchAllHotels();
    fetchAllHotelUserHistory();
    // fetchAllRecommendHotels();
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
            //title: _builAppBar(),
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
        // Icon(
        //   Icons.place_outlined,
        //   color: Colors.blue,
        //   size: 20,
        // ),
        const SizedBox(
          width: 3,
        ),
        // Text(
        //   selectedCity,
        //   style: TextStyle(
        //     color: Colors.blue,
        //     fontSize: 13,
        //   ),
        // ),
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
              "Welcome to MetaOzce App",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
          _buildSearch(),
          //_buildCities(),
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
          _buildFeature(),
        ],
      ),
    );
  }

  _buildReccommended() {
    return FutureBuilder(
      future: fetchAllRecommendHotels(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Veriler başarıyla alındı
          return CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.4,
              enlargeCenterPage: true,
              disableCenter: true,
              viewportFraction: .75,
            ),
            items: List.generate(
              allRecommendsHotels.length,
              (index) {
                return RecommendItem(
                  data: allRecommendsHotels[index],
                  onTapFavorite: () {
                    setState(() {
                      // İlgili işlemler
                    });
                  },
                );
              },
            ),
          );
        }
      },
    );
  }

_buildFeature() {


    return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
    scrollDirection: Axis.vertical,
    child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: allHotels.length,
      itemBuilder: (context, index) {
        // Sadece ekranda görünecek olan otelleri yükle
        if (index < 20) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FeautureItem(
              data: allHotels[index],
            ),
          );
        } else {
          return Container(); // Diğer oteller için boş bir Container döndür
        }
      },
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
    return SingleChildScrollView(
      child: Column(
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
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
              height: tiklandi
                  ? MediaQuery.of(context).size.height * 0.75
                  : MediaQuery.of(context).size.height * 0.001,
              child: ListView.builder(
                itemCount: tiklandi ? searchHotels.length : allHotels.length,
                itemBuilder: (context, index) {
                  final hotel =
                      tiklandi ? searchHotels[index] : allHotels[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      focusColor: Colors.amber,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(hotel["imageurl"]),
                      ),
                      title: Text(
                        hotel["otelAd"],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // trailing: IconButton(
                      //   icon: Icon(Icons.add),
                      //   onPressed: () {
                      //      //TODO
                      //   },
                      // ),
                      subtitle: Text(
                        hotel["bolge"],
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(data: hotel["id"]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
