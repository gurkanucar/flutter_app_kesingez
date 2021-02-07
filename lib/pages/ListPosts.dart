import 'package:flutter/material.dart';
import 'package:flutter_app_kesingez_denemeler/Constants.dart';
import 'package:flutter_app_kesingez_denemeler/model/Post.dart';
import 'package:flutter_app_kesingez_denemeler/service/PostService.dart';

class ListPosts extends StatefulWidget {
  @override
  _ListPostsState createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  List<Post> _posts;
  bool _loading;

  void getPosts() {
    _loading = true;
    PostService.getPosts().then((value) {
      setState(() {
        _posts = value;
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        await getPosts();
      },
      child: ListView.builder(
          itemCount: null == _posts ? 0 : _posts.length,
          itemBuilder: (context, index) {
            return item(_posts[index]);
          }),
    ));
  }

  Container item(Post post) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 5.0, right: 5.0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
          child: Container(
            margin:
                EdgeInsets.only(top: 15.0, bottom: 15.0, left: 5.0, right: 5.0),
            child: Column(
              children: [
                ListTile(
                  title: Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        children: [
                          Text(post.address.addressDto.cityName +
                              ", " +
                              post.address.addressDto.districtName),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              print("Menu");
                            },
                            child: Icon(Icons.menu),
                          )
                        ],
                      )),
                  subtitle: Text(
                    post.detail,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 5.0, right: 5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.network(
                        Constants.BASE_URL +
                            Constants.IMAGE_BASE_URL +
                            post.imageList.first.name,
                        fit: BoxFit.fitWidth,
                      ),
                    )),
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.0,
                      ),
                      InkWell(
                        child: post.alreadyLiked == 1
                            ? Icon(Icons.local_see)
                            : Icon(Icons.local_see_outlined),
                        onTap: () {
                          setState(() {
                            if (post.alreadyLiked != 1) {
                              post.likeCount += 1;
                              post.alreadyLiked = 1;
                            } else {
                              post.likeCount -= 1;
                              post.alreadyLiked = 0;
                            }
                          });
                          print("basild");
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(post.likeCount.toString()),
                      Spacer(),
                      Container(
                          margin: EdgeInsets.only(right: 10.0),
                          child: InkWell(
                            onTap: () {
                              print("basildi");
                            },
                            child: CircleAvatar(
                              child: Text(
                                  post.userName[0].toString().toUpperCase()),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
