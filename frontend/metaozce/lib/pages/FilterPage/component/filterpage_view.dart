
import 'package:flutter/material.dart';

import 'package:metaozce/pages/HomePage/components/widgets/feauture_item.dart';

import 'package:metaozce/service/hotel_service.dart';



class FilteredPageView extends StatefulWidget {
  const FilteredPageView({Key? key}) : super(key: key);

  @override
  State<FilteredPageView> createState() => _FilteredPageViewState();
}

class _FilteredPageViewState extends State<FilteredPageView> {
 int? _selectedNumber;
    String? _selectedFeature;
    bool? _selectedOption; 


  @override
  void initState() {
    super.initState();
    
    int? _selectedNumber=1;
    String? _selectedFeature;
    bool _selectedOption = true; // true: Yes, false: No
   
  }

 @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  
                  buildSelectFeature(),
                  
                  buildSelectNumber(),

                 
                ],
              ),
            ),
            _buildFeauture(),
          ],
        ),
      
    );
  }
  


Widget buildSelectFeature() {
  final Map<String, String> featureOptions = {
  'İskele': 'iskele',
  'A La Carte Restoran': 'a_la_carte_restoran',
  'Asansör': 'asansor',
  'Açık Restoran': 'acik_restoran',
  'Kapalı Restoran': 'kapali_restoran',
  'Açık Havuz': 'acik_havuz',
  'Kapalı Havuz': 'kapali_havuz',
  'Bedensel Engelli Odası': 'bedensel_engelli_odasi',
  'Bar': 'bar',
  'Su Kaydırağı': 'su_kaydiragi',
  'Balo Salonu': 'balo_salonu',
  'Kuaför': 'kuafor',
  'Otopark': 'otopark',
  'Market': 'market',
  'Sauna': 'sauna',
  'Doktor': 'doktor',
  'Beach Voley': 'beach_voley',
  'Fitness': 'fitness',
  'Canlı Eğlence': 'canli_eglence',
  'Wireless İnternet': 'wireless_internet',
  'Animasyon': 'animasyon',
  'Sörf': 'sorf',
  'Paraşüt': 'parasut',
  'Araç Kiralama': 'arac_kiralama',
  'Kano': 'kano',
  'Spa': 'spa',
  'Masaj': 'masaj',
  'Masa Tenisi': 'masa_tenisi',
  'Çocuk Havuzu': 'cocuk_havuzu',
  'Çocuk Parkı': 'cocuk_parki',
};


  return DropdownButton<String>(
    value: _selectedFeature,
    items: featureOptions.keys.map((String key) {
      return DropdownMenuItem<String>(
        value: featureOptions[key],
        child: Text(key),
      );
    }).toList(),
    onChanged: (String? newValue) {
      setState(() {
        _selectedFeature = newValue;
        _selectedNumber = 1; // Özelliği değiştirince sayıyı null yap
        _selectedOption = true; // Yes/No seçeneğini sıfırla

        
      });
    },
  );
}




Widget buildSelectNumber() {
  List<DropdownMenuItem<int>> items = [];
  if(_selectedFeature != null){  
    if (!['a_la_carte_restoran', 'acik_restoran', 'kapali_restoran', 'acik_havuz', 'bar'].contains(_selectedFeature)) {
      items.addAll([
        DropdownMenuItem<int>(
          value: 1,
          child: Text("Yes"),
        ),
        DropdownMenuItem<int>(
          value: 0,
          child: Text("No"),
        ),
        DropdownMenuItem<int>(
          value: 2,
          child: Text(""),
        ),
      ]);
    } else {
      items.add(
        DropdownMenuItem<int>(
          value: 0,
          child: Text("No"),
        ),
      );
      
      items.addAll(
        List.generate(20, (index) {
          return DropdownMenuItem<int>(
            value: index + 1,
            child: Text((index + 1).toString()),
          );
        }),
      );
    }}
    else null;
  
  return DropdownButton<int>(
    value: _selectedNumber ?? (_selectedFeature != null ? 1 : 0),
    items: items,
    onChanged: (int? newValue) {
      setState(() {
        _selectedNumber = newValue!;
      });
    },
  );
}
 _buildFeauture() {
    final HotelService _hotelService = HotelService();

    return FutureBuilder(
     future: _selectedFeature == null
      ? _hotelService.getHotelAll()
      : _selectedFeature != null 
          ? _hotelService.getHotelAll(feature: _selectedFeature,number: _selectedNumber)
           : null, // Bu durumda null döndürmek uygun olabilir, 
               builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Veri başarıyla alındı
          List<dynamic> allHotels = [];
          allHotels = _hotelService.hotels;

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
            scrollDirection: Axis.vertical,
            child: Column(
              children: List.generate(
                allHotels.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: FeautureItem(
                    data: allHotels[index],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }


 
}
