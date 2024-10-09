import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startup/feautures/resources/domain/entities/article_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleContent extends StatefulWidget {
  ArticleContent({Key? key, required this.article}) : super(key: key);
  final ArticleEntity article;

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffEEEEEE),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_sharp,
                        color: Color(0xff3A4454),
                        size: 30,
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Text(
                        'Blog Post',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Color(0xff3A4454),
                            letterSpacing: 1,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /////appbar finished


                SizedBox(height: 16,),

                Text(
                  widget.article.title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Color(0xff3A4454),
                        letterSpacing: 1,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 1
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.article.authorImage),
                      ),
                      SizedBox(width: 8,),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.article.authorName,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Color(0xff3A4454),
                                  letterSpacing: 1,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  widget.article.authorAbout,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Color(0xff3A4454),
                      letterSpacing: 1,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(height: 16),
                Text(
                  widget.article.content,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Color(0xff3A4454),
                      letterSpacing: 0.5,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                ),
                SizedBox(height: 16,),

                Row(
                  children: [
                    Icon(Icons.bookmark_add, size: 48, color: Color(0xff27405A),),
                    Spacer(),
                    InkWell(
                      onTap: () async {
                        Uri _url = Uri.parse('https://www.educative.io');
                        if (await launchUrl(_url)) {
                          await launchUrl(_url);
                        } else {
                          throw 'Could not launch $_url';
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            'Visit Blog',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.blue,
                                letterSpacing: 1,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                          ),
                          SizedBox(width: 4,),
                          Icon(Icons.launch, color: Colors.blue,),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
