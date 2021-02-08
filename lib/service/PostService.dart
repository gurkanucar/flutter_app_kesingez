import 'package:flutter_app_kesingez_denemeler/model/Post.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../Constants.dart';

class PostService {

 static String url = Constants.BASE_URL + "/api/post";
 static String token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTYyMDQwMTU5MiwiaWF0IjoxNjExNzYxNTkyfQ.d54aNmSkqwHK7xQGQZUpalpxOmrozjnMvL5rqmELknI";

  static Future<List<Post>> getPosts() async{
    try{
      Map<String,String> header={
        "Authorization":"Bearer "+token
      };

        final response = await http.get(url,headers: header);
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

 static Future<Post> getPostByID(int id) async{
   try{
     Map<String,String> header={
       "Authorization":"Bearer "+token
     };
     final response = await http.get(url+"/"+id.toString(),headers: header);
     if(response.statusCode==200){
      // print(response.body);
       var jsonResponse = json.decode(response.body);
       Post post= Post.fromJson(jsonResponse);
       print(post.detail.toString());
       return post;
     }
     else{
       print("Hata Oluştu!");
       return Post();
     }
   }
   catch (e){
     print("Hata Oluştu!\n"+e.toString());
     return Post();
   }
 }

}