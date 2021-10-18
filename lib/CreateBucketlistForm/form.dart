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
  final formController = TextEditingController(),
      toController = TextEditingController(),
      priceController = TextEditingController();

  createListItem() {
    print("created yo");
    // LocalData.read();
    print(formController.text);
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
          ListTile(
              leading: Icon(Icons.arrow_upward_rounded),
              title: TypeAheadField<String>(
                textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: 'Search Location')),
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
              )
              // TextField(
              //   controller: formController,
              //   decoration: InputDecoration(
              //     hintText: "From",
              //   ),
              // ),
              ),
          ListTile(
            leading: Icon(Icons.arrow_downward_rounded),
            title: TextField(
              controller: toController,
              decoration: InputDecoration(
                hintText: "To",
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: TextField(
              controller: priceController,
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
