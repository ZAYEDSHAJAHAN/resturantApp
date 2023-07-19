import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/restrurant_model_clss.dart';

class Resturantdetails extends StatefulWidget {
  int id;
  String name;
  String neighborhood;
  String photograph;
  String address;
  Latlng latlng;
  String cuisineType;
  final List<String> operatingHours;
  List<Review> reviews;
  Resturantdetails({
    required this.id,
    required this.name,
    required this.neighborhood,
    required this.photograph,
    required this.address,
    required this.latlng,
    required this.cuisineType,
    required this.operatingHours,
    required this.reviews,
  });

  @override
  State<Resturantdetails> createState() => _ResturantdetailsState();
}

String? selectedValue;

class _ResturantdetailsState extends State<Resturantdetails> {
  void _openMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${widget.latlng.lat},${widget.latlng.lng}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Unable to open Google Maps'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          setState(() {
            selectedValue = null;
          });

          return true;
        },
        child: Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            padding: EdgeInsets.all(2.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                  child: Image.network(widget.photograph),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      height: 4.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color.fromARGB(255, 8, 140, 30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "3.7",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
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
                SizedBox(
                  height: 1.h,
                ),
                Text(widget.neighborhood,
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400)),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    Icon(Icons.dining_rounded),
                    Text(
                      widget.cuisineType,
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    Expanded(
                      child: Text(
                        widget.address,
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    Icon(Icons.access_time_filled_rounded),
                    SizedBox(
                      width: 80.w,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text("select one time"),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        value: selectedValue,
                        items: widget.operatingHours
                            .map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            })
                            .toSet()
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Rating & Reviews",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
                ),
                reviview(widget.reviews),
              ],
            ),
          )),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 236, 180, 68),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Icon(Icons.directions), Text("GO")],
              ),
              onPressed: () {
                _openMaps();
              }),
        ));
  }

  Widget reviview(List<Review> reviews) {
    return ListView.separated(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 3.h,
                        width: 18.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color.fromARGB(255, 8, 140, 30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              reviews[index].rating.toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp),
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
                      ),
                      SizedBox(
                        width: 2.h,
                      ),
                      Text(
                        reviews[index].name,
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  ReadMoreText(
                    reviews[index].comments,
                    trimLines: 3,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: '   Show less',
                    moreStyle:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                    lessStyle:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(reviews[index].date),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 1.5.h),
        itemCount: reviews.length);
  }
}
