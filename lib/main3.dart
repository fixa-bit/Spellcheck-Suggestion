import 'dart:convert';

import 'package:auto2/request.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flython/flython.dart';

void main() => runApp(const EditableTextToolbarBuilderExampleApp());

const String emailAddress = 'me@example.com';
const String text = 'Select the email address and open the menu: $emailAddress';




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

  callflask()async{
      var url = Uri.parse('http://10.0.2.2:5000/');
      var data = await getData(url);

      var decodedData = jsonDecode(data);  
      print(decodedData['query']);

    }
 List<String> tags = ["FAIZA", "FIZ", "FIZAA"];

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
                        onPressed: () async{   
                         print(tags[0]);

                        callflask();

                        
                        },
                        child: Text(tags[0]),
                      ),


              

              TextField(
                maxLines: 4,
                minLines: 2,
                contextMenuBuilder: (context, editableTextState) {
                  return _MyContextMenu(

                    
                    anchor: editableTextState.contextMenuAnchors.primaryAnchor,
                    children: [
                      TextSelectionToolbarTextButton(
                        padding: EdgeInsets.all(8),
                        onPressed: () {
                          debugPrint('Flutter');
                        },
                        child:       Container(
                          color: Color.fromARGB(50, 44, 170, 61),
        
        
                      height:150,
                      width:150,
                      child: Scrollbar(
                      thickness: 10,
                      child: SingleChildScrollView(child:
                      Column(children: [



                    for (var i = 0; i < tags.length; i++)
                       TextButton(

                        style: TextButton.styleFrom(
                           foregroundColor: Color.fromARGB(255, 126, 85, 85),
                           backgroundColor: Color.fromARGB(255, 44, 170, 61),
                         ),
                        onPressed: 
                         () async{   print(tags[i]);

                        await Clipboard.setData(ClipboardData(text: tags[i]));

                        editableTextState.pasteText(SelectionChangedCause.toolbar);
                        
                        },
                        child:  Text(tags[i],
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 69, 57, 77)
                          ),
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
                        
                        
                        
                        ],) )))
                      )
                    ],
                  );
                },
              ),
            
              Container(height: 10.0,width:30),
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
                          ContextMenuController.removeAny();
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
            color:Colors.transparent,
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