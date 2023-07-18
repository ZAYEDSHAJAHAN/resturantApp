import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restsapp/view/loginpage.dart';
import 'package:restsapp/view/resturantdetailedpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';

import '../model/restrurant_model_clss.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  List<Restaurant> restaurantlist = [];
  // bool _isLoading = false;
  Future<List<Restaurant>> fetchrestaurantlist() async {
    String apiUrl =
        "https://run.mocky.io/v3/b91498e7-c7fd-48bc-b16a-5cb970a3af8a";
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = [];

      data = json.decode(response.body)['restaurants'];
      if (data.isNotEmpty) {
        for (int i = 0; i < data.length; i++) {
          if (data[i] != null) {
            Map<String, dynamic> map = data[i];
            restaurantlist.add(Restaurant.fromJson(map));
          }
        }
      }

      return restaurantlist;
    } else {
      throw Exception("Failed to load resturants");
    }
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RESTURANTS'),
          backgroundColor: Color.fromARGB(255, 239, 81, 28),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  _logout(context);
                },
                icon: Icon(Icons.logout_rounded)),
            Padding(
              padding: EdgeInsets.only(right: 2.h),
              child: Text(
                "logout",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: SizedBox(
            height: 100.h,
            child: FutureBuilder<List<Restaurant>>(
                future: fetchrestaurantlist(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (restaurantlist.isNotEmpty) {
                    return ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              final List<String> timelist = [
                                'Monday:${restaurantlist[index].operatingHours.monday}',
                                'Tuesday:${restaurantlist[index].operatingHours.tuesday}',
                                'Wednesday:${restaurantlist[index].operatingHours.wednesday}',
                                'Thrusday:${restaurantlist[index].operatingHours.thursday}',
                                'Friday:${restaurantlist[index].operatingHours.friday}',
                                'Saturday:${restaurantlist[index].operatingHours.saturday}',
                                'Sunday:${restaurantlist[index].operatingHours.sunday}'
                              ];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Resturantdetails(
                                          id: restaurantlist[index].id,
                                          name: restaurantlist[index].name,
                                          neighborhood: restaurantlist[index]
                                              .neighborhood,
                                          photograph:
                                              restaurantlist[index].photograph,
                                          address:
                                              restaurantlist[index].address,
                                          latlng: restaurantlist[index].latlng,
                                          cuisineType:
                                              restaurantlist[index].cuisineType,
                                          operatingHours: timelist,
                                          reviews:
                                              restaurantlist[index].reviews,
                                        )),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(1.5.h),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 30.h,
                                      child: Image.network(
                                        restaurantlist[index].photograph,
                                        fit: BoxFit.fill,
                                      )),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          restaurantlist[index].name,
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        height: 4.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Color.fromARGB(
                                                255, 8, 140, 30)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "3.7",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.sp),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.dining_rounded),
                                      Text(
                                        restaurantlist[index].cuisineType,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined),
                                      Text(
                                        restaurantlist[index].address,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 5.h,
                            ),
                        itemCount: restaurantlist.length);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })));
  }
}
