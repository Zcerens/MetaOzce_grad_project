import 'package:flutter/material.dart';

import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/DetailPage/detail_screen.dart';

import 'package:metaozce/pages/HomePage/components/widgets/data.dart';
import 'package:metaozce/pages/MyHotelsPage/components/widgets/hotel_item.dart'; // Renkleri içe aktardık

class MyHotelsView extends StatefulWidget {
  @override
  State<MyHotelsView> createState() => _MyHotelsViewState();
}

class _MyHotelsViewState extends State<MyHotelsView> {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSearch(),
          SizedBox(height: 10),
               Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Text(
              "My Visited Hotel",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recommends.length, // Otellerin sayısı
              itemBuilder: (context, index) {
                final hotel = recommends[index];
                return HotelItem(
                  data: hotel,
                  
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildSearch() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 1, top:10),
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
                ? MediaQuery.of(context).size.height * 0.2
                : MediaQuery.of(context).size.height * 0.01,
            child: ListView.builder(
              itemCount: tiklandi ? searchHotels.length : recommends.length,
              itemBuilder: (context, index) {
                final hotel =
                    tiklandi ? searchHotels[index] : recommends[index];
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
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(data: hotel)),
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

Widget _buildSearchBar(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    height:
        MediaQuery.of(context).size.width * 0.1, // Arama çubuğunun yüksekliği
    decoration: BoxDecoration(
      borderRadius:
          BorderRadius.circular(12.0), // Köşelerin yuvarlanma yarıçapı
      border:
          Border.all(color: Colors.grey), // Kenar çizgisi rengi ve kalınlığı
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
          hintText: "Add Hotel",
          hintStyle: TextStyle(
              color: Colors.black87,
              fontSize: 14.0,
              fontWeight: FontWeight.w500), // Placeholder metin stili
          prefixIcon:
              Icon(Icons.search, color: iconColor), // Arama simgesi rengi
          border: InputBorder.none, // Kenar çizgisini kaldır
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15.0), // İçerik dolgusu
        ),
      ),
    ),
  );
}
