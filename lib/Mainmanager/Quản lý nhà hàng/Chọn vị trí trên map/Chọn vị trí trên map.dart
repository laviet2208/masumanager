import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20kh%C3%A1ch%20h%C3%A0ng/accountLocation.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:masumanager/utils/utils.dart';
import 'ITEMplaceAutoComplete.dart';
import 'PlaceAutocompleteResponse.dart';
import 'autocomplate_prediction.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';


class PickLocationInMap extends StatefulWidget {
  final accountLocation location;
  final double width;
  const PickLocationInMap({Key? key, required this.location, required this.width}) : super(key: key);

  @override
  State<PickLocationInMap> createState() => _PickLocationInMapState();
}

class _PickLocationInMapState extends State<PickLocationInMap> {
  final locationcontrol = TextEditingController();
  String buttonText = '20.9826103,105.7087642';
  accountLocation thislocation = accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA");
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.9826103,105.7087642),
    zoom: 13,
  );
  var uuid = Uuid();
  final textcontroller = TextEditingController();
  Future<double?> getLongti(String placeId) async {
    final baseUrl = "rsapi.goong.io";
    final path = "/Geocode";
    final queryParams = {
      "place_id": placeId,
      "api_key": 'npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z',
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
      "api_key": 'npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z',
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
    final url = Uri.parse('https://rsapi.goong.io/Place/AutoComplete?api_key=npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z&input=$query');

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
                      widget.location.Longitude = newPosition.target.longitude;
                      widget.location.Latitude = newPosition.target.latitude;
                      buttonText = widget.location.Latitude.toString() + " , " + widget.location.Longitude.toString();
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
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                            ),
                          ),

                          noItemsFoundBuilder: (context) => SizedBox.shrink(),


                          suggestionsCallback: (pattern) async {
                            return await placeAutocomplete(pattern);
                          },

                          itemBuilder: (context, suggestion) {
                            return ITEMplaceAutoComplete(location: suggestion, width: 500,
                              onTap: () async {

                              },
                            );
                          },

                          onSuggestionSelected: (AutocompletePrediction suggestion) async {

                            textcontroller.text = suggestion.description.toString();
                            double? la = await getLati(suggestion.placeId.toString());
                            double? long = await getLongti(suggestion.placeId.toString());
                            LatLng _target = LatLng(
                                la!,long!
                            );

                            CameraPosition newcam = CameraPosition(
                              target: _target,
                              zoom: 18,
                            );

                            final GoogleMapController controller = await _controller.future;
                            await controller.animateCamera(CameraUpdate.newCameraPosition(newcam));
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
                            color: Colors.redAccent
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Chọn vị trí',
                          style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                      onTap: () {
                        if (widget.location.Latitude != 0 && widget.location.Longitude != 0) {
                          locationcontrol.text = widget.location.Latitude.toString() + ',' + widget.location.Longitude.toString();
                          setState(() {

                          });
                          Navigator.of(context).pop();
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
    if (widget.location.Longitude == 0 && widget.location.Latitude == 0) {
      locationcontrol.text = '';
    } else {
      locationcontrol.text = widget.location.Latitude.toString() + ',' + widget.location.Longitude.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: widget.width,
        height: 50,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            border: Border.all(
              width: 1,
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
