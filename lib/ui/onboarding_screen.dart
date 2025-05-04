import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcome_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: IntroductionScreen(
          pages: _getPages(),
          onDone: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const WelcomeScreen()),
            );
          },
          showSkipButton: true,
          skip: Text("Skip", style: GoogleFonts.poppins(color: Colors.white70)),
          next: const Icon(Icons.arrow_forward, color: Colors.white),
          done: Text("Get Started",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.lightBlueAccent,
            color: Colors.white24,
            spacing: const EdgeInsets.symmetric(horizontal: 4.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          globalBackgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  List<PageViewModel> _getPages() {
    return [
      _buildPage(
        icon: Icons.code,
        title: "Welcome to CodeSense.ai",
        body: "Your companion for powerful static code analysis using AI.",
      ),
      _buildPage(
        icon: Icons.upload_file,
        title: "Upload Your Code",
        body:
            "Support for Dart, Python, Java & JS. Upload and get started instantly.",
      ),
      _buildPage(
        icon: Icons.analytics_outlined,
        title: "Get Deep Insights",
        body:
            "Understand code issues, get suggestions, and improve code quality.",
      ),
      // _buildPage(
      //   icon: Icons.picture_as_pdf,
      //   title: "Download as PDF",
      //   body: "Get a professional AI report in one click.",
      // ),
    ];
  }

  PageViewModel _buildPage({
    required IconData icon,
    required String title,
    required String body,
  }) {
    return PageViewModel(
      titleWidget: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      bodyWidget: Text(
        body,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.white70,
        ),
      ),
      image: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Icon(icon, size: 80, color: Colors.lightBlueAccent),
        ),
      ),
      decoration: const PageDecoration(
        pageColor: Colors.transparent,
        imagePadding: EdgeInsets.all(24),
        contentMargin: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
