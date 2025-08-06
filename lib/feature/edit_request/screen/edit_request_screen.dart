import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart'
    as google_places;
import 'package:google_places_flutter/model/prediction.dart' as google_places;
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/global_widegts/custom_textfield.dart';
import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/edit_request/controller/edit_request_controller.dart';
import 'package:guven_a/feature/edit_request/controller/place_serarch_controller2.dart';

class EditRequestScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final id;
  EditRequestScreen({super.key, required this.id});

  final EditRequestController controller = Get.put(EditRequestController());
  final PlaceSearchController2 locationcontroller = Get.put(
    PlaceSearchController2(),
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
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Edit request",
                      //id,
                      style: globalTextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
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
                            "AIzaSyBsPxSFf2or6oZnbq7urgrxlakTiVqTmjQ", // Replace with your actual API key
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
                          controller.submitRequest(id);
                        },
                        text: "update request",
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
