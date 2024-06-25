import 'dart:convert';

import 'package:auto2/request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'list_urdu-words.dart';



void main() => runApp(const EditableTextToolbarBuilderExampleApp());

const String emailAddress = 'me@example.com';
const String textxx = 'ناکس تان تان ناکستان ناکسن';

class CustomTextEditingController extends TextEditingController {
  final List<String> listErrorTexts;
  //String mytext="new text is here aa a no";
  String mytext="check this aa ناکستان initial text ناکستان chaeck thifs aha initijal پاکستانی texet";
  
  bool mybool=false;
  CustomTextEditingController({String? mytext, this.listErrorTexts = const []})
      : super(text:mytext);

  @override


  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final List<TextSpan> children = [];
    if (listErrorTexts.isEmpty) {
     
      return TextSpan(text: text, style: style,
       //recognizer: DoubleTapGestureRecognizer()..onDoubleTap = () => taptap(),

      );
    }
    try {

      final xx=RegExp(r'\b(' + listErrorTexts.join('|').toString() + r')+\b');
      print("xx");
      print(xx);
      print(listErrorTexts);
      print("xxxx");

      mytext.splitMapJoin(
          RegExp(r'(' + listErrorTexts.join('|').toString() + r')+',unicode: true),
          

          onMatch: (m) {

            print("see matched");

            print(m[0]);
        print("matched");

        children.add(TextSpan(
          text: m[0],
          style: style!.copyWith(
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.wavy,
              decorationColor: Colors.red),
        ));
        return "";
      }, onNonMatch: (n) {
        print(n);
        print("non matched");
        children.add(TextSpan(text: n, style: style));
        return n;
      });



    } on Exception {
      return TextSpan(text: text, style: style);
    }
    return TextSpan(children: children, style: style);
  }
}




class EditableTextToolbarBuilderExampleApp extends StatefulWidget {
  const EditableTextToolbarBuilderExampleApp({super.key});

  @override
  State<EditableTextToolbarBuilderExampleApp> createState() =>
      _EditableTextToolbarBuilderExampleAppState();
}

