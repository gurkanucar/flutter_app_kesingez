import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kesingez_denemeler/model/Post.dart';
import 'package:flutter_app_kesingez_denemeler/service/PostService.dart';
import 'dart:async';
import '../Constants.dart';

class PostDetailPage extends StatefulWidget {
  int postID=0;
  PostDetailPage({this.postID});
  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  Post _post;
  bool _loading;
  int _current = 0;
  List _imgList = [];
  int _maxLineBeforeTap = 2;

  String _address = "";
  String _addressDetail = "";

  String makeCapitalLetter(String s) {
    s = s[0].toUpperCase() + s.substring(1, s.length).toLowerCase();
    return s;
  }

  void getPost() async {
    _loading = true;
    await PostService.getPostByID(widget.postID).then((value) {
      setState(() {
        _post = value;
        _post.imageList.forEach((element) {
          _imgList.add(element.name);
          print(element.name);
          _maxLineBeforeTap = 2;
        });

        if (_post.address.addressDto != null) {
          _address = Constants
                  .COUNTRIES[_post.address.addressDto.countryName.toUpperCase()]
                  .toUpperCase() +
              ", " +
              Constants.REGIONS[_post.address.addressDto.region] +
              ", " +
              makeCapitalLetter(_post.address.addressDto.cityName) +
              ", " +
              makeCapitalLetter(_post.address.addressDto.districtName);

          _addressDetail = _post.address.detail;
        }
        if (_post.userName != null) {
          _loading = false;
        }
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
      appBar: AppBar(

        title:Text("Detaylar"),
      ),
        // Center(child: CircularProgressIndicator(),)
        body: RefreshIndicator(
      onRefresh: () async {
        await getPost();
      },
      child: _loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(child: customScrollView()),
    ));
  }

  CustomScrollView customScrollView() {
    return CustomScrollView(slivers: [
      SliverAppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        expandedHeight: MediaQuery.of(context).size.height * 0.6,
        flexibleSpace: new FlexibleSpaceBar(
          background:
              _post?.imageList?.length != null ? imageSlider() : Container(),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(
              title: Container(
            child: Column(
              children: [
                item(),
              ],
            ),
          )),
        ]),
      )
    ]);
  }

  Container imageSlider() {
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 0.0, left: 1.0, right: 1.0),
      child: CarouselSlider(
        height: MediaQuery.of(context).size.height * 0.6,
        initialPage: 0,
        enlargeCenterPage: true,
        autoPlay: true,
        reverse: false,
        enableInfiniteScroll: true,
        autoPlayInterval: Duration(seconds: 2),
        autoPlayAnimationDuration: Duration(milliseconds: 2000),
        pauseAutoPlayOnTouch: Duration(seconds: 10),
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
        items: _imgList.map((imgUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white70,
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/loading.gif',
                  image: _post?.imageList?.length != null
                      ? Constants.BASE_URL +
                          Constants.IMAGE_BASE_URL +
                          imgUrl.toString()
                      : 'assets/loading.gif',
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Container item() {
    return Container(
        margin: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 1.0, right: 1.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueAccent,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
                    child: Row(
                      children: [
                        InkWell(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                size: 40,
                                color: Colors.red,
                              ),
                              Text("Haritada aç")
                            ],
                          ),
                          onTap: () {
                            print("Haritada aça basıldı");
                          },
                        ),
                        Spacer(),
                        Text(
                          "Adres",
                          style: TextStyle(fontSize: 25),
                          maxLines: _maxLineBeforeTap,
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _maxLineBeforeTap = 20;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _address,
                              style: TextStyle(fontSize: 20),
                              maxLines: _maxLineBeforeTap,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "\n" + _addressDetail,
                              style: TextStyle(fontSize: 17),
                              maxLines: _maxLineBeforeTap,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueAccent,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                left: 15.0,
                                right: 1.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  child: Text(_post?.userName[0]
                                      .toString()
                                      .toUpperCase()),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 15.0,
                                      left: 15.0,
                                      right: 1.0),
                                  child: Text(
                                    makeCapitalLetter(_post?.userName),
                                  ),
                                )
                              ],
                            )),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(
                              top: 15.0, bottom: 15.0, left: 1.0, right: 15.0),
                          child: Text("Detaylar",
                              style: TextStyle(fontSize: 25)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
                    child: Text("   " + _post.detail,
                        style: TextStyle(fontSize: 20)),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
