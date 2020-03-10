import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'changepass.dart';
import '../providers/auth.dart';

class EssentialsScreen extends StatelessWidget {
  String getInitials(String name) {
    String initials = '';
    initials = name[0];
    for (var i = 0; i < name.length; i++) {
      if (name[i] == ' ') {
        initials += name[i + 1];
        break;
      }
    }
    initials = initials.toUpperCase();
    return initials;
  }

  void _launch() async {
    const url = 'https://goo.gl/maps/mfYjXTH365RehE3XA';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Color(0xFF030D18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  'PROFILE',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: _launch,
                child: Image.asset(
                  'assets/img/others/map.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'MY INFO',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'SFProTextSemiMed',
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 5,
              ),

              Container(
                height: 80,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  color: Color(0xFF072031),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xff3284ff),
                      child: Text(
                        getInitials(
                            Provider.of<Auth>(context, listen: false).name),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'SFProTextSemiMed',
                            color: Colors.white),
                      ),
                    ),
                    title: Text(
                      Provider.of<Auth>(context, listen: false).name ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'SFProTextSemiMed',
                      ),
                    ),
                    subtitle: Text(
                      Provider.of<Auth>(context, listen: false).userTypeText ??
                          '',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SFProTextSemiLight',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   'QR CODE',
              //   style: TextStyle(
              //     fontSize: 14,
              //     fontFamily: 'SFProTextSemiMed',
              //     color: Colors.grey,
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Center(
              //   child: Container(
              //     margin: EdgeInsets.symmetric(horizontal: 20),
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(10),
              //       child: QrImage(
              //         padding: EdgeInsets.all(30),
              //         data: Provider.of<Auth>(context, listen: false).email,
              //         backgroundColor: Color(0xFF072031),
              //         foregroundColor: Colors.white,
              //         embeddedImage: AssetImage('assets/img/others/qrlogo.png'),
              //         embeddedImageStyle: QrEmbeddedImageStyle(
              //           size: Size(40, 45),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: RaisedButton(
                    color: Color(0xff3284ff),
                    textColor: Colors.white,
                    child: Text(
                      'CHANGE PASSWORD',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SFProTextSemiMed',
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePass(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: RaisedButton(
                    color: Color(0xff3284ff),
                    textColor: Colors.white,
                    child: Text(
                      'LOGOUT',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SFProTextSemiMed',
                      ),
                    ),
                    onPressed: () async {
                      await Provider.of<Auth>(context, listen: false).logout();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
