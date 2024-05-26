
import 'package:flutter/material.dart';
import 'package:metaozce/pages/FilterPage/component/FeatureItemForFilter.dart';



import 'package:metaozce/service/hotel_service.dart';



class FilteredPageView extends StatefulWidget {
  const FilteredPageView({Key? key}) : super(key: key);

  @override
  State<FilteredPageView> createState() => _FilteredPageViewState();
}

class _FilteredPageViewState extends State<FilteredPageView> {
    int _selectedNumber=1;
    String? _selectedFeature ;
    bool _selectedOption=true; 


  @override
  void initState() {
    super.initState();

   
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
  'Dock': 'İskele',
  'A La Carte Restaurant': 'a_la_carte_restoran',
  'Elevator': 'asansor',
  'Open Restaurant': 'acik_restoran',
  'Closed Restaurant': 'kapali_restoran',
  'Open Pool': 'acik_havuz',
  'Closed Pool': 'kapali_havuz',
  'Disabled Room': 'bedensel_engelli_odasi',
  'Bar': 'bar',
  'Water Slide': 'su_kaydiragi',
  'Ballroom': 'balo_salonu',
  'Hairdresser': 'kuafor',
  'Parking': 'otopark',
  'Market': 'market',
  'Sauna': 'sauna',
  'Doctor': 'doktor',
  'Beach Volleyball': 'beach_voley',
  'Fitness': 'fitness',
  'Live Entertainment': 'canli_eglence',
  'Wireless Internet': 'wireless_internet',
  'Animation': 'animasyon',
  'Surfing': 'sorf',
  'Parasailing': 'parasut',
  'Car Rental': 'arac_kiralama',
  'Canoeing': 'kano',
  'Spa': 'spa',
  'Massage': 'masaj',
  'Table Tennis': 'masa_tenisi',
  'Childrens Pool': 'cocuk_havuzu',
  'Childrens Playground': 'cocuk_parki',
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
          child: Text("Select"),
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
        List.generate(5, (index) {
          return DropdownMenuItem<int>(
            value: index + 1,
            child: (index)<4?Text((index + 1).toString()):Text((index + 1).toString()+"+"),
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
    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
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
            child: FeatureItemForFilter(
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
      },
    );
  }


 
}
