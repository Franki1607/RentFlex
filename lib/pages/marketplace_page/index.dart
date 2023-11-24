import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/marketplace_controller.dart';
import 'package:rent_flex/pages/marketplace_page/widgets/filter_btn.dart';
import 'package:rent_flex/pages/marketplace_page/widgets/details_card.dart';


class MarketplacePage extends GetWidget<MarketplaceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      appBar: AppBar(
        title: Text("Marketplace"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<MarketplaceController>(
        builder: (_) => GestureDetector(
          onTap: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    content: Container(
                      width: 250,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.info,
                            size: 50,
                            color: Colors.blue,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'coming_soon'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'coming_soon_hint'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                );
            },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 48,
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.search),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                'Entrer une adresse',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),

                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFA500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Modifier le BorderRadius selon votre besoin
                            ),
                          ),
                          child: Icon(Icons.filter_list),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18.0),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      FilterButton(text: 'Chambres', color: Color(0xFFFFA500)),
                      FilterButton(text: 'Appartement', color: Color(0xFF858585)),
                      FilterButton(text: 'Villa', color: Color(0xFF858585)),
                      FilterButton(text: 'Boutique', color: Color(0xFF858585)),
                    ],
                  ),
                ),

                SizedBox(height: 34.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Près de vous'),
                    Text(
                      'Voir plus',
                      style: TextStyle(fontSize: 12, color: Color(0xFF858585)),

                    ),
                  ],
                ),

                SizedBox(height: 8.0),

                Container(
                  height: 315,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return CardItem();
                    },
                  ),
                ),

                SizedBox(height: 16.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Meilleurs pour vous'),
                    Text(
                      'Voir plus',
                      style: TextStyle(fontSize: 12, color: Color(0xFF858585)),

                    ),
                  ],
                ),

                SizedBox(height: 8.0),
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(top: index != 0 ? 18.0 : 0),
                        child: CardItem2(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}
