


import 'package:flutter/material.dart';
import 'package:metaozce/pages/DetailPage/detail_screen.dart';

import 'package:metaozce/pages/HomePage/components/widgets/color.dart';
import 'package:metaozce/pages/HomePage/components/widgets/custom_image.dart';
import 'package:metaozce/pages/HomePage/components/widgets/favorite_box.dart';


class DetailItem extends StatelessWidget {
  const DetailItem({
    Key? key,
    required this.data,
    this.width = 500,
    this.height = 300,
    this.onTap,
    this.onTapFavorite,
  }) : super(key: key);

  final data;
  final double width;
  final double height;
  final GestureTapCallback? onTapFavorite;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            Container(
              width: width - 20,
              padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildName(),
                  SizedBox(
                    height: 5,
                  ),
                  //_buildInfo(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildName() {
    
    return Text(
      data["otelAd"],
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 18,
        color: AppColor.textColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data["otelAd"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColor.labelColor,
                fontSize: 13,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              data["bolge"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColor.primary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        // FavoriteBox(
        //   size: 16,
        //   onTap: onTapFavorite,
        //   isFavorited: data["is_favorited"],
        // )
      ],
    );
  }

  Widget _buildImage() {
    return CustomImage(
      
      data["imageurl"]==null? "https://images.unsplash.com/photo-1598928636135-d146006ff4be?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60":data["imageurl"],
     
      width: double.infinity,
      height: 190,
      radius: 15,
    );
  }
}