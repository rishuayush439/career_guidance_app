import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'career_paths_page.dart' as career_paths;
import 'skill_development_page.dart' as skill_development;
import 'get_guidance_page.dart';
import 'ChatbotPage.dart';
import 'splash_screen.dart';
import 'auth/login_page.dart';
import 'auth/signup_page.dart';
import 'package:career_guidance_app/firebase_options.dart';
import 'CodingChallengePage.dart';
import 'trackProgress.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

const GEMINI_API_KEY = 'AIzaSyCAY18Eg1Uxuc6cJSGG9EF7OI4vSV8CmLg';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Gemini.init(apiKey: GEMINI_API_KEY);
  runApp(const CareerGuidanceApp());
}

class CareerGuidanceApp extends StatelessWidget {
  const CareerGuidanceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Career Guidance App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/careerPaths': (context) => const career_paths.CareerPathsPage(),
        '/skillDevelopment': (context) =>
            const skill_development.SkillDevelopmentPage(),
        '/getGuidance': (context) => const GetGuidancePage(),
        '/chatbot': (context) => const ChatbotPage(),
        '/challenge': (context) => const CodingChallengePage(),
        '/trackProgress': (context) => const TrackProgressPage(),
      },
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you really want to exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFF1E1E2E),
        appBar: AppBar(
          backgroundColor: const Color(0xFF6A00F4),
          elevation: 0,
          title: const Text(
            'Career Guidance',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () => _logout(context),
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _controller,
              child: const Column(
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Explore careers, develop skills, and get guidance.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildFeatureCard(
                      context,
                      title: 'Career Paths',
                      icon: Icons.search,
                      gradient: const [Color(0xFF6A00F4), Color(0xFFAB00FF)],
                      onTap: () {
                        Navigator.pushNamed(context, '/careerPaths');
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      context,
                      title: 'Test Your Skill',
                      icon: Icons.build,
                      gradient: const [Color(0xFF00C6FF), Color(0xFF0072FF)],
                      onTap: () {
                        Navigator.pushNamed(context, '/skillDevelopment');
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      context,
                      title: 'Get Guidance',
                      icon: Icons.help_outline,
                      gradient: const[Color(0xFFFF4B2B), Color(0xFFFF416C)],
                      onTap: () {
                        Navigator.pushNamed(context, '/getGuidance');
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      context,
                      title: 'AI Guide',
                      icon: Icons.chat_bubble_outline,
                      gradient: const [Color(0xFF11998E), Color(0xFF38EF7D)],
                      onTap: () {
                        Navigator.pushNamed(context, '/chatbot');
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradient.last.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white.withOpacity(0.2),
              child: Icon(icon, size: 28, color: Colors.white),
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.white),
          ],
        ),
      ),
    );
  }
}