class _EditableTextToolbarBuilderExampleAppState
    extends State<EditableTextToolbarBuilderExampleApp> {
  //  TextEditingController _controller = TextEditingController(
  //   text: text,
  // );

   CustomTextEditingController _controller = CustomTextEditingController();

  String selectedWord='';
  


  // final List<ContextMenuButtonItem> buttonItems =
  //                     editableTextState.contextMenuButtonItems;

  void _showDialog(BuildContext context) {
    Navigator.of(context).push(
      DialogRoute<void>(
        context: context,
        builder: (BuildContext context) =>
            const AlertDialog(title: Text('You clicked send email!')),
      ),
    );
  }
  //late TextSelection selection;
  late var start;
  late var end;
  final List<String> listTexts = [];
  final List<String> listErrorTexts = [];
  late List result;

  String mytext="check this aa ناکستان initial text ناکستان chaeck thifs aha initijal پاکستانی texet";

  @override
  void initState() {
    super.initState();

    initial_text();
    result = mytext.split(' ');



    // _controller.addListener(() async {

          
    // selection = _controller.selection;
    //   if (selection.start > -1)  start = selection.baseOffset;
    //   if (selection.end > -1)  end = selection.extentOffset;

       
    // });


    // On web, disable the browser's context menu since this example uses a custom
    // Flutter-rendered context menu.
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }


    
  }

  void initial_text(){
    _handleSpellCheck( mytext, false);
    result = mytext.split(' ');
    _controller = CustomTextEditingController(mytext:mytext,listErrorTexts: listErrorTexts);



  }

  void _handleOnChange(String text) {
    // _controller.mytext=mytext;
    // mytext = _controller.text;

    

    //_controller.text;
    setState(() {
      
          mytext = _controller.mytext;
          mytext = _controller.text;

        });
    _handleSpellCheck(text, true);


    _controller.mytext=mytext;
  }
  void _handleSpellCheck(String text, bool ignoreLastWord) {
    if (!text.contains(' ')) {
      return;
    }
    final List<String> arr = text.split(' ');
    if (ignoreLastWord) {
      arr.removeLast();
    }
    for (var word in arr) {
      if (word.isEmpty) {
        continue;
      } else if (_isWordHasNumberOrBracket(word)) {
        continue;
      }
      //final wordToCheck = word.replaceAll(RegExp(r"[^\s\w]"), '');
      final wordToCheck = word.replaceAll(RegExp(r"[^\s\[\u0600-\u06FF]]"), '');
      print("word to check");
      print(wordToCheck);
      print("checked");
      final wordToCheckInLowercase=wordToCheck.replaceAll(' ', '');

      //final wordToCheckInLowercase = wordToCheck.toLowerCase();
      if (!listTexts.contains(wordToCheckInLowercase)) {
        listTexts.add(wordToCheckInLowercase);
      if (!listEnglishWords.contains(wordToCheckInLowercase)) {
          listErrorTexts.add(wordToCheck);
        }
      }
    }
    print('listErrorTexts');
    print(listErrorTexts);
  }
  bool _isWordHasNumberOrBracket(String s) {
    return s.contains(RegExp(r'[0-9\()]'));
  }

  // Future<List<String>> readscript() async {
  //   var data = await getData('http://10.0.2.2:5000/');
  //   var decodedData = jsonDecode(data);
  //   print(decodedData['query']);
  //   String decodedstring = decodedData['query'];
  //   var xx = decodedstring.split(',');

  //   return xx;
  // }



  Future<List<String>> readscript4() async {
    print(mytext);
    print("kkkkkkkk");
    _controller.mytext=mytext;
    selectedWord=_controller.selection.textInside(_controller.mytext);
    print("here");
    final url = 'http://10.0.2.2:5000/name' ;
    print(selectedWord);
    //print("ok");
    final response = await http.post(Uri.parse(url) , body: json.encode({'name' : selectedWord}));
    var data=response.body;
    var decodedData = jsonDecode(data);
    print(decodedData['query']);
    String decodedstring = decodedData['query'];
    var xx = decodedstring.split(',');

    tags = xx;
    print("ok");
    return xx;
    
  }


  // readscript3() async {
  //   print("here");
  //   final url = 'http://10.0.2.2:5000/name' ;
  //   //final url = 'http://192.168.2.67:5000/name' ;
  //   print(selectedWord);
    
  //   final response = await http.post(Uri.parse(url) , body: json.encode({'name' : selectedWord}));
  //   var data=response.body;
  //   var decodedData = jsonDecode(data);
  //   print(decodedData['query']);
  //   String decodedstring = decodedData['query'];
  //   var xx = decodedstring.split(',');

  //   tags = xx;
  //   print("ok");

  // }
  addToDictionary(selectedwordx) async{
   print(listErrorTexts);


          listErrorTexts.remove(selectedwordx);
          setState(() {
            listErrorTexts;
          });
          print(listErrorTexts);
   
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
                  //readscript3();
                },
                child: Text("check fn"),
              ),
              TextField(
                controller: _controller,
                
                onChanged: _handleOnChange,
                maxLines: 4,
                minLines: 2,
                onTap: () async {
                  //tags = await readscript3();
                  print(listErrorTexts);
                  tags=await readscript4();
                },
                contextMenuBuilder: (context, editableTextState) {
                   
                  mytext = _controller.text;
            
              
                  // print(_controller.selection.textInside(_controller.mytext));

                  selectedWord=_controller.selection.textInside(_controller.mytext);
                  //tags=[''];
                  
                  //readscript3();
                  

                  return 
                  
                                    listErrorTexts.contains(selectedWord)==true?
                   //selectedWord.length>0 ?
                  
                   FutureBuilder<List<String>>(
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
                          child: tags.length==1?     
                          TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Colors.blue,
                                        ),
                                        onPressed: () async{   
                                        String seltxt =_controller.selection.textInside(_controller.mytext);
                                         
                                        addToDictionary(_controller.selection.textInside(_controller.mytext));
                                        // print(tags[0]);

                                        await Clipboard.setData(ClipboardData(text: seltxt));

                                        editableTextState.pasteText(SelectionChangedCause.toolbar);
                                       

                                        },
                                        child: Text("Add to Dictionary"),
                                      )
                          :
                          
                          Container(
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
                                             addToDictionary(tags[i]);

                                            await Clipboard.setData(
                                                ClipboardData(text: tags[i]));

                                            await editableTextState.pasteText(
                                                SelectionChangedCause.toolbar);
                                                _controller.mytext=mytext;
                                                setState(() {
                                                  addToDictionary(tags[i]);
                                                  var tagsx=tags[i].split(' ');
                                                  if (tagsx.length>1){

                                                    addToDictionary(tagsx[0]);
                                                    addToDictionary(tagsx[1]);
                                                  } 
                                                  
                                                });

                                               

                                             
                                          },
                                          child: Text(
                                            tags[i],
                                            style: const TextStyle(
                                                fontSize: 10.0,
                                                color: Color.fromARGB(
                                                    255, 69, 57, 77)),
                                          ),
                                        ),



                                        TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Colors.blue,
                                        ),
                                        onPressed: () async{   
                                        String seltxt =_controller.selection.textInside(_controller.mytext);
                                         
                                        addToDictionary(_controller.selection.textInside(_controller.mytext));
                                        // print(tags[0]);

                                        await Clipboard.setData(ClipboardData(text: seltxt));

                                        editableTextState.pasteText(SelectionChangedCause.toolbar);
                                       

                                        },
                                        child: Text("Add to Dictionary"),
                                      ),

                                      // Text(
                                      //   "More Optins",
                                      //   maxLines: 8,
                                      //   overflow: TextOverflow.visible,
                                      // ),
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
                  )

                                    :_MyContextMenu(
                    anchor: editableTextState.contextMenuAnchors.primaryAnchor,
                    children: editableTextState.contextMenuButtonItems
                        .map((ContextMenuButtonItem buttonItem) {
                      return CupertinoButton(
                        borderRadius: null,
                        color: Color.fromARGB(99, 165, 255, 62),
                        disabledColor: const Color(0xffaaaaff),
                        onPressed: buttonItem.onPressed,
                        padding: const EdgeInsets.all(10.0),
                        pressedOpacity: 0.3,
                        child: SizedBox(
                          width: 100.0,
                          child: Text(
                            CupertinoTextSelectionToolbarButton.getButtonLabel(
                                context, buttonItem),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                  
                  //:Container()
                  //:Container();
                  
                  
                  
                },
              ),


              Container(height: 10.0, width: 30),
              // TextField(
              //   controller: _controller,
              //   contextMenuBuilder: (BuildContext context,
              //       EditableTextState editableTextState) {
              //     final List<ContextMenuButtonItem> buttonItems =
              //         editableTextState.contextMenuButtonItems;
              //     // Here we add an "Email" button to the default TextField
              //     // context menu for the current platform, but only if an email
              //     // address is currently selected.
              //     final TextEditingValue value = _controller.value;
              //     if (_isValidEmail(value.selection.textInside(value.text))) {
              //       buttonItems.insert(
              //         3,
              //         ContextMenuButtonItem(
              //           label: 'Send email',
              //           onPressed: () {
              //             //ContextMenuController.removeAny();
              //             _showDialog(context);
              //           },
              //         ),
              //       );
              //     }

              //     return AdaptiveTextSelectionToolbar.buttonItems(
              //       anchors: editableTextState.contextMenuAnchors,
              //       buttonItems: buttonItems,
              //     );
              //   },
              // ),
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