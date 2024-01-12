
import 'package:flutter/cupertino.dart';

late double _screenWidth;
late double _screenHeight;

void setMediaSize(BuildContext context){
  MediaQueryData queryData = MediaQuery.of(context);
  _screenWidth = queryData.size.width;
  _screenHeight = queryData.size.height;
}

double getMediaWidthSize(){
  return _screenWidth;
}

double getMediaHeightSize(){
  return _screenHeight;
}
