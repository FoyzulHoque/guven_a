import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart'
    as google_places;
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/global_widegts/custom_textfield.dart';
import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/request/controller/place_search_controller.dart';
import 'package:guven_a/feature/request/controller/request_controller.dart';

import 'package:google_places_flutter/model/prediction.dart' as google_places;

class RequestScreen extends StatelessWidget {
  RequestScreen({super.key});

  final RequestController controller = Get.put(RequestController());
  final PlaceSearchController locationcontroller = Get.put(
    PlaceSearchController(),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/logo2.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Create request",
                      style: globalTextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Image.asset(
                      "assets/images/notification.png",
                      width: 55,
                      height: 55,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    children: [
                      // Search Input
                      google_places.GooglePlaceAutoCompleteTextField(
                        textEditingController: locationcontroller.controller,
                        googleAPIKey:
                            "AIzaSyATkpZxtsIVek6xHnGRsse_i4yVEofqQbI", // Replace with your actual API key
                        inputDecoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Search for places...',
                          suffixIcon: Icon(Icons.search),
                        ),
                        debounceTime: 800,
                        countries: [], // Restrict to Bangladesh
                        isLatLngRequired: true,
                        getPlaceDetailWithLatLng:
                            (google_places.Prediction prediction) async {
                              await locationcontroller.fetchPlaceDetails(
                                prediction.placeId!,
                              );
                            },
                        itemClick: (google_places.Prediction prediction) {
                          locationcontroller.controller.text =
                              prediction.description!;
                          locationcontroller.controller.selection =
                              TextSelection.fromPosition(
                                TextPosition(
                                  offset: prediction.description!.length,
                                ),
                              );
                          locationcontroller.updatePlaceDetails(
                            prediction.placeId!,
                          );
                        },

                        itemBuilder:
                            (
                              context,
                              index,
                              google_places.Prediction prediction,
                            ) {
                              return ListTile(
                                leading: Icon(Icons.location_on),
                                title: Text("${prediction.description ?? ""}"),
                              );
                            },
                        seperatedBuilder: Divider(),
                        isCrossBtnShown: true,
                      ),
                      SizedBox(height: 10),

                      // Detailed Information about the selected place
                      Obx(() {
                        if (locationcontroller.selectedPlace.value != null) {
                          final place = locationcontroller.selectedPlace.value!;
                          controller.lat.value =
                              double.tryParse(place['lat'].toString()) ??
                              0.0; // Parse as double
                          controller.long.value =
                              double.tryParse(place['lng'].toString()) ??
                              0.0; // Parse as double
                          controller.address.value = place['description'] ?? '';
                          return SizedBox(); // Add a return statement
                        } else {
                          return SizedBox();
                        }
                      }),
                    ],
                  ),
                ),
                // SizedBox(height: 20),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(15),
                //   child: Image.asset(
                //     "assets/images/map.png",
                //     width: MediaQuery.of(context).size.width,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                // SizedBox(height: 20),
                CustomTextField(
                  title: "Address",
                  controller: controller.addressController,
                ),
                CustomTextField(
                  title: "Details",
                  controller: controller.detaildsController,
                  maxLine: 4,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Validity date",
                            style: globalTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 3),
                          Text(
                            "*",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: controller.datePickerController,
                        readOnly: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFfD536AC),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onTap: () => controller.pickValidityDate(
                          context,
                        ), // <--- Call the controller's method
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Urgency",
                        style: globalTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Radio Button 1
                            Row(
                              children: [
                                Radio<int>(
                                  value: 1,
                                  groupValue: controller.selectedOption.value,
                                  activeColor: Color(0xFfD536AC),
                                  onChanged: (value) {
                                    controller.selectedOption.value = value!;
                                  },
                                ),
                                Text("Yes"),
                              ],
                            ),

                            Row(
                              children: [
                                Radio<int>(
                                  value: 2,
                                  activeColor: Color(0xFfD536AC),
                                  groupValue: controller.selectedOption.value,
                                  onChanged: (value) {
                                    controller.selectedOption.value = value!;
                                  },
                                ),
                                Text("No"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      AppButton(
                        onTap: () {
                          controller.submitRequest(context);
                        },
                        text: "Create request",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
