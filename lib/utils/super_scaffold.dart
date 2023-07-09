import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final RouteObserver<PageRoute> superScaffoldRouteObserver =  RouteObserver<PageRoute>();

void superPrint(var content,{var title = 'Super Print'}){

  String callerFrame = '';

  if(kDebugMode){
    try{
      final stackTrace = StackTrace.current;
      final frames = stackTrace.toString().split("\n");
      callerFrame = frames[1];
    }
    catch(e){
      print(e);
    }

    DateTime dateTime = DateTime.now();
    String dateTimeString = '${dateTime.hour} : ${dateTime.minute} : ${dateTime.second}.${dateTime.millisecond}';
    // print('');
    // print('- ${title.toString()} - ${callerFrame.split('(').last.replaceAll(')', '')}' );
    // print('____________________________');
    try{
      print(const JsonEncoder.withIndent('  ').convert(const JsonDecoder().convert(content)));
    }
    catch(e1){
      try{
        print(const JsonEncoder.withIndent('  ').convert(const JsonDecoder().convert(jsonEncode(content))));
      }
      catch(e2){
        print(content);
      }

    }
    // print('____________________________ $dateTimeString');
  }
}

class FlutterSuperScaffold extends StatefulWidget{
  final Widget body;
  final Color topColor;
  final Color botColor;
  final Color backgroundColor;
  final AppBar? appBar;
  final bool isTopSafe;
  final bool isBotSafe;
  final bool isResizeToAvoidBottomInset;
  final FloatingActionButton? floatingActionButton;
  final Brightness statusBarBrightness;
  final Brightness statusIconBrightness;
  final VoidCallback? onWillPop;
  final bool isWillPop;
  const FlutterSuperScaffold({Key? key,required this.body,this.floatingActionButton, this.topColor = Colors.white,this.botColor = Colors.white,this.backgroundColor=Colors.white,this.appBar,this.isBotSafe=true,this.isTopSafe=true,this.isResizeToAvoidBottomInset=true, this.statusBarBrightness = Brightness.light,this.statusIconBrightness=Brightness.dark,this.onWillPop,this.isWillPop=true}) : super(key: key);

  @override
  State<FlutterSuperScaffold> createState() => _FlutterSuperScaffoldState();
}

class _FlutterSuperScaffoldState extends State<FlutterSuperScaffold> with RouteAware {

  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle();
  SystemUiOverlayStyle androidStyle = const SystemUiOverlayStyle();

  @override
  void initState() {
    setColors();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    superScaffoldRouteObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    setColors();
    super.didPopNext();
  }

  @override
  void dispose() {
    superScaffoldRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setColors();
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: WillPopScope(
        onWillPop: ()async{
          if(widget.onWillPop != null){
            widget.onWillPop!();
          }
          return widget.isWillPop;
        },
        child: Scaffold(
          appBar: widget.appBar,
          backgroundColor: widget.backgroundColor,
          floatingActionButton: widget.floatingActionButton,
          resizeToAvoidBottomInset:widget.isResizeToAvoidBottomInset,
          body: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  if(widget.isTopSafe)topPadding(widget.topColor),
                  Expanded(child: widget.body),
                  if(widget.isBotSafe)botPadding(widget.botColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget topPadding(Color color){
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).padding.top,
      color: color,
    );
  }

  Widget botPadding(Color color){
    return Container(
      width:double.maxFinite,
      height: MediaQuery.of(context).padding.bottom,
      color: color,
    );
  }

  void setColors(){
    if(Platform.isIOS){
      iosSetColor();
    }
    else if(Platform.isAndroid){
      androidSetColor();
    }
  }

  void iosSetColor(){
    if(!widget.isTopSafe){
      SystemChrome.setSystemUIOverlayStyle(
          systemUiOverlayStyle.copyWith(
              statusBarBrightness: Brightness.light,
              systemNavigationBarColor: widget.botColor
          )
      );
    }
    else{
      if(widget.topColor.computeLuminance()>0.5){
        SystemChrome.setSystemUIOverlayStyle(
            systemUiOverlayStyle.copyWith(
                statusBarBrightness: Brightness.light,
                systemNavigationBarColor: widget.botColor
            )
        );
      }
      else{
        SystemChrome.setSystemUIOverlayStyle(
            systemUiOverlayStyle.copyWith(
                statusBarBrightness: Brightness.dark,
                systemNavigationBarColor: widget.botColor
            )
        );
      }
    }
  }

  void androidSetColor(){
    // superPrint(widget.topColor.computeLuminance(),title: widget.isTopSafe);
    if(!widget.isTopSafe){
      SystemChrome.setSystemUIOverlayStyle(
          androidStyle.copyWith(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: widget.topColor.computeLuminance() > 0.5? Brightness.dark:Brightness.light,
          )
      );

    }
    else{
      SystemChrome.setSystemUIOverlayStyle(
          androidStyle.copyWith(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: widget.botColor.computeLuminance() > 0.5? Brightness.dark:Brightness.light,
            // systemNavigationBarColor: widget.botColor
          )
      );
    }
  }
}






