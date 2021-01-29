import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import '../widgets/api_widgets.dart';
import '../widgets/material_button.dart';
import '../api.dart';

class Home extends StatefulHookWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _showErr = false;

  @override
  Widget build(BuildContext context) {
    final inputController = useTextEditingController();
    // set initial response
    if (context.read(apiProvider).response == null) {
      context.read(apiProvider).classifyText(text: "Ali is cooking");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("NER FastAPI Demo"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Center(
          widthFactor: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              buildConsumer(),
              Spacer(),
              TextField(
                controller: inputController,
                decoration: InputDecoration(hintText: "Enter text to classify"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              buildMaterialButton(
                text: "Classify Text",
                onPresses: () async {
                  if (inputController.text != '') {
                    setState(() {
                      _showErr = false;
                    });
                    context
                        .read(apiProvider)
                        .classifyText(text: inputController.text);
                  } else {
                    setState(() {
                      _showErr = true;
                    });
                  }
                },
              ),
              SizedBox(height: 10),
              Visibility(
                child: Text(
                  "No Text Provided!",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.red),
                ),
                visible: _showErr,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
