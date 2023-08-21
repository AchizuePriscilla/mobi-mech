import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

const String lastPage = 'lastPage';
const String kLatitude = 'latitude';
const String kLongitude = 'longitude';
const String kCurrentAddress = 'current-address';


//Routes

const splashScreenViewRoute = 'splash-screen-view';
const signUpViewRoute = 'sign-up-view';
const loginViewRoute = 'log-in-view';
const homeViewRoute = 'home-view';
const favoriteViewRoute = 'favorite-view';
const historyViewRoute = 'history-view';
const selectedMechanicViewRoute = 'selected-mechanic-view';

final apiKey = Platform.isAndroid
    ? dotenv.env['GOOGLE_MAPS_ANDROID_KEY']
    : dotenv.env['GOOGLE_MAPS_IOS_KEY'];
