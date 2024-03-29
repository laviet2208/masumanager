import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:masumanager/MasuShipManager/Data/models/item_autocomplete.dart';
import 'package:uuid/uuid.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../../Data/locationData/Location.dart';
import '../../../../Data/models/autocomplate_prediction.dart';
import '../../../../Data/models/place_auto_complate_response.dart';
import '../../../../Data/otherData/utils.dart';

class location_pick_in_map extends StatefulWidget {
  final Location location;
  const location_pick_in_map({Key? key, required this.location}) : super(key: key);

  @override
  State<location_pick_in_map> createState() => _location_pick_in_mapState();
}

class _location_pick_in_mapState extends State<location_pick_in_map> {
  final locationcontrol = TextEditingController();
  String buttonText = '20.9826103,105.7087642';

  Location thislocation = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.9826103,105.7087642),
    zoom: 13,
  );
  var uuid = Uuid();
  final textcontroller = TextEditingController();
  bool loading = false;
  String placeName = '';

  Future<double?> getLongti(String placeId) async {
    final baseUrl = "rsapi.goong.io";
    final path = "/Geocode";
    final queryParams = {
      "place_id": placeId,
      "api_key": '3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf',
    };

    final uri = Uri.https(baseUrl, path, queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["status"] == "OK" && data["results"].length > 0) {
        final location = data["results"][0]["geometry"]["location"];
        return location["lng"];
      } else {
        print("Không tìm thấy địa điểm hoặc có lỗi khi truy vấn.");
        return null;
      }
    } else {
      print("Lỗi kết nối: ${response.statusCode}");
      return null;
    }
  }

  Future<double?> getLati(String placeId) async {
    final baseUrl = "rsapi.goong.io";
    final path = "/Geocode";
    final queryParams = {
      "place_id": placeId,
      "api_key": '3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf',
    };

    final uri = Uri.https(baseUrl, path, queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["status"] == "OK" && data["results"].length > 0) {
        final location = data["results"][0]["geometry"]["location"];
        return location["lat"];
      } else {
        print("Không tìm thấy địa điểm hoặc có lỗi khi truy vấn.");
        return null;
      }
    } else {
      print("Lỗi kết nối: ${response.statusCode}");
      return null;
    }
  }

  Future<List<AutocompletePrediction>> placeAutocomplete(String query) async{
    List<AutocompletePrediction> placePredictions = [];
    final url = Uri.parse('https://rsapi.goong.io/Place/AutoComplete?api_key=3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf&input=$query');

    var response = await http.get(url);

    if (response != null) {
      PlaceAutocompleteResponse result = PlaceAutocompleteResponse.parseAutocompleteResult(response.body);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }

    return placePredictions;
  }

  Future<String?> fetchUrl(Uri uri, {Map<String, String>? header}) async {
    try {
      final response = await http.get(uri, headers: header);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  void showDialogPick() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Chọn vị trí'),
            content: Container(
              width: 500,
              height: 600,
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMove: (CameraPosition newPosition) async {
                      widget.location.longitude = newPosition.target.longitude;
                      widget.location.latitude = newPosition.target.latitude;
                      buttonText = widget.location.latitude.toString() + " , " + widget.location.longitude.toString();
                      setState(() {

                      });
                    },
                  ),

                  Center(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 36,
                    ),
                  ),

                  Positioned(
                    top: 40,
                    left: 25,
                    child: Container(
                        height: 60,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: textcontroller,
                            onTap: () {
                              textcontroller.clear();
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Tìm kiếm',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),

                          noItemsFoundBuilder: (context) => SizedBox.shrink(),


                          suggestionsCallback: (pattern) async {
                            return await placeAutocomplete(pattern);
                          },

                          itemBuilder: (context, suggestion) {
                            return item_autocomplete(location: suggestion, width: 500,
                              onTap: () async {
                                setState(() {
                                  loading = true;
                                  textcontroller.text = suggestion.description.toString();
                                });

                                widget.location.mainText = suggestion.structuredFormatting!.mainText.toString();
                                widget.location.secondaryText = suggestion.structuredFormatting!.secondaryText.toString();
                                widget.location.placeId = suggestion.placeId.toString();
                                double? la = await getLati(suggestion.placeId.toString());
                                double? long = await getLongti(suggestion.placeId.toString());
                                print(la.toString() + ' ' + long.toString());
                                LatLng _target = LatLng(
                                    la!,long!
                                );

                                CameraPosition newcam = CameraPosition(
                                  target: _target,
                                  zoom: 14,
                                );

                                final GoogleMapController controller = await _controller.future;
                                await controller.animateCamera(CameraUpdate.newCameraPosition(newcam));
                                setState(() {
                                  loading = false;
                                });
                                TextEditingController().clear();
                              }, loading: loading,
                            );
                          },

                          onSuggestionSelected: (AutocompletePrediction suggestion) async {

                          },
                        )
                    ),
                  ),

                  Positioned(
                    bottom: 10,
                    left: 25,
                    child: GestureDetector(
                      child: Container(
                        width: 450,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            color: Colors.yellow.shade700
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Chọn vị trí',
                          style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                      onTap: () {
                        if (widget.location.latitude != 0 && widget.location.longitude != 0) {
                          if (widget.location.mainText != '') {
                            locationcontrol.text = widget.location.mainText + ' ' + widget.location.secondaryText;
                            setState(() {

                            });
                            Navigator.of(context).pop();
                          } else {
                            locationcontrol.text = widget.location.latitude.toString() + ',' + widget.location.longitude.toString();
                            setState(() {

                            });
                            Navigator.of(context).pop();
                          }

                        } else {
                          toastMessage('Bạn chưa chọn vị trí');
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Hủy'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.location.longitude == 0 && widget.location.latitude == 0) {
      locationcontrol.text = '';
    } else {
      locationcontrol.text = widget.location.latitude.toString() + ',' + widget.location.longitude.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            border: Border.all(
              width: 0.5,
              color: Colors.black,
            )
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Form(
            child: TextFormField(
              controller: locationcontrol,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'arial',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Click chọn vị trí',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontFamily: 'arial',
                ),
              ),
              onTap: () {
                showDialogPick();
              },
            ),
          ),
        ),
      ),
    );
  }
}
