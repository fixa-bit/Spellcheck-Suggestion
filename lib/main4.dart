import 'dart:convert';

import 'package:auto2/request.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


void main() => runApp(const EditableTextToolbarBuilderExampleApp());

const String emailAddress = 'me@example.com';
const String text = 'Select the ناکس تان تان ناکستان ناکسن : $emailAddress';

class EditableTextToolbarBuilderExampleApp extends StatefulWidget {
  const EditableTextToolbarBuilderExampleApp({super.key});

  @override
  State<EditableTextToolbarBuilderExampleApp> createState() =>
      _EditableTextToolbarBuilderExampleAppState();
}

class _EditableTextToolbarBuilderExampleAppState
    extends State<EditableTextToolbarBuilderExampleApp> {
  final TextEditingController _controller = TextEditingController(
    text: text,
  );

  String selectedWord='';

  void _showDialog(BuildContext context) {
    Navigator.of(context).push(
      DialogRoute<void>(
        context: context,
        builder: (BuildContext context) =>
            const AlertDialog(title: Text('You clicked send email!')),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // On web, disable the browser's context menu since this example uses a custom
    // Flutter-rendered context menu.
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }
  }

  Future<List<String>> readscript() async {
    var data = await getData('http://10.0.2.2:5000/');
    var decodedData = jsonDecode(data);
    print(decodedData['query']);
    String decodedstring = decodedData['query'];
    var xx = decodedstring.split(',');

    return xx;
  }

  readscript2() async {
    var data = await getData('http://10.0.2.2:5000/');
    var decodedData = jsonDecode(data);
    print(decodedData['query']);
    String decodedstring = decodedData['query'];
    var xx = decodedstring.split(',');

    tags = xx;
  }

  Future<List<String>> readscript4() async {
    print("here");
    final url = 'http://10.0.2.2:5000/name' ;
    print(selectedWord);
    print("ok");
    final response = await http.post(Uri.parse(url) , body: json.encode({'name' : selectedWord}));
    var data=response.body;
    var decodedData = jsonDecode(data);
    print(decodedData['query']);
    String decodedstring = decodedData['query'];
    var xx = decodedstring.split(',');

    tags = xx;
    return xx;
  }


  readscript3() async {
    print("here");
    final url = 'http://10.0.2.2:5000/name' ;
    print(selectedWord);
    print("ok");
    final response = await http.post(Uri.parse(url) , body: json.encode({'name' : selectedWord}));
    var data=response.body;
    var decodedData = jsonDecode(data);
    print(decodedData['query']);
    String decodedstring = decodedData['query'];
    var xx = decodedstring.split(',');

    tags = xx;

  }

  @override
  void dispose() {
    if (kIsWeb) {
      BrowserContextMenu.enableContextMenu();
    }
    super.dispose();
  }

  List<String> tags = [""];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom button for emails'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.blue,
                ),
                onPressed: () async {
                  print(tags[0]);
                  readscript3();
                },
                child: Text("check fn"),
              ),
              TextField(
                controller: _controller,
                maxLines: 4,
                minLines: 2,
                onTap: () async {
                  //tags = await readscript3();
                  tags=await readscript4();
                },
                contextMenuBuilder: (context, editableTextState) {
                  print(_controller.selection.textInside(_controller.text));
                  selectedWord=_controller.selection.textInside(_controller.text);
                  //tags=[''];
                  
                  readscript3();
                  return  FutureBuilder<List<String>>(
                    future: readscript4(),
                    builder: (context, AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.hasData) {
                        return _MyContextMenu(
                    anchor: editableTextState.contextMenuAnchors.primaryAnchor,
                    children: [
                      TextSelectionToolbarTextButton(
                          padding: EdgeInsets.all(8),
                          onPressed: () async {
                            print('Flutterrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
                            //tags = await readscript();
                          },
                          child: Container(
                              color: Color.fromARGB(50, 44, 170, 61),
                              height: 150,
                              width: 100,
                              child:
                          // tags[0]==""?
                          
                          // Column(children: [

              

                              Scrollbar(

                                  thickness: 10,
                                  child: SingleChildScrollView(
                                      child: Column(
                                    children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            primary: Colors.blue,
                                          ),
                                          onPressed: () async {
                                            print(tags[0]);
                                            tags=await readscript4();
                                          },
                                          child: Text("Show Suggestions"),
                                        ),




                                      for (var i = 0; i < tags.length; i++)
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Color.fromARGB(
                                                255, 126, 85, 85),
                                            backgroundColor: Color.fromARGB(
                                                255, 44, 170, 61),
                                          ),
                                          onPressed: () async {
                                            print("word selected");
                                            print(tags[i]);

                                            await Clipboard.setData(
                                                ClipboardData(text: tags[i]));

                                            editableTextState.pasteText(
                                                SelectionChangedCause.toolbar);
                                          },
                                          child: Text(
                                            tags[i],
                                            style: const TextStyle(
                                                fontSize: 10.0,
                                                color: Color.fromARGB(
                                                    255, 69, 57, 77)),
                                          ),
                                        ),

                                      //   TextButton(
                                      //   style: TextButton.styleFrom(
                                      //     primary: Colors.blue,
                                      //   ),
                                      //   onPressed: () async{   print(tags[0]);

                                      //   await Clipboard.setData(ClipboardData(text: tags[0]));

                                      //   editableTextState.pasteText(SelectionChangedCause.toolbar);

                                      //   },
                                      //   child: Text(tags[0]),
                                      // ),

                                      Text(
                                        "More Optins",
                                        maxLines: 8,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  )))))
                    ],
                  );
                      } else {
                        return _MyContextMenu(
                    anchor: editableTextState.contextMenuAnchors.primaryAnchor,
                    children: [
                      Container(
                        height: 10,
                        width: 30,

                      ),
                      Row(children: [
                          
                          Text(
                                        "Loading",
                                        maxLines: 8,
                                        overflow: TextOverflow.visible,
                                      ),

                           Container(
                              color: Color.fromARGB(50, 44, 170, 61),
                              height: 30,
                              width: 30,
                              padding: EdgeInsets.all(10),
                              child:CircularProgressIndicator(
                                color: const Color.fromARGB(255, 41, 63, 42),
                                //strokeCap: ,
                              ))
                                      
                                      ],)

 


                    ],
                  );

                      }
                    }
                  );
                  
                  
                  
                  
                  
                },
              ),


              Container(height: 10.0, width: 30),
              TextField(
                controller: _controller,
                contextMenuBuilder: (BuildContext context,
                    EditableTextState editableTextState) {
                  final List<ContextMenuButtonItem> buttonItems =
                      editableTextState.contextMenuButtonItems;
                  // Here we add an "Email" button to the default TextField
                  // context menu for the current platform, but only if an email
                  // address is currently selected.
                  final TextEditingValue value = _controller.value;
                  if (_isValidEmail(value.selection.textInside(value.text))) {
                    buttonItems.insert(
                      3,
                      ContextMenuButtonItem(
                        label: 'Send email',
                        onPressed: () {
                          //ContextMenuController.removeAny();
                          _showDialog(context);
                        },
                      ),
                    );
                  }

                  return AdaptiveTextSelectionToolbar.buttonItems(
                    anchors: editableTextState.contextMenuAnchors,
                    buttonItems: buttonItems,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyContextMenu extends StatelessWidget {
  const _MyContextMenu({
    required this.anchor,
    required this.children,
  });

  final Offset anchor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: anchor.dy,
          left: anchor.dx,
          child: Card(
            color: Colors.transparent,
            child: Column(

              
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}

bool _isValidEmail(String text) {
  return RegExp(
    r'(?<name>[a-zA-Z0-9]+)'
    r'@'
    r'(?<domain>[a-zA-Z0-9]+)'
    r'\.'
    r'(?<topLevelDomain>[a-zA-Z0-9]+)',
  ).hasMatch(text);
}