import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/DetailPage/detail_screen.dart';
import 'package:metaozce/pages/HomePage/components/widgets/data.dart';
import 'package:metaozce/pages/MyHotelsPage/components/widgets/hotel_item.dart';
import 'package:metaozce/pages/MyHotelsPage/my_hotels_screen.dart';
import 'package:metaozce/service/cache_service.dart';
import 'package:metaozce/service/hotel_service.dart';
import 'package:metaozce/service/hotel_user_history_service.dart';

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
  Map<String, String> allUserData = {};
  CacheService cacheService = CacheService();
  String userIdSon = "";

  @override
  void initState() {
    super.initState();
    getCachedUserData();
  }

  @override
  void dispose() {
    searchController.removeListener(queryListener);
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  getCachedUserData() async {
    try {
      final cachedUserData = await cacheService.getCachedUserData();

      final userId = cachedUserData['id'];
      setState(() {
        userIdSon = userId!;
      });
      if (userId != null) {
        allUserData = cachedUserData;
        fetchAllHotels();
        fetchAllHotelUserHistory();
      } else {
        print('Cached User Data: $cachedUserData');
        print('Error: User id is null');
      }
    } catch (e) {
      print('Error retrieving cached user data: $e');
    }
  }

  fetchAllHotels() async {
    final HotelService hotelService = HotelService();
    try {
      List<dynamic> oteller = await hotelService.getHotelAll();
      setState(() {
        allHotels = List<dynamic>.from(oteller);
        searchHotels = List<dynamic>.from(allHotels);
      });
      //print('Hotel Data: $allHotels');
    } catch (e) {
      print('Error: $e');
    }
  }

  fetchAllHotelUserHistory() async {
    final HotelUserHistoryService hotelUserHistoryService =
        HotelUserHistoryService();
    try {
      final hotelData = await hotelUserHistoryService
          .getHotelHistoryByUserId(int.parse(userIdSon));
      setState(() {
        allUserHistoryHotels = List<dynamic>.from(hotelData);
      });
      // print('Hotel Data: $hotelData');
    } catch (e) {
      print('Error: $e');
    }
  }

  createHotelUserHistory(int hotelId, int userId) async {
    final HotelUserHistoryService hotelUserHistoryService =
        HotelUserHistoryService();
    try {
      final response =
          await hotelUserHistoryService.createHotelHistory(hotelId, userId);
      Fluttertoast.showToast(
          msg: "Hotel added to user history",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
          refreshMyHotels();
           Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHotelsScreen(),
        ),
      );
      // print('Response : $response');
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
          msg: "Hotel cannot add to user history",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void queryListener() {
    search(searchController.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        searchHotels = List<dynamic>.from(allHotels);
      });
    } else {
      setState(() {
        searchHotels = allHotels
            .where((e) => (e['otelAd'] as String)
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  void refreshMyHotels() {
    setState(() {
      // Verileri yeniden yükle
      getCachedUserData();
      fetchAllHotelUserHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tiklandi
          ? Container(
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
                    "My Visited Hotel ",
                    //${userIdSon}
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: allUserHistoryHotels.length,
                    itemBuilder: (context, index) {
                      final hotel = allUserHistoryHotels[index];
                      return HotelItem(
                        userId: userIdSon,
                        refreshMyHotels: refreshMyHotels,
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
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2),
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
                          return Container(
                            color: Colors.red,
                          );
                        } else {
                          final hotel =
                              tiklandi ? searchHotels[index] : allHotels[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              focusColor: Colors.amber,
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(hotel["imageurl"]),
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
                                  setState(() {
                                    createHotelUserHistory(
                                        searchHotels[index]['id'],
                                        int.parse(userIdSon));
                                    refreshMyHotels();
                                  });
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
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSearchBar(BuildContext context) {
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
      child: const TextField(
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: "Add Hotel",
          hintStyle: TextStyle(
              color: Colors.black87,
              fontSize: 14.0,
              fontWeight: FontWeight.w500),
          prefixIcon: Icon(Icons.search, color: iconColor),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
        ),
      ),
    ),
  );
}
