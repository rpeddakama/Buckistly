import 'package:bucketlist/constants/localData.dart';
import 'package:bucketlist/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:bucketlist/constants/colors.dart' as ColorConstants;
import 'package:flutter_typeahead/flutter_typeahead.dart';

class BucketlistItemForm extends StatefulWidget {
  @override
  _BucketlistItemFormState createState() => _BucketlistItemFormState();
}

class _BucketlistItemFormState extends State<BucketlistItemForm> {
  final fromController = TextEditingController(),
      toController = TextEditingController(),
      priceController = TextEditingController();

  createListItem() {
    print("created yo");
    print(fromController.text);
    print(toController.text);
    print(priceController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundColor,
        title: Text("Create"),
        actions: <Widget>[IconButton(icon: Icon(Icons.save), onPressed: () {})],
      ),
      body: Column(
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Title(
          //       color: Colors.black,
          //       child: Text(
          //         "SOME TITLE",
          //         style: TextStyle(fontSize: 20),
          //       )),
          // ),
          ListTile(
              leading: Icon(Icons.arrow_upward_rounded),
              title: TypeAheadField<String>(
                debounceDuration: Duration(milliseconds: 500),
                textFieldConfiguration: TextFieldConfiguration(
                    controller: fromController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: 'From Location')),
                suggestionsCallback: (pattern) async {
                  return await LocalData.read(pattern);
                },
                itemBuilder: (context, String suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (String suggestion) {
                  fromController.text = suggestion;
                },
              )),
          ListTile(
              leading: Icon(Icons.arrow_downward_rounded),
              title: TypeAheadField<String>(
                debounceDuration: Duration(milliseconds: 500),
                textFieldConfiguration: TextFieldConfiguration(
                    controller: toController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: 'To Location')),
                suggestionsCallback: (pattern) async {
                  return await LocalData.read(pattern);
                },
                itemBuilder: (context, String suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (String suggestion) {
                  toController.text = suggestion;
                },
              )),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Ideal Price",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(45.0),
            child: InkWell(
              onTap: () {
                createListItem();
              },
              child: ovalButton(
                  context: context,
                  label: "Create",
                  col: ColorConstants.backgroundColor),
            ),
          ),
        ],
      ),
    );
  }
}
