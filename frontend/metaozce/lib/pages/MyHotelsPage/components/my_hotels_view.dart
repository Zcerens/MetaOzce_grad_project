import 'package:flutter/material.dart';

import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/DetailPage/detail_screen.dart';

import 'package:metaozce/pages/HomePage/components/widgets/data.dart';
import 'package:metaozce/pages/MyHotelsPage/components/widgets/hotel_item.dart';
import 'package:metaozce/service/hotel_service.dart';
import 'package:metaozce/service/hotel_user_history_service.dart'; // Renkleri içe aktardık

class MyHotelsView extends StatefulWidget {
  @override
  State<MyHotelsView> createState() => _MyHotelsViewState();
}

class _MyHotelsViewState extends State<MyHotelsView> {
  final TextEditingController searchController = TextEditingController();

  List<dynamic> searchHotels = [];

  bool tiklandi = false;

  FocusNode focusNode = FocusNode();
  List<dynamic> allHotels = [];
  List<dynamic> allUserHistoryHotels = [];

  fetchAllHotels() async {
    final HotelService hotelService = HotelService();

    // HotelService'deki getHotelWithId metodunu çağırarak bir otel al
    try {
      List<dynamic> oteller = await hotelService.getHotelAll();
      setState(() {
        allHotels = List<dynamic>.from(oteller); // Tüm otelleri güncelle
        searchHotels = List<dynamic>.from(allHotels); // Başlangıçta tüm otelleri arama sonuçları olarak ayarla
      });
      print('Hotel Data: $allHotels');
      return allHotels;
    } catch (e) {
      print('Error: $e');
    }
  }

  fetchAllHotelUserHistory() async {
    final HotelUserHistoryService hotelUserHistoryService =HotelUserHistoryService();
    // HotelUserHistoryService'deki getHotelHistoryById metodunu çağırarak bir otel al
   try {
    final hotelData = await hotelUserHistoryService.getHotelHistoryByUserId(102);
    allUserHistoryHotels = List<dynamic>.from(hotelData);
    print(allUserHistoryHotels);
    print('Hotel Data: $hotelData');
  } catch (e) {
    print('Error: $e');
  }
  }

  createHotelUserHistory(int hotelId, int userId) async {

      final HotelUserHistoryService hotelUserHistoryService = HotelUserHistoryService();

  // HotelService'deki getHotelWithId metodunu çağırarak bir otel al
  try {
  final response =  await hotelUserHistoryService.createHotelHistory(hotelId, 102); //TODO UserId değişecek

    print('Response : $response');
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
        searchHotels = List<dynamic>.from(
            allHotels); // Tüm otelleri arama sonuçları olarak ayarla
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

  @override
  void initState() {
    super.initState();
    fetchAllHotels();
    fetchAllHotelUserHistory();
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
      body: tiklandi
          ? Container(
              //color: Colors.teal,
              height: MediaQuery.of(context).size.height * 0.9,
              child: _buildSearch(),
            )
          : Column(
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
                    itemCount: allUserHistoryHotels.length, // Otellerin sayısı
                    itemBuilder: (context, index) {
                      final hotel = allUserHistoryHotels[index];
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
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 1, top: 10),
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
                hintText: "Add..",
                leading: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
                height: tiklandi
                    ? MediaQuery.of(context).size.height * 0.75
                    : MediaQuery.of(context).size.height * 0.001,
                child: searchHotels.isEmpty
                    ? Padding( padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                        child: Text(
                          "Not Found",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: tiklandi
                            ? searchHotels.length + 1
                            : allHotels.length + 1,
                        itemBuilder: (context, index) {
                          if (index ==
                              (tiklandi
                                  ? searchHotels.length
                                  : allHotels.length)) {
                            // Son eleman, yani artı butonu
                            return Container(color: Colors.red,
                            );
                          } else {
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
                                trailing: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                     createHotelUserHistory(searchHotels[index]['id'], 52);//TODO
                                  },
                                ),
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
                          }
                        },
                      )),
          ),
        ],
      ),
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
