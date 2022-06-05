

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class ArchitectCreate extends StatefulWidget {
  const ArchitectCreate({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ArchitectCreate> {
  int _activeStepIndex = 0;
 // FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true)
 /* FilePickerResult result;
  String filename;
  PlatformFile pickedfile;
  bool isloading =false;
  File fileToDisplay;

  void pickFile() async{
    try{
      setState(() {
        isloading=true;
      });
      result= await  FilePicker.platform.pickFiles(
        type:FileType.any,
        allowMultiple: false,
      );
      if(result!=null){
        filename=result.files.first.name;
        pickedfile=result.files.first;
        fileToDisplay=File(pickedfile.path.toString());
      }
      setState(() {
        isloading=false;
      });
    }catch(e){
      print(e);
    }
  }
*/
  TextEditingController name = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController team = TextEditingController();
  TextEditingController contactnumber = TextEditingController();

  List<Step> stepList() => [
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Account'),
      content: Container(
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: designation,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Designation',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: about,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'About',
              ),
            ),
            TextField(
              controller: contactnumber,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Contact Number',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: team,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'No of Team Members',
              ),
            ),
          ],
        ),
      ),
    ),
    Step(
        state:
        _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 1,
        title: const Text('Contact Number'),
        content: Container(
          child: Column(
            children: [/*
              const SizedBox(
                height: 8,
              ),
              Center(
                child:isloading?CircularProgressIndicator():TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.lightGreen,
                    ),
                    onPressed:(){
                  pickFile();
                }, child: Text('Pick File')),
              ),
              if(pickedfile!=null)
                SizedBox(height: 300,width: 400,child:Image.file(fileToDisplay)),
              const SizedBox(
                height: 8,
              ),
*/
            ],
          ),
        )),
    Step(
        state: StepState.complete,
        isActive: _activeStepIndex >= 2,
        title: const Text('Confirm'),
        content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name: ${name.text}'),
                Text('About: ${about.text}'),
                Text('Designation: ${designation.text}'),
                const Text('Password: *****'),
                Text('Contact No : ${contactnumber.text}'),
                Text('Team : ${team.text}'),
              ],
            )))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Create Architecture',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            setState(() {
              _activeStepIndex += 1;
            });
          } else {
            print('Submited');
          }
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }

          setState(() {
            _activeStepIndex -= 1;
          });
        },
        onStepTapped: (int index) {
          setState(() {
            _activeStepIndex = index;
          });
        },
        controlsBuilder: (context, {onStepContinue, onStepCancel}) {
          final isLastStep = _activeStepIndex == stepList().length - 1;
          return Container(
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onStepContinue,
                    child: (isLastStep)
                        ? const Text('Submit')
                        : const Text('Next'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (_activeStepIndex > 0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onStepCancel,
                      child: const Text('Back'),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}