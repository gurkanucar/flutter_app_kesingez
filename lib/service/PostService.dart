import 'package:flutter_app_kesingez_denemeler/model/Post.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../Constants.dart';

class PostService {

 static String url = Constants.BASE_URL + "/api/post";

  static Future<List<Post>> getPosts() async{
    try{
        final response = await http.get(url);
       if(response.statusCode==200){
         List<Post> posts=postsFromJson(response.body);
         print(posts.toString());
         return posts;
       }
       else{
         print("Hata Oluştu!");
         return List<Post>();
       }
    }
    catch (e){
      print("Hata Oluştu!\n"+e.toString());
      return List<Post>();
    }
  }

}