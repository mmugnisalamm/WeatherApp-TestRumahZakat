import 'package:flutter/material.dart';
import 'package:weather_app/config/constant.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget(
      {super.key,
      required this.title,
      required this.message,
      required this.isLoading});

  final String title;
  final String message;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Container(
        color: Colors.black54, // Warna latar belakang untuk membuat efek gelap
        child: Center(
          child: Dialog(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: colorPrimary,
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/logo_vektor3.png',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 30),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontFamily: 'PoppinsBold',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(width: 5),
                      Text(
                        message,
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ), // Tambahkan widget loading indicator di sini
        ),
      ),
    );
  }
}
