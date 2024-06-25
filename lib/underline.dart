import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
//import 'custom_text_editing_controller.dart';
import 'list_english_words.dart';

//void main() => runApp(const HomePage());
void main() {
  runApp(
    const MaterialApp(home: HomePage()), // use MaterialApp
  );
}
class CustomTextEditingController extends TextEditingController {
  final List<String> listErrorTexts;
  String mytext="new text is here aa a no";
  
  bool mybool=false;
  CustomTextEditingController({String? text, this.listErrorTexts = const []})
      : super(text:text);

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
      text.splitMapJoin(
          RegExp(r'\b(' + listErrorTexts.join('|').toString() + r')+\b'),
          onMatch: (m) {
        children.add(TextSpan(
          text: m[0],
          style: style!.copyWith(
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.wavy,
              decorationColor: Colors.red),
        ));
        return "";
      }, onNonMatch: (n) {
        children.add(TextSpan(text: n, style: style));
        return n;
      });
    } on Exception {
      return TextSpan(text: text, style: style);
    }
    return TextSpan(children: children, style: style);
  }
}




class HomePage extends StatefulWidget {
   const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> listErrorTexts = [];

  final List<String> listTexts = [];
  String mytext="check this aa initial text chaeck thifs aha initijal texet";
  late List result;
  late var start;
  late var end;
  late TextSelection selection;


  CustomTextEditingController _controller = CustomTextEditingController();
  
  late int startindex=0;
  
  late int endindex=0;




  GlobalKey _textFieldKey = GlobalKey();
  TextStyle _textFieldStyle = TextStyle(fontSize: 20);
  TextEditingController _textFieldController = TextEditingController();
  late TextField _textField;
  double xCaret = 0.0;
  double yCaret = 0.0;
  double painterWidth = 0.0;
  double painterHeight = 0.0;
  double preferredLineHeight = 0.0;

  Offset _tapPosition = Offset.zero;
  
  String word_selected='';
  bool tooglex=false;


  @override
  void initState() {
    initial_text();
    //_controller = CustomTextEditingController(text:"ceck this initial text",listErrorTexts: listErrorTexts);
    result = mytext.split(' ');
    super.initState();
    //https://stackoverflow.com/questions/69191432/get-selection-of-textformfield-in-flutter

        _controller.addListener(() async {


       selection = _controller.selection;
      if (selection.start > -1)  start = selection.baseOffset;
      if (selection.end > -1)  end = selection.extentOffset;

       
    });
    
  }



  void initial_text(){
    _handleSpellCheck( mytext, false);
    result = mytext.split(' ');
    _controller = CustomTextEditingController(text:mytext,listErrorTexts: listErrorTexts);



  }

  void _handleOnChange(String text) {
    _handleSpellCheck(text, true);
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
      final wordToCheck = word.replaceAll(RegExp(r"[^\s\w]"), '');
      final wordToCheckInLowercase = wordToCheck.toLowerCase();
      if (!listTexts.contains(wordToCheckInLowercase)) {
        listTexts.add(wordToCheckInLowercase);
        if (!listEnglishWords.contains(wordToCheckInLowercase)) {
          listErrorTexts.add(wordToCheck);
        }
      }
    }
  }

  bool _isWordHasNumberOrBracket(String s) {
    return s.contains(RegExp(r'[0-9\()]'));
  }

  calculateoffset(){
    setState(() {
          mytext = _controller.text;
        });
    int indextext=_controller.selection.start;
    //var afterbang = mytext.substring(indextext, mytext.indexOf(' ', indextext));


    var afterbangx = mytext.substring(indextext, );

    //print(afterbangx);
    //print(indextext);
    if(indextext < mytext.length){

    if(afterbangx.contains(' '))  //detects last word
    
    {

          var afterbang = mytext.substring(0, mytext.indexOf(' ', indextext));
          endindex=mytext.indexOf(' ', indextext);


          var lastspace = afterbang.substring(afterbang.lastIndexOf(' ') + 1);
          

          startindex=afterbang.lastIndexOf(' ') + 1;


          // print(endindex);
          // print(startindex);


          print(lastspace);
          word_selected=lastspace;



    }
    else
    {
      var lastspacex = mytext.substring(mytext.lastIndexOf(' ') + 1);


      startindex=mytext.lastIndexOf(' ') + 1;

      endindex=mytext.length;

      var lastspace=lastspacex;
      // print(endindex);
      // print(startindex);
      print(lastspace);
      word_selected=lastspace;
      

    }
    }
    else{
      word_selected="";

    }





  if (listErrorTexts.contains(word_selected)){
    print("this word not in error list");

  }

    
  }
