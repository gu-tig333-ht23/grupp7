import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

const String endPoint =
    'https://data.riksdagen.se/voteringlista/?rm=2022%2F23&bet=$beteckning&punkt=$forslagspunkt&parti=C&parti=FP&parti=L&parti=KD&parti=MP&parti=M&parti=S&parti=SD&parti=V&valkrets=&rost=&iid=&sz=500&utformat=json&gruppering=bet';

const String beteckning = 'au10';
const String forslagspunkt = '1';

