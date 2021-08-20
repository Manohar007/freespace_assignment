import 'package:flutter/material.dart';

class AddPostUserScreen extends StatelessWidget {
  final Function(Map) onButtonClicked;
  AddPostUserScreen({Key? key, required this.onButtonClicked})
      : super(key: key);
  final TextEditingController postTitleController = TextEditingController();
  final TextEditingController postBodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _getTextField(postTitleController, 10, "Post Title"),
        _getTextField(postBodyController, 5, "Post Body"),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Map map=Map();
                map["title"]=postTitleController.text;
                map["body"]=postBodyController.text;
                onButtonClicked(map);
              },
              child: Padding(
                child:
                    Text(" Add Post ", style: TextStyle(color: Colors.black)),
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade300)),
            )
          ],
        )
      ],
    );
  }

  Widget _getTextField(
      TextEditingController controller, int lineSize, String floatTitle) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 1.0)),
          labelText: floatTitle,
        ),
        minLines: lineSize,
        maxLines: lineSize,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}