int selected = 0;

void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    _tapPosition = referenceBox.globalToLocal(details.globalPosition);

    
}
    late OverlayEntry overlayEntry; 
void _showOverlay(BuildContext context) async { 
      
    // Declaring and Initializing OverlayState 
    // and OverlayEntry objects 

    OverlayState overlayState = Overlay.of(context); 

    overlayEntry = OverlayEntry(builder: (context) { 
        
      // You can return any widget you like here 
      // to be displayed on the Overlay 
      return Positioned( 
        // left: MediaQuery.of(context).size.width * 0.3, 
        // top: MediaQuery.of(context).size.height * 0.3, 
        left: _tapPosition.dx, 
        top: _tapPosition.dy, 
        // RelativeRect.fromRect(
        //     Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 20, 20),
        //     Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
        //         overlay.paintBounds.size.height)),
        child:  GestureDetector(

          onTap: (){
            //overlayEntry?.remove();
          },
        child : Container( 
          //width: MediaQuery.of(context).size.width * 0.8, 
          child: Stack( 
            children: [ 

              Positioned( 
                //top: MediaQuery.of(context).size.height * 0.13, as
                //left: MediaQuery.of(context).size.width * 0.13, 

                child: Column( 
                  children: [ 
                  
                    Material( 
                      color: Colors.transparent, 
                      child: 
                      Text( 
                        'This is a button!', 
                        style: TextStyle( 
                            fontSize: MediaQuery.of(context).size.height * 0.03, 
                            color: Colors.green), 
                      ), 
                    ), 
                 
                  ], 
                ), 
              ), 
            ], 
          ), 
        ), 
      )); 
    }); 
  
    // Inserting the OverlayEntry into the Overlay 
    overlayState.insert(overlayEntry); 
  } 



void _showContextMenu(BuildContext context) async {
    final RenderObject? overlay =
        Overlay.of(context)?.context.findRenderObject();

    final result = await showMenu(
        context: context,

        // Show the context menu at the tap location
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 20, 20),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),

        // set a list of choices for the context menu
        
        items: [
          const PopupMenuItem(
            value: 'favorites',
            child: Text('word1'),
          ),
          const PopupMenuItem(
            value: 'comment',
            child: Text('word2'),
          ),
          const PopupMenuItem(
            value: 'hide',
            child: Text('word3'),
          ),
          const PopupMenuItem(
            value: 'hide',
            child: Text('word4'),
          ),

          const PopupMenuItem(
            child: Text('word5'),
          ),




        ]);


  }
  Container overlaylistview() {
    return(Container(height: 50,width: 50,color: Colors.red,));


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:const  Text('Flutter Spell Checker Demo'),
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SizedBox(
        height: 600,
        width: 1000,
        child:Column(

        children: [
          SelectableText(
          "Flutter Spelling Checker and Suggestions",
          style: TextStyle(color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 45
          ),
          textAlign: TextAlign.center,
          onTap: () => print(listErrorTexts),
          //toolbarOptions: ToolbarOptions(copy: true, selectAll: true,),
          showCursor: true,
          cursorWidth: 2,
          cursorColor: Colors.red,
          cursorRadius: Radius.circular(5),

        ),

          Container(
            padding:  const EdgeInsets.all(0.0),
            width: 400,
            child: GestureDetector(
               onTap:() {
                
                print("ok22");

              },
              child: TextFormField(
                
                  controller: _controller,
                  onChanged: _handleOnChange,
                  minLines: 5,
                  maxLines: 10,
                  // selectionControls: FlutterSelectionControls(
                  //   toolBarItems: <ToolBarItem>[]
                  // ),
                  onTap: () {
                    calculateoffset();

                    //_controller.text = "My Stringt";
                    //print(_controller.text.substring(_controller.selection.start,_controller.selection.end+1));
                    print(_controller.text.substring(startindex,endindex));
                    print("inloop");
                    

                    //_controller.selection = TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
                    
                  },
                  
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 75, 4, 255)),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 0, 255, 8))),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)))),
            onTapDown: (details) => _getTapPosition(details),
            onLongPress: () {
                
              
              calculateoffset();
              print(_controller.text.substring(startindex,endindex));


              print(word_selected);
              listErrorTexts.contains(word_selected)==true?
              word_selected.length>0 
              ?_showContextMenu(context)//_showOverlay(context)//
              :Container()
              :Container();
            },

            ),
          ),



          
        ],
      ),
    ),);
  }
  

}