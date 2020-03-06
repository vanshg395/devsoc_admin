import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BoardList extends StatelessWidget {
  Widget getBoardPic(String path, String name, String post, String url) {
    return InkWell(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(
            url,
            forceSafariVC: true,
          );
        }
      },
      child: Container(
        width: 200,
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LayoutBuilder(
                  builder: (ctx, cons) => Container(
                    width: cons.maxWidth,
                    height: cons.maxHeight,
                    child: Image.asset(
                      path,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            LayoutBuilder(
              builder: (ctx, cons) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  width: cons.maxWidth,
                  height: cons.maxHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withAlpha(0),
                        Colors.black,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
            LayoutBuilder(
              builder: (ctx, cons) => Container(
                alignment: Alignment.bottomLeft,
                width: cons.maxWidth,
                height: cons.maxHeight,
                padding: EdgeInsets.only(
                  left: 15,
                  bottom: 40,
                ),
                child: FittedBox(
                  child: Text(
                    post,
                    style: TextStyle(
                      fontFamily: 'SFProDisplayMed',
                      letterSpacing: 2,
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
            LayoutBuilder(
              builder: (ctx, cons) => Container(
                alignment: Alignment.bottomLeft,
                width: cons.maxWidth,
                height: cons.maxHeight,
                padding: EdgeInsets.only(
                  left: 15,
                  bottom: 20,
                ),
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'SFProDisplayMed',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView(
        children: [
          SizedBox(
            width: 20,
          ),
          getBoardPic('assets/img/board/aryan_bhatnagar.jpg', 'ARYAN BHATNAGAR',
              'CHAIR', 'https://www.instagram.com/aryan_bhatnagarr/'),
          SizedBox(
            width: 12,
          ),
          getBoardPic(
            'assets/img/board/amulya.jpg',
            'AMULYA BOYAPATI',
            'VICE CHAIR MANAGEMENT  ',
            'https://www.linkedin.com/in/amulya-boyapati-546b4a15a/',
          ),
          SizedBox(
            width: 12,
          ),
          getBoardPic(
            'assets/img/board/angad_sharma.jpg',
            'ANGAD SHARMA',
            'VICE CHAIR TECHNICAL',
            'https://www.instagram.com/l04db4l4nc3r/',
          ),
          SizedBox(
            width: 12,
          ),
          getBoardPic(
            'assets/img/board/animesh_ashish.jpg',
            'ANIMESH ASHISH',
            'SECRETARY-INTERNAL AFFAIRS   ',
            'https://www.linkedin.com/in/animesh-ashish/',
          ),
          SizedBox(
            width: 12,
          ),
          getBoardPic(
            'assets/img/board/pritika_roy.jpg',
            'PRITIKA ROY',
            'OPERATIONS DIRECTOR',
            'https://www.linkedin.com/in/pritika-roy-chowdhury-3956ba160/',
          ),
          SizedBox(
            width: 12,
          ),
          getBoardPic(
            'assets/img/board/aman_raghav.jpg',
            'AMAN RAGHAV',
            'EVENTS DIRECTOR',
            '',
          ),
          SizedBox(
            width: 12,
          ),
          getBoardPic(
            'assets/img/board/akshat_pethiya.jpg',
            'AKSHAT PETHIYA',
            'SECRETARY-EXTERNAL AFFAIRS   ',
            'https://www.linkedin.com/in/akshat-pethiya-04295a177',
          ),
          SizedBox(
            width: 12,
          ),
          getBoardPic(
            'assets/img/board/tanya_sharma.jpg',
            'TANYA SHARMA',
            'HR DIRECTOR',
            '',
          ),
          SizedBox(
            width: 12,
          ),
          getBoardPic(
            'assets/img/board/debalok.jpg',
            'DEBALOK BANERJEE',
            'FINANCE HEAD',
            'https://www.instagram.com/justdeba/',
          ),
          SizedBox(
            width: 12,
          ),
          getBoardPic(
            'assets/img/board/shaswat_srivastava.jpg',
            'SHASWAT SRIVASTAVA',
            'PROJECTS DIRECTOR',
            'https://www.linkedin.com/in/shaswat-srivastava/',
          ),
          SizedBox(
            width: 12,
          ),
          getBoardPic(
            'assets/img/board/rachit_agarwal.jpg',
            'RACHIT AGGARWAL',
            'DESIGN & MEDIA DIRECTOR  ',
            'https://www.instagram.com/rachit_agarwal1512/',
          ),
          SizedBox(
            width: 12,
          ),
          getBoardPic(
            'assets/img/board/raghav_jhavar.jpg',
            'RAGHAV JHAVAR',
            'PUBLICITY & MARKETING DIRECTOR    ',
            'https://www.instagram.com/raghavjhawar02/',
          ),
          SizedBox(
            width: 12,
          ),
          getBoardPic(
            'assets/img/board/yash_meherotra.jpg',
            'YASH MEHEROTRA',
            'TECH ADVISOR',
            'https://www.linkedin.com/in/yashmehrotra9/',
          ),
          SizedBox(
            width: 12,
          ),
          getBoardPic(
            'assets/img/board/kunal_kumar.jpg',
            'KUNAL KUMAR',
            'LOGISTICS DIRECTOR',
            'https://www.instagram.com/kunal.kumar19/',
          ),
          SizedBox(
            width: 20,
          ),
        ],
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
