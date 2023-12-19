import 'package:flutter/material.dart';
import 'package:management/constant/number_ext.dart';
import 'package:management/widgets/button.dart';
import 'package:management/widgets/input_field.dart';

void showNDialog(BuildContext context, Function(Map data) onButtonPress) async {
  await showDialog(
    context: context,
    builder: (context) {
      var data = {};

      return Dialog(
        backgroundColor: Colors.white,
        child: SizedBox(
          height: 650,
          width: MediaQuery.sizeOf(context).width / 3,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Add a New User",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                32.height,
                NInputField(
                  title: "First Name",
                  onChange: (str) {
                    data = {
                      ...data,
                      "fname": str,
                    };
                  },
                ),
                12.height,
                NInputField(
                  title: "Last Name",
                  onChange: (str) {
                    data = {
                      ...data,
                      "lname": str,
                    };
                  },
                ),
                12.height,
                NInputField(
                  title: "Phone Number",
                  onChange: (str) {
                    data = {
                      ...data,
                      "number": str,
                    };
                  },
                ),
                12.height,
                NInputField(
                  title: "Computer Name",
                  onChange: (str) {
                    data = {
                      ...data,
                      "pcName": str,
                    };
                  },
                ),
                12.height,
                NInputField(
                  title: "Computer Serial Number",
                  onChange: (str) {
                    data = {
                      ...data,
                      "pcSN": str,
                    };
                  },
                ),
                22.height,
                NButton(
                  onTap: () {
                    onButtonPress(data);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
