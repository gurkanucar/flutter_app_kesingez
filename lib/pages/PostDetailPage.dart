import 'package:flutter/material.dart';
import 'package:flutter_app_kesingez_denemeler/model/Post.dart';
import 'package:flutter_app_kesingez_denemeler/service/PostService.dart';
import 'dart:async';
import '../Constants.dart';

class PostDetailPage extends StatefulWidget {
  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  Post _post;
  bool _loading;

  void getPost() {
    _loading = true;
    PostService.getPostByID(3).then((value) {
      setState(() {
        _post = value;
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Center(child: CircularProgressIndicator(),)
      body: _loading ==
              Center(
                child: CircularProgressIndicator(),
              )
          ? null
          : Container(child: customScrollView(_post)),
    );
  }

  CustomScrollView customScrollView(Post post) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        expandedHeight: MediaQuery.of(context).size.height * 0.8,
        flexibleSpace: new FlexibleSpaceBar(
          background: post?.imageList?.length != null
              ? Container(
                  child: post?.imageList?.length != null
                      ? FadeInImage.assetNetwork(
                          placeholder: 'assets/loading.gif',
                          image: post?.imageList?.length != null
                              ? Constants.BASE_URL +
                                  Constants.IMAGE_BASE_URL +
                                  post?.imageList?.first?.name
                              : 'assets/loading.gif',
                          fit: BoxFit.cover,
                        )
                      : null,
                )
              : Container(),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(
              title: Container(
            child: Column(
              children: [
                item(post),
              ],
            ),
          )),
        ]),
      )
    ]);
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
                post.imageList.length > 0
                    ? Container(
                        margin: EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 5.0, right: 5.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: post.imageList.length > 0
                              ? FadeInImage.assetNetwork(
                                  placeholder: 'assets/loading.gif',
                                  image: post.imageList.length > 0
                                      ? Constants.BASE_URL +
                                          Constants.IMAGE_BASE_URL +
                                          post.imageList.first?.name
                                      : 'assets/loading.gif',
                                  fit: BoxFit.fitWidth,
                                )
                              : null,
                        ))
                    : Container(),
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
