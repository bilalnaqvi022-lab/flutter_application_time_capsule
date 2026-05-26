// ignore_for_file: unused_element_parameter

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const TimeCapsuleApp());
}

// ─────────────────────────────────────────
//  THEME & CONSTANTS
// ─────────────────────────────────────────
class AppColors {
  static const bg = Color(0xFF070B18);
  static const surface = Color(0xFF0F1628);
  static const card = Color(0xFF141E35);
  static const amber = Color(0xFFE8A94D);
  static const amberLight = Color(0xFFF5C842);
  static const purple = Color(0xFF7B5EA7);
  static const purpleLight = Color(0xFFAA84DB);
  static const rose = Color(0xFFE8617A);
  static const teal = Color(0xFF4ECDC4);
  static const cream = Color(0xFFF5F0E8);
  static const textSub = Color(0xFF8A93AA);
  static const border = Color(0xFF1E2D4A);
  static const starGlow = Color(0xFFFFD700);
}

// ─────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────
enum CapsuleStatus { locked, unlocked, scheduled }
enum UnlockType { date, location, both }

class Capsule {
  final String id;
  final String title;
  final String message;
  final String recipient;
  final bool isSelf;
  final DateTime createdAt;
  final DateTime unlockAt;
  final CapsuleStatus status;
  final UnlockType unlockType;
  final String emoji;
  final Color color;
  final String? location;

  Capsule({
    required this.id,
    required this.title,
    required this.message,
    required this.recipient,
    required this.isSelf,
    required this.createdAt,
    required this.unlockAt,
    required this.status,
    required this.unlockType,
    required this.emoji,
    required this.color,
    this.location,
  });
}

// ─────────────────────────────────────────
//  SAMPLE DATA
// ─────────────────────────────────────────
final List<Capsule> sampleCapsules = [
  Capsule(
    id: '1',
    title: 'To My Future Self',
    message:
        'Hey, I hope you\'ve achieved everything we set out to do. Remember how nervous you were starting this journey? Look how far you\'ve come. Keep dreaming big — the stars are still waiting for you.',
    recipient: 'Yourself',
    isSelf: true,
    createdAt: DateTime(2024, 1, 15),
    unlockAt: DateTime(2026, 1, 15),
    status: CapsuleStatus.locked,
    unlockType: UnlockType.date,
    emoji: '🌟',
    color: AppColors.amber,
  ),
  Capsule(
    id: '2',
    title: 'Our Friendship Milestone',
    message:
        'Sarah, by the time you read this, we\'ll have been best friends for 10 years! I want to tell you how much your laughter, support, and crazy adventures have meant to me.',
    recipient: 'Sarah Ahmed',
    isSelf: false,
    createdAt: DateTime(2024, 3, 20),
    unlockAt: DateTime(2025, 3, 20),
    status: CapsuleStatus.unlocked,
    unlockType: UnlockType.date,
    emoji: '💫',
    color: AppColors.purpleLight,
  ),
  Capsule(
    id: '3',
    title: 'Graduation Day Memory',
    message:
        'I\'m writing this the night before graduation. My hands are shaking with excitement. Open this when you\'re standing at the spot where we took our first photo on campus.',
    recipient: 'Yourself',
    isSelf: true,
    createdAt: DateTime(2024, 5, 10),
    unlockAt: DateTime(2027, 5, 10),
    status: CapsuleStatus.locked,
    unlockType: UnlockType.location,
    emoji: '🎓',
    color: AppColors.teal,
    location: 'University Campus, Karachi',
  ),
  Capsule(
    id: '4',
    title: 'New Year\'s Dream',
    message:
        'I promised myself three things this year. Have I kept them? The courage to begin was always the hardest part. Now I just need the wisdom to continue.',
    recipient: 'Yourself',
    isSelf: true,
    createdAt: DateTime(2025, 1, 1),
    unlockAt: DateTime(2026, 1, 1),
    status: CapsuleStatus.scheduled,
    unlockType: UnlockType.date,
    emoji: '🎆',
    color: AppColors.rose,
  ),
  Capsule(
    id: '5',
    title: 'Dad\'s Birthday Surprise',
    message:
        'Baba, I wrote this a year ago because I always forget to say the important things in the moment. Thank you for being my anchor.',
    recipient: 'Dad',
    isSelf: false,
    createdAt: DateTime(2025, 2, 14),
    unlockAt: DateTime(2026, 2, 14),
    status: CapsuleStatus.locked,
    unlockType: UnlockType.date,
    emoji: '❤️',
    color: AppColors.rose,
  ),
];

// ─────────────────────────────────────────
//  APP ROOT
// ─────────────────────────────────────────
class TimeCapsuleApp extends StatelessWidget {
  const TimeCapsuleApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Capsule',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bg,
        fontFamily: 'serif',
        colorScheme: const ColorScheme.dark(
          primary: AppColors.amber,
          secondary: AppColors.purpleLight,
          surface: AppColors.surface,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ─────────────────────────────────────────
//  SPLASH SCREEN
// ─────────────────────────────────────────
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _ringCtrl;
  late AnimationController _fadeCtrl;
  late AnimationController _pulseCtrl;
  late Animation<double> _ring1, _ring2, _ring3, _fade, _pulse, _logoFade;

  @override
  void initState() {
    super.initState();

    _ringCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _ring1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _ringCtrl,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut)));
    _ring2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _ringCtrl,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut)));
    _ring3 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _ringCtrl,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut)));
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _ringCtrl,
        curve: const Interval(0.3, 0.8, curve: Curves.easeIn)));
    _fade = Tween<double>(begin: 1.0, end: 0.0).animate(_fadeCtrl);
    _pulse = Tween<double>(begin: 0.95, end: 1.05).animate(
        CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _ringCtrl.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 1200), () {
        _fadeCtrl.forward().then((_) {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const OnboardingScreen(),
                transitionDuration: Duration.zero,
              ),
            );
          }
        });
      });
    });
  }

  @override
  void dispose() {
    _ringCtrl.dispose();
    _fadeCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: AnimatedBuilder(
        animation: Listenable.merge([_ringCtrl, _fadeCtrl, _pulseCtrl]),
        builder: (context, _) {
          return Opacity(
            opacity: _fade.value,
            child: Stack(
              children: [
                const StarfieldBackground(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Ring 3 (outermost)
                            Opacity(
                              opacity: _ring3.value * 0.3,
                              child: Transform.scale(
                                scale: 0.5 + _ring3.value * 0.5,
                                child: Container(
                                  width: 190,
                                  height: 190,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.amber.withOpacity(0.4),
                                        width: 1),
                                  ),
                                ),
                              ),
                            ),
                            // Ring 2
                            Opacity(
                              opacity: _ring2.value * 0.5,
                              child: Transform.scale(
                                scale: 0.5 + _ring2.value * 0.5,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.amber.withOpacity(0.6),
                                        width: 1.5),
                                  ),
                                ),
                              ),
                            ),
                            // Ring 1
                            Opacity(
                              opacity: _ring1.value,
                              child: Transform.scale(
                                scale: 0.5 + _ring1.value * 0.5,
                                child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.amber, width: 2),
                                    gradient: RadialGradient(
                                      colors: [
                                        AppColors.amber.withOpacity(0.15),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Logo icon
                            Opacity(
                              opacity: _logoFade.value,
                              child: Transform.scale(
                                scale: _pulse.value,
                                child: Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.amber.withOpacity(0.12),
                                    border: Border.all(
                                        color: AppColors.amber, width: 2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.amber.withOpacity(0.4),
                                        blurRadius: 20,
                                        spreadRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text('⏳',
                                        style: TextStyle(fontSize: 32)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      Opacity(
                        opacity: _logoFade.value,
                        child: Column(
                          children: [
                            Text(
                              'TIME CAPSULE',
                              style: TextStyle(
                                color: AppColors.cream,
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 6,
                                shadows: [
                                  Shadow(
                                    color: AppColors.amber.withOpacity(0.5),
                                    blurRadius: 12,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Messages across time',
                              style: TextStyle(
                                color: AppColors.textSub,
                                fontSize: 13,
                                letterSpacing: 2.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────
//  STARFIELD BACKGROUND
// ─────────────────────────────────────────
class StarfieldBackground extends StatefulWidget {
  const StarfieldBackground({super.key});
  @override
  State<StarfieldBackground> createState() => _StarfieldBackgroundState();
}

class _StarfieldBackgroundState extends State<StarfieldBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final List<_Star> _stars = [];
  final Random _rnd = Random(42);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 80; i++) {
      _stars.add(_Star(
        x: _rnd.nextDouble(),
        y: _rnd.nextDouble(),
        size: _rnd.nextDouble() * 2 + 0.5,
        opacity: _rnd.nextDouble() * 0.6 + 0.2,
        twinkleOffset: _rnd.nextDouble() * 2 * pi,
      ));
    }
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) => CustomPaint(
        painter: _StarPainter(_stars, _ctrl.value),
        child: Container(),
      ),
      child: Container(),
    );
  }
}

class _Star {
  final double x, y, size, opacity, twinkleOffset;
  _Star(
      {required this.x,
      required this.y,
      required this.size,
      required this.opacity,
      required this.twinkleOffset});
}

class _StarPainter extends CustomPainter {
  final List<_Star> stars;
  final double t;
  _StarPainter(this.stars, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    for (final s in stars) {
      final twinkle =
          (sin(t * 2 * pi + s.twinkleOffset) * 0.3 + 0.7).clamp(0.0, 1.0);
      final paint = Paint()
        ..color = AppColors.cream.withOpacity(s.opacity * twinkle)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
          Offset(s.x * size.width, s.y * size.height), s.size, paint);
    }
  }

  @override
  bool shouldRepaint(_StarPainter oldDelegate) => oldDelegate.t != t;
}

// ─────────────────────────────────────────
//  ONBOARDING SCREEN
// ─────────────────────────────────────────
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _ctrl = PageController();
  int _page = 0;

  final _pages = [
    _OnboardPage(
      emoji: '✉️',
      title: 'Write to Your\nFuture Self',
      subtitle:
          'Seal your thoughts, dreams, and goals inside a digital capsule. Let your future self discover who you used to be.',
      gradient: [AppColors.amber, Color(0xFFC17B2E)],
    ),
    _OnboardPage(
      emoji: '🔐',
      title: 'Lock Until\nthe Moment',
      subtitle:
          'Set time-based or location-based locks. Your message opens exactly when — and where — it\'s meant to.',
      gradient: [AppColors.purpleLight, AppColors.purple],
    ),
    _OnboardPage(
      emoji: '💌',
      title: 'Surprise\nYour Loved Ones',
      subtitle:
          'Schedule a birthday memory, an anniversary wish, or a secret note for someone who matters. Let time deliver your love.',
      gradient: [AppColors.rose, Color(0xFFA84060)],
    ),
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < _pages.length - 1) {
      _ctrl.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
    } else {
      Navigator.of(context).pushReplacement(
        _slideRoute(const AuthScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          const StarfieldBackground(),
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _ctrl,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemCount: _pages.length,
                  itemBuilder: (ctx, i) =>
                      _OnboardPageView(data: _pages[i], active: _page == i),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
                child: Column(
                  children: [
                    // Dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: i == _page ? 24 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: i == _page
                                ? AppColors.amber
                                : AppColors.border,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    GestureDetector(
                      onTap: _next,
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _pages[_page].gradient[0],
                              _pages[_page].gradient[1],
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  _pages[_page].gradient[0].withOpacity(0.35),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            _page == _pages.length - 1
                                ? 'GET STARTED'
                                : 'CONTINUE',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_page < _pages.length - 1) ...[
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushReplacement(
                            _slideRoute(const AuthScreen())),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: AppColors.textSub,
                            fontSize: 14,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OnboardPage {
  final String emoji, title, subtitle;
  final List<Color> gradient;
  _OnboardPage(
      {required this.emoji,
      required this.title,
      required this.subtitle,
      required this.gradient});
}

class _OnboardPageView extends StatefulWidget {
  final _OnboardPage data;
  final bool active;
  const _OnboardPageView({required this.data, required this.active});
  @override
  State<_OnboardPageView> createState() => _OnboardPageViewState();
}

class _OnboardPageViewState extends State<_OnboardPageView>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade, _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fade =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<double>(begin: 30, end: 0).animate(CurvedAnimation(
        parent: _ctrl, curve: Curves.easeOut));
    if (widget.active) _ctrl.forward();
  }

  @override
  void didUpdateWidget(_OnboardPageView old) {
    super.didUpdateWidget(old);
    if (widget.active && !old.active) {
      _ctrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (ctx, _) => Padding(
        padding: const EdgeInsets.fromLTRB(32, 60, 32, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: _fade.value,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    widget.data.gradient[0].withOpacity(0.2),
                    Colors.transparent,
                  ]),
                  border: Border.all(
                    color: widget.data.gradient[0].withOpacity(0.5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.data.gradient[0].withOpacity(0.25),
                      blurRadius: 24,
                      spreadRadius: 4,
                    )
                  ],
                ),
                child: Center(
                  child:
                      Text(widget.data.emoji, style: const TextStyle(fontSize: 44)),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Transform.translate(
              offset: Offset(0, _slide.value),
              child: Opacity(
                opacity: _fade.value,
                child: Text(
                  widget.data.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.cream,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    shadows: [
                      Shadow(
                        color: widget.data.gradient[0].withOpacity(0.4),
                        blurRadius: 12,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Transform.translate(
              offset: Offset(0, _slide.value * 0.6),
              child: Opacity(
                opacity: _fade.value,
                child: Text(
                  widget.data.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSub,
                    fontSize: 15,
                    height: 1.65,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  AUTH SCREEN
// ─────────────────────────────────────────
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isLogin = true;
  bool _loading = false;
  late TabController _tabCtrl;
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
    _tabCtrl.addListener(() => setState(() => _isLogin = _tabCtrl.index == 0));
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (mounted) {
      Navigator.of(context).pushReplacement(_slideRoute(const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          const StarfieldBackground(),
          // Ambient glow
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  AppColors.amber.withOpacity(0.08),
                  Colors.transparent,
                ]),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: AppColors.amber, width: 1.5),
                            color: AppColors.amber.withOpacity(0.08),
                          ),
                          child: const Center(
                              child: Text('⏳', style: TextStyle(fontSize: 28))),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'TIME CAPSULE',
                          style: TextStyle(
                            color: AppColors.cream,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 4,
                            shadows: [
                              Shadow(
                                  color: AppColors.amber.withOpacity(0.4),
                                  blurRadius: 8)
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('Messages across time',
                            style: TextStyle(
                                color: AppColors.textSub,
                                fontSize: 12,
                                letterSpacing: 2)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        // Tab bar
                        Container(
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.bg,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TabBar(
                            controller: _tabCtrl,
                            indicator: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                AppColors.amber,
                                Color(0xFFC17B2E),
                              ]),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: AppColors.textSub,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                              fontSize: 12,
                            ),
                            dividerColor: Colors.transparent,
                            tabs: const [
                              Tab(text: 'SIGN IN'),
                              Tab(text: 'SIGN UP'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Column(
                              children: [
                                if (!_isLogin) ...[
                                  const SizedBox(height: 12),
                                  _AuthField(
                                    ctrl: _nameCtrl,
                                    label: 'Full Name',
                                    icon: Icons.person_outline,
                                  ),
                                ],
                                const SizedBox(height: 12),
                                _AuthField(
                                  ctrl: _emailCtrl,
                                  label: 'Email Address',
                                  icon: Icons.mail_outline,
                                  keyboard: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 12),
                                _AuthField(
                                  ctrl: _passCtrl,
                                  label: 'Password',
                                  icon: Icons.lock_outline,
                                  obscure: _obscure,
                                  suffix: GestureDetector(
                                    onTap: () =>
                                        setState(() => _obscure = !_obscure),
                                    child: Icon(
                                      _obscure
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: AppColors.textSub,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                if (_isLogin) ...[
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Forgot password?',
                                        style: TextStyle(
                                            color: AppColors.amber,
                                            fontSize: 12)),
                                  ),
                                ],
                                const SizedBox(height: 24),
                                GestureDetector(
                                  onTap: _loading ? null : _submit,
                                  child: Container(
                                    width: double.infinity,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [
                                        AppColors.amber,
                                        Color(0xFFC17B2E),
                                      ]),
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              AppColors.amber.withOpacity(0.3),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: _loading
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2),
                                            )
                                          : Text(
                                              _isLogin
                                                  ? 'ENTER THE VAULT'
                                                  : 'CREATE ACCOUNT',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      'By continuing, you agree to our Terms & Privacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.textSub.withOpacity(0.6),
                          fontSize: 11),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final IconData icon;
  final TextInputType? keyboard;
  final bool obscure;
  final Widget? suffix;

  const _AuthField({
    required this.ctrl,
    required this.label,
    required this.icon,
    this.keyboard,
    this.obscure = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboard,
      obscureText: obscure,
      style: TextStyle(color: AppColors.cream, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.textSub, fontSize: 13),
        prefixIcon: Icon(icon, color: AppColors.textSub, size: 18),
        suffixIcon: suffix != null
            ? Padding(padding: const EdgeInsets.only(right: 8), child: suffix)
            : null,
        filled: true,
        fillColor: AppColors.bg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.amber),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  HOME SCREEN (Shell)
// ─────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  final _screens = const [
    VaultScreen(),
    ExploreScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: IndexedStack(index: _tab, children: _screens),
      floatingActionButton: _tab == 0
          ? GestureDetector(
              onTap: () => Navigator.of(context).push(_slideRoute(
                  const CreateCapsuleScreen())),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.amber, Color(0xFFC17B2E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.amber.withOpacity(0.4),
                      blurRadius: 16,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 28),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 60,
            child: Row(
              children: [
                _NavItem(
                    icon: Icons.inventory_2_outlined,
                    activeIcon: Icons.inventory_2,
                    label: 'Vault',
                    active: _tab == 0,
                    onTap: () => setState(() => _tab = 0)),
                _NavItem(
                    icon: Icons.explore_outlined,
                    activeIcon: Icons.explore,
                    label: 'Explore',
                    active: _tab == 1,
                    onTap: () => setState(() => _tab = 1)),
                _NavItem(
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    label: 'Profile',
                    active: _tab == 2,
                    onTap: () => setState(() => _tab = 2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon, activeIcon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              active ? activeIcon : icon,
              color: active ? AppColors.amber : AppColors.textSub,
              size: 22,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: active ? AppColors.amber : AppColors.textSub,
                fontSize: 10,
                fontWeight:
                    active ? FontWeight.w600 : FontWeight.w400,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  VAULT SCREEN
// ─────────────────────────────────────────
class VaultScreen extends StatefulWidget {
  const VaultScreen({super.key});
  @override
  State<VaultScreen> createState() => _VaultScreenState();
}

class _VaultScreenState extends State<VaultScreen> {
  String _filter = 'All';
  final _filters = ['All', 'Locked', 'Unlocked', 'Scheduled'];

  List<Capsule> get _filtered {
    if (_filter == 'All') return sampleCapsules;
    return sampleCapsules.where((c) {
      switch (_filter) {
        case 'Locked':
          return c.status == CapsuleStatus.locked;
        case 'Unlocked':
          return c.status == CapsuleStatus.unlocked;
        case 'Scheduled':
          return c.status == CapsuleStatus.scheduled;
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          const StarfieldBackground(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Vault',
                              style: TextStyle(
                                color: AppColors.cream,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                shadows: [
                                  Shadow(
                                      color: AppColors.amber.withOpacity(0.3),
                                      blurRadius: 8)
                                ],
                              ),
                            ),
                            Text(
                              '${sampleCapsules.length} capsules sealed',
                              style: TextStyle(
                                  color: AppColors.textSub, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.surface,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Icon(Icons.notifications_outlined,
                            color: AppColors.textSub, size: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Stats row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      _StatChip(
                          label: 'Locked',
                          count: sampleCapsules
                              .where((c) => c.status == CapsuleStatus.locked)
                              .length,
                          color: AppColors.amber),
                      const SizedBox(width: 10),
                      _StatChip(
                          label: 'Open',
                          count: sampleCapsules
                              .where((c) => c.status == CapsuleStatus.unlocked)
                              .length,
                          color: AppColors.teal),
                      const SizedBox(width: 10),
                      _StatChip(
                          label: 'Scheduled',
                          count: sampleCapsules
                              .where((c) => c.status == CapsuleStatus.scheduled)
                              .length,
                          color: AppColors.purpleLight),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Filter chips
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: _filters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (ctx, i) {
                      final sel = _filters[i] == _filter;
                      return GestureDetector(
                        onTap: () => setState(() => _filter = _filters[i]),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: sel
                                ? AppColors.amber
                                : AppColors.surface,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: sel
                                  ? AppColors.amber
                                  : AppColors.border,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _filters[i],
                              style: TextStyle(
                                color: sel ? Colors.white : AppColors.textSub,
                                fontSize: 12,
                                fontWeight: sel
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Capsule list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 80),
                    itemCount: _filtered.length,
                    itemBuilder: (ctx, i) => _CapsuleCard(
                      capsule: _filtered[i],
                      onTap: () => Navigator.of(context).push(
                          _slideRoute(CapsuleDetailScreen(capsule: _filtered[i]))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _StatChip(
      {required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          children: [
            Text('$count',
                style: TextStyle(
                    color: color,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
            Text(label,
                style: TextStyle(color: AppColors.textSub, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  CAPSULE CARD
// ─────────────────────────────────────────
class _CapsuleCard extends StatefulWidget {
  final Capsule capsule;
  final VoidCallback onTap;
  const _CapsuleCard({required this.capsule, required this.onTap});
  @override
  State<_CapsuleCard> createState() => _CapsuleCardState();
}

class _CapsuleCardState extends State<_CapsuleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverCtrl;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _hoverCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
  }

  @override
  void dispose() {
    _hoverCtrl.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) =>
      '${d.day} ${_months[d.month - 1]} ${d.year}';
  final _months = [
    'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
  ];

  String get _statusLabel {
    switch (widget.capsule.status) {
      case CapsuleStatus.locked:
        return 'LOCKED';
      case CapsuleStatus.unlocked:
        return 'OPEN';
      case CapsuleStatus.scheduled:
        return 'SCHEDULED';
    }
  }

  Color get _statusColor {
    switch (widget.capsule.status) {
      case CapsuleStatus.locked:
        return AppColors.amber;
      case CapsuleStatus.unlocked:
        return AppColors.teal;
      case CapsuleStatus.scheduled:
        return AppColors.purpleLight;
    }
  }

  IconData get _statusIcon {
    switch (widget.capsule.status) {
      case CapsuleStatus.locked:
        return Icons.lock_outline;
      case CapsuleStatus.unlocked:
        return Icons.lock_open_outlined;
      case CapsuleStatus.scheduled:
        return Icons.schedule_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: widget.capsule.color.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              children: [
                // Color accent line
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          widget.capsule.color,
                          widget.capsule.color.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 14, 16, 14),
                  child: Row(
                    children: [
                      // Emoji badge
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: widget.capsule.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: widget.capsule.color.withOpacity(0.3)),
                        ),
                        child: Center(
                          child: Text(widget.capsule.emoji,
                              style: const TextStyle(fontSize: 22)),
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.capsule.title,
                                    style: TextStyle(
                                      color: AppColors.cream,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: _statusColor.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: _statusColor.withOpacity(0.3)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(_statusIcon,
                                          color: _statusColor, size: 10),
                                      const SizedBox(width: 3),
                                      Text(
                                        _statusLabel,
                                        style: TextStyle(
                                          color: _statusColor,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.capsule.status == CapsuleStatus.unlocked
                                  ? widget.capsule.message
                                  : '••••••••••••••••••••••••••',
                              style: TextStyle(
                                color: widget.capsule.status ==
                                        CapsuleStatus.unlocked
                                    ? AppColors.textSub
                                    : AppColors.textSub.withOpacity(0.4),
                                fontSize: 12,
                                height: 1.4,
                                letterSpacing: widget.capsule.status ==
                                        CapsuleStatus.unlocked
                                    ? 0
                                    : 2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.person_outline,
                                    color: AppColors.textSub.withOpacity(0.6),
                                    size: 11),
                                const SizedBox(width: 3),
                                Text(
                                  widget.capsule.recipient,
                                  style: TextStyle(
                                      color: AppColors.textSub.withOpacity(0.7),
                                      fontSize: 11),
                                ),
                                const Spacer(),
                                Icon(Icons.calendar_today_outlined,
                                    color: AppColors.textSub.withOpacity(0.6),
                                    size: 11),
                                const SizedBox(width: 3),
                                Text(
                                  _formatDate(widget.capsule.unlockAt),
                                  style: TextStyle(
                                      color: AppColors.textSub.withOpacity(0.7),
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  CAPSULE DETAIL SCREEN
// ─────────────────────────────────────────
class CapsuleDetailScreen extends StatefulWidget {
  final Capsule capsule;
  const CapsuleDetailScreen({super.key, required this.capsule});
  @override
  State<CapsuleDetailScreen> createState() => _CapsuleDetailScreenState();
}

class _CapsuleDetailScreenState extends State<CapsuleDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade, _scale;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _fade =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: _ctrl, curve: Curves.easeOut));
    _scale = Tween<double>(begin: 0.92, end: 1).animate(CurvedAnimation(
        parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
    if (widget.capsule.status == CapsuleStatus.unlocked) {
      _revealed = true;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) =>
      '${d.day} ${_months[d.month - 1]} ${d.year}';
  final _months = [
    'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
  ];

  // ignore: unused_element
  Duration get _timeLeft {
    return widget.capsule.unlockAt.difference(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          const StarfieldBackground(),
          // Color orb
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  widget.capsule.color.withOpacity(0.12),
                  Colors.transparent,
                ]),
              ),
            ),
          ),
          SafeArea(
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (ctx, _) => Opacity(
                opacity: _fade.value,
                child: Transform.scale(
                  scale: _scale.value,
                  child: Column(
                    children: [
                      // App bar
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: AppColors.border),
                                ),
                                child: const Icon(Icons.arrow_back,
                                    color: AppColors.cream, size: 18),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Capsule Detail',
                              style: TextStyle(
                                color: AppColors.cream,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Icon(Icons.share_outlined,
                                  color: AppColors.textSub, size: 18),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              // Capsule hero
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(28),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      widget.capsule.color.withOpacity(0.15),
                                      AppColors.card,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: widget.capsule.color.withOpacity(0.3),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: widget.capsule.color
                                            .withOpacity(0.12),
                                        border: Border.all(
                                          color: widget.capsule.color
                                              .withOpacity(0.4),
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: widget.capsule.color
                                                .withOpacity(0.3),
                                            blurRadius: 20,
                                          )
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(widget.capsule.emoji,
                                            style: const TextStyle(fontSize: 36)),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      widget.capsule.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.cream,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'To: ${widget.capsule.recipient}',
                                      style: TextStyle(
                                          color: widget.capsule.color,
                                          fontSize: 13),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _DetailBadge(
                                          icon: Icons.create_outlined,
                                          label: 'Created',
                                          value: _formatDate(
                                              widget.capsule.createdAt),
                                        ),
                                        Container(
                                            width: 1,
                                            height: 36,
                                            color: AppColors.border),
                                        _DetailBadge(
                                          icon: Icons.lock_clock_outlined,
                                          label: 'Opens',
                                          value: _formatDate(
                                              widget.capsule.unlockAt),
                                          highlight: widget.capsule.color,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Countdown (if locked)
                              if (widget.capsule.status !=
                                  CapsuleStatus.unlocked) ...[
                                _CountdownWidget(
                                    unlockAt: widget.capsule.unlockAt,
                                    color: widget.capsule.color),
                                const SizedBox(height: 20),
                              ],

                              // Condition info
                              _InfoCard(
                                title: 'Unlock Condition',
                                content: widget.capsule.unlockType ==
                                        UnlockType.date
                                    ? 'Unlocks on ${_formatDate(widget.capsule.unlockAt)}'
                                    : widget.capsule.unlockType ==
                                            UnlockType.location
                                        ? 'Unlocks at: ${widget.capsule.location}'
                                        : 'Unlocks on date & at location',
                                icon: widget.capsule.unlockType ==
                                        UnlockType.date
                                    ? Icons.calendar_month_outlined
                                    : Icons.location_on_outlined,
                                color: widget.capsule.color,
                              ),
                              const SizedBox(height: 14),

                              // Message
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppColors.card,
                                  borderRadius: BorderRadius.circular(18),
                                  border:
                                      Border.all(color: AppColors.border),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.message_outlined,
                                            color: AppColors.textSub,
                                            size: 16),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Message',
                                          style: TextStyle(
                                            color: AppColors.textSub,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        const Spacer(),
                                        if (widget.capsule.status !=
                                            CapsuleStatus.unlocked)
                                          GestureDetector(
                                            onTap: () => setState(
                                                () => _revealed = !_revealed),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: widget.capsule.color
                                                    .withOpacity(0.12),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: widget.capsule.color
                                                        .withOpacity(0.3)),
                                              ),
                                              child: Text(
                                                _revealed ? 'HIDE' : 'PEEK',
                                                style: TextStyle(
                                                  color: widget.capsule.color,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 14),
                                    AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: _revealed
                                          ? Text(
                                              widget.capsule.message,
                                              key: const ValueKey('revealed'),
                                              style: TextStyle(
                                                color: AppColors.cream
                                                    .withOpacity(0.9),
                                                fontSize: 14,
                                                height: 1.7,
                                              ),
                                            )
                                          : Text(
                                              '••••••••••••••••••••••\n•••••••••••••\n••••••••••••••••••',
                                              key: const ValueKey('hidden'),
                                              style: TextStyle(
                                                color: AppColors.textSub
                                                    .withOpacity(0.3),
                                                fontSize: 14,
                                                height: 1.7,
                                                letterSpacing: 4,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailBadge extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color? highlight;
  const _DetailBadge(
      {required this.icon,
      required this.label,
      required this.value,
      this.highlight});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: highlight ?? AppColors.textSub, size: 16),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(color: AppColors.textSub, fontSize: 10)),
        const SizedBox(height: 2),
        Text(value,
            style: TextStyle(
                color: highlight ?? AppColors.cream,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title, content;
  final IconData icon;
  final Color color;
  const _InfoCard(
      {required this.title,
      required this.content,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: AppColors.textSub,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(content,
                    style: TextStyle(color: AppColors.cream, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownWidget extends StatefulWidget {
  final DateTime unlockAt;
  final Color color;
  const _CountdownWidget({required this.unlockAt, required this.color});
  @override
  State<_CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<_CountdownWidget> {
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = widget.unlockAt.difference(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours.remainder(24);
    final mins = _remaining.inMinutes.remainder(60);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: widget.color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text('Time Until Unlock',
              style: TextStyle(
                  color: AppColors.textSub,
                  fontSize: 11,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TimeUnit(value: days, label: 'DAYS', color: widget.color),
              _TimeDivider(color: widget.color),
              _TimeUnit(value: hours, label: 'HRS', color: widget.color),
              _TimeDivider(color: widget.color),
              _TimeUnit(value: mins, label: 'MIN', color: widget.color),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeUnit extends StatelessWidget {
  final int value;
  final String label;
  final Color color;
  const _TimeUnit(
      {required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value.toString().padLeft(2, '0'),
          style: TextStyle(
            color: color,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        Text(label,
            style:
                TextStyle(color: AppColors.textSub, fontSize: 9, letterSpacing: 1)),
      ],
    );
  }
}

class _TimeDivider extends StatelessWidget {
  final Color color;
  const _TimeDivider({required this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(':',
          style: TextStyle(
              color: color.withOpacity(0.5),
              fontSize: 28,
              fontWeight: FontWeight.w700)),
    );
  }
}

// ─────────────────────────────────────────
//  CREATE CAPSULE SCREEN
// ─────────────────────────────────────────
class CreateCapsuleScreen extends StatefulWidget {
  const CreateCapsuleScreen({super.key});
  @override
  State<CreateCapsuleScreen> createState() => _CreateCapsuleScreenState();
}

class _CreateCapsuleScreenState extends State<CreateCapsuleScreen> {
  int _step = 0;
  final _titleCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  final _recipCtrl = TextEditingController();
  bool _toSelf = true;
  String _emoji = '⏳';
  Color _color = AppColors.amber;
  UnlockType _unlockType = UnlockType.date;
  DateTime _unlockDate = DateTime.now().add(const Duration(days: 365));
  String _location = '';

  final _emojis = ['⏳', '🌟', '💌', '🎓', '❤️', '🎆', '💫', '🌙', '🔮', '🦋'];
  final _colors = [
    AppColors.amber,
    AppColors.purpleLight,
    AppColors.teal,
    AppColors.rose,
    Color(0xFF4A9EFF),
    Color(0xFF52D97B),
  ];

  final _steps = ['Details', 'Message', 'Unlock', 'Review'];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _msgCtrl.dispose();
    _recipCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_step < _steps.length - 1) {
      setState(() => _step++);
    } else {
      _submit();
    }
  }

  void _submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.surface,
        content: Row(
          children: [
            Text(_emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Text('Capsule sealed successfully! 🔐',
                style: TextStyle(color: AppColors.cream)),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          const StarfieldBackground(),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _step > 0
                            ? setState(() => _step--)
                            : Navigator.of(context).pop(),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Icon(
                            _step > 0 ? Icons.arrow_back : Icons.close,
                            color: AppColors.cream,
                            size: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'New Capsule',
                            style: TextStyle(
                              color: AppColors.cream,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Step indicator
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: List.generate(_steps.length, (i) {
                      final done = i < _step;
                      final active = i == _step;
                      return Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: done || active
                                          ? AppColors.amber
                                          : AppColors.border,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _steps[i],
                                    style: TextStyle(
                                      color: active
                                          ? AppColors.amber
                                          : done
                                              ? AppColors.amber.withOpacity(0.6)
                                              : AppColors.textSub,
                                      fontSize: 10,
                                      fontWeight: active
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (i < _steps.length - 1)
                              const SizedBox(width: 4),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 24),

                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, anim) => SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(0.05, 0), end: Offset.zero)
                          .animate(anim),
                      child: FadeTransition(opacity: anim, child: child),
                    ),
                    child: _buildStep(),
                  ),
                ),

                // Bottom button
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: GestureDetector(
                    onTap: _next,
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [_color, _color.withOpacity(0.7)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: _color.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _step < _steps.length - 1
                              ? 'NEXT →'
                              : '🔐  SEAL CAPSULE',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return _StepDetails(
          key: const ValueKey(0),
          titleCtrl: _titleCtrl,
          recipCtrl: _recipCtrl,
          toSelf: _toSelf,
          selectedEmoji: _emoji,
          selectedColor: _color,
          emojis: _emojis,
          colors: _colors,
          onToSelfChanged: (v) => setState(() => _toSelf = v),
          onEmojiChanged: (e) => setState(() => _emoji = e),
          onColorChanged: (c) => setState(() => _color = c),
        );
      case 1:
        return _StepMessage(
          key: const ValueKey(1),
          msgCtrl: _msgCtrl,
          color: _color,
        );
      case 2:
        return _StepUnlock(
          key: const ValueKey(2),
          unlockType: _unlockType,
          unlockDate: _unlockDate,
          location: _location,
          color: _color,
          onTypeChanged: (t) => setState(() => _unlockType = t),
          onDateChanged: (d) => setState(() => _unlockDate = d),
          onLocationChanged: (l) => setState(() => _location = l),
        );
      case 3:
        return _StepReview(
          key: const ValueKey(3),
          title: _titleCtrl.text.isEmpty ? 'Untitled Capsule' : _titleCtrl.text,
          message: _msgCtrl.text.isEmpty ? '(no message yet)' : _msgCtrl.text,
          recipient: _toSelf
              ? 'Yourself'
              : (_recipCtrl.text.isEmpty ? 'Friend' : _recipCtrl.text),
          emoji: _emoji,
          color: _color,
          unlockType: _unlockType,
          unlockDate: _unlockDate,
          location: _location,
        );
      default:
        return const SizedBox();
    }
  }
}

class _StepDetails extends StatelessWidget {
  final TextEditingController titleCtrl, recipCtrl;
  final bool toSelf;
  final String selectedEmoji;
  final Color selectedColor;
  final List<String> emojis;
  final List<Color> colors;
  final ValueChanged<bool> onToSelfChanged;
  final ValueChanged<String> onEmojiChanged;
  final ValueChanged<Color> onColorChanged;

  const _StepDetails({
    super.key,
    required this.titleCtrl,
    required this.recipCtrl,
    required this.toSelf,
    required this.selectedEmoji,
    required this.selectedColor,
    required this.emojis,
    required this.colors,
    required this.onToSelfChanged,
    required this.onEmojiChanged,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('What\'s this capsule for?',
              style: TextStyle(
                  color: AppColors.cream,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),

          // To self / friend toggle
          Row(
            children: [
              _ToggleBtn(
                label: '✉️  To Myself',
                active: toSelf,
                color: selectedColor,
                onTap: () => onToSelfChanged(true),
              ),
              const SizedBox(width: 10),
              _ToggleBtn(
                label: '💌  To a Friend',
                active: !toSelf,
                color: selectedColor,
                onTap: () => onToSelfChanged(false),
              ),
            ],
          ),
          const SizedBox(height: 18),

          if (!toSelf) ...[
            _CreateField(ctrl: recipCtrl, label: 'Recipient Name or Email'),
            const SizedBox(height: 14),
          ],
          _CreateField(ctrl: titleCtrl, label: 'Capsule Title'),
          const SizedBox(height: 20),

          Text('Choose an icon',
              style:
                  TextStyle(color: AppColors.textSub, fontSize: 12, letterSpacing: 1)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: emojis
                .map((e) => GestureDetector(
                      onTap: () => onEmojiChanged(e),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: e == selectedEmoji
                              ? selectedColor.withOpacity(0.15)
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: e == selectedEmoji
                                ? selectedColor
                                : AppColors.border,
                            width: e == selectedEmoji ? 2 : 1,
                          ),
                        ),
                        child: Center(
                            child: Text(e, style: const TextStyle(fontSize: 22))),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),

          Text('Choose a color',
              style:
                  TextStyle(color: AppColors.textSub, fontSize: 12, letterSpacing: 1)),
          const SizedBox(height: 10),
          Row(
            children: colors
                .map((c) => GestureDetector(
                      onTap: () => onColorChanged(c),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 10),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: c,
                          shape: BoxShape.circle,
                          border: c == selectedColor
                              ? Border.all(color: Colors.white, width: 2.5)
                              : null,
                          boxShadow: c == selectedColor
                              ? [
                                  BoxShadow(
                                      color: c.withOpacity(0.5),
                                      blurRadius: 8)
                                ]
                              : null,
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _ToggleBtn extends StatelessWidget {
  final String label;
  final bool active;
  final Color color;
  final VoidCallback onTap;
  const _ToggleBtn(
      {required this.label,
      required this.active,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? color.withOpacity(0.12) : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border:
                Border.all(color: active ? color : AppColors.border),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: active ? color : AppColors.textSub,
                fontWeight:
                    active ? FontWeight.w600 : FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateField extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final int? maxLines;
  const _CreateField(
      {required this.ctrl, required this.label, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      style: TextStyle(color: AppColors.cream, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.textSub, fontSize: 13),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.amber),
        ),
      ),
    );
  }
}

class _StepMessage extends StatelessWidget {
  final TextEditingController msgCtrl;
  final Color color;
  const _StepMessage({super.key, required this.msgCtrl, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Write your message',
              style: TextStyle(
                  color: AppColors.cream,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text('This will be sealed until the capsule unlocks.',
              style: TextStyle(color: AppColors.textSub, fontSize: 13)),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: TextField(
                controller: msgCtrl,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: TextStyle(
                    color: AppColors.cream, fontSize: 15, height: 1.7),
                decoration: InputDecoration(
                  hintText:
                      'Dear future self,\n\nI want you to know that...',
                  hintStyle: TextStyle(
                      color: AppColors.textSub.withOpacity(0.5), fontSize: 14),
                  contentPadding: const EdgeInsets.all(18),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.lock_outline, color: AppColors.textSub, size: 13),
              const SizedBox(width: 4),
              Text(
                'End-to-end encrypted',
                style: TextStyle(color: AppColors.textSub, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepUnlock extends StatelessWidget {
  final UnlockType unlockType;
  final DateTime unlockDate;
  final String location;
  final Color color;
  final ValueChanged<UnlockType> onTypeChanged;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<String> onLocationChanged;

  const _StepUnlock({
    super.key,
    required this.unlockType,
    required this.unlockDate,
    required this.location,
    required this.color,
    required this.onTypeChanged,
    required this.onDateChanged,
    required this.onLocationChanged,
  });

  String _fmt(DateTime d) =>
      '${d.day} ${['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][d.month-1]} ${d.year}';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Unlock Condition',
              style: TextStyle(
                  color: AppColors.cream,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text('Choose when or where this capsule can be opened.',
              style: TextStyle(color: AppColors.textSub, fontSize: 13)),
          const SizedBox(height: 20),

          _UnlockOption(
            icon: Icons.calendar_month_outlined,
            title: 'Date & Time',
            subtitle: 'Unlock on a specific date',
            selected: unlockType == UnlockType.date,
            color: color,
            onTap: () => onTypeChanged(UnlockType.date),
          ),
          const SizedBox(height: 10),
          _UnlockOption(
            icon: Icons.location_on_outlined,
            title: 'Location',
            subtitle: 'Unlock when you arrive somewhere',
            selected: unlockType == UnlockType.location,
            color: color,
            onTap: () => onTypeChanged(UnlockType.location),
          ),
          const SizedBox(height: 10),
          _UnlockOption(
            icon: Icons.tune_outlined,
            title: 'Both',
            subtitle: 'Date + Location must both match',
            selected: unlockType == UnlockType.both,
            color: color,
            onTap: () => onTypeChanged(UnlockType.both),
          ),
          const SizedBox(height: 24),

          if (unlockType != UnlockType.location) ...[
            Text('Unlock Date',
                style: TextStyle(
                    color: AppColors.textSub,
                    fontSize: 12,
                    letterSpacing: 1)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: unlockDate,
                  firstDate: DateTime.now().add(const Duration(days: 1)),
                  lastDate: DateTime.now().add(const Duration(days: 365 * 50)),
                  builder: (ctx, child) => Theme(
                    data: ThemeData.dark().copyWith(
                      colorScheme: ColorScheme.dark(primary: color),
                    ),
                    child: child!,
                  ),
                );
                if (picked != null) onDateChanged(picked);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: color, size: 16),
                    const SizedBox(width: 10),
                    Text(_fmt(unlockDate),
                        style: TextStyle(
                            color: AppColors.cream,
                            fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Icon(Icons.edit_outlined, color: AppColors.textSub, size: 14),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          if (unlockType != UnlockType.date) ...[
            Text('Location',
                style: TextStyle(
                    color: AppColors.textSub,
                    fontSize: 12,
                    letterSpacing: 1)),
            const SizedBox(height: 8),
            TextField(
              onChanged: onLocationChanged,
              style: TextStyle(color: AppColors.cream, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Enter a place name or address',
                hintStyle:
                    TextStyle(color: AppColors.textSub.withOpacity(0.5)),
                prefixIcon: Icon(Icons.search, color: AppColors.textSub, size: 18),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: color),
                ),
              ),
            ),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _UnlockOption extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _UnlockOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.08) : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: selected ? color : AppColors.border,
              width: selected ? 1.5 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: selected
                    ? color.withOpacity(0.15)
                    : AppColors.bg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon,
                  color: selected ? color : AppColors.textSub, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: selected ? color : AppColors.cream,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  Text(subtitle,
                      style: TextStyle(
                          color: AppColors.textSub, fontSize: 12)),
                ],
              ),
            ),
            if (selected)
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 12),
              ),
          ],
        ),
      ),
    );
  }
}

class _StepReview extends StatelessWidget {
  final String title, message, recipient, emoji, location;
  final Color color;
  final UnlockType unlockType;
  final DateTime unlockDate;

  const _StepReview({
    super.key,
    required this.title,
    required this.message,
    required this.recipient,
    required this.emoji,
    required this.color,
    required this.unlockType,
    required this.unlockDate,
    required this.location,
  });

  String _fmt(DateTime d) =>
      '${d.day} ${['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][d.month-1]} ${d.year}';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Review & Seal',
              style: TextStyle(
                  color: AppColors.cream,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text('This capsule will be sealed and locked.',
              style: TextStyle(color: AppColors.textSub, fontSize: 13)),
          const SizedBox(height: 24),

          // Preview card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.12), AppColors.card],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 48)),
                const SizedBox(height: 12),
                Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.cream,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                Text('To $recipient',
                    style: TextStyle(color: color, fontSize: 13)),
                const SizedBox(height: 14),
                Divider(color: AppColors.border),
                const SizedBox(height: 14),
                Text(
                  message.length > 100
                      ? '${message.substring(0, 100)}...'
                      : message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.textSub, fontSize: 13, height: 1.6),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: color.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                          unlockType == UnlockType.location
                              ? Icons.location_on_outlined
                              : Icons.lock_clock_outlined,
                          color: color,
                          size: 14),
                      const SizedBox(width: 6),
                      Text(
                        unlockType == UnlockType.location
                            ? (location.isEmpty ? 'Location set' : location)
                            : 'Unlocks ${_fmt(unlockDate)}',
                        style: TextStyle(color: color, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: AppColors.amber.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Text('⚠️', style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Once sealed, the message cannot be edited. Make sure everything looks right.',
                    style: TextStyle(
                        color: AppColors.textSub, fontSize: 12, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
//  EXPLORE SCREEN
// ─────────────────────────────────────────
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          const StarfieldBackground(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Explore',
                          style: TextStyle(
                              color: AppColors.cream,
                              fontSize: 28,
                              fontWeight: FontWeight.w700)),
                      Text('Discover templates & inspiration',
                          style: TextStyle(
                              color: AppColors.textSub, fontSize: 13)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      _SectionTitle('Popular Templates'),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 160,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _TemplateCard(
                              emoji: '🎓',
                              title: 'Graduation Letter',
                              desc: 'Write to your future graduate self',
                              color: AppColors.teal,
                            ),
                            const SizedBox(width: 12),
                            _TemplateCard(
                              emoji: '💍',
                              title: 'Anniversary Surprise',
                              desc: 'A message for your partner',
                              color: AppColors.rose,
                            ),
                            const SizedBox(width: 12),
                            _TemplateCard(
                              emoji: '🌱',
                              title: 'New Year Goals',
                              desc: 'Your promises to yourself',
                              color: AppColors.purpleLight,
                            ),
                            const SizedBox(width: 12),
                            _TemplateCard(
                              emoji: '🧒',
                              title: 'To My Child',
                              desc: 'A timeless parental letter',
                              color: AppColors.amber,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _SectionTitle('How It Works'),
                      const SizedBox(height: 12),
                      _HowItWorksCard(),
                      const SizedBox(height: 24),
                      _SectionTitle('Community Stories'),
                      const SizedBox(height: 12),
                      _StoryCard(
                        avatar: '👩',
                        name: 'Fatima K.',
                        quote:
                            '"I opened my capsule on my 30th birthday. It was from 25-year-old me. I cried for 20 minutes."',
                        time: '3 years ago',
                        color: AppColors.rose,
                      ),
                      const SizedBox(height: 10),
                      _StoryCard(
                        avatar: '👨',
                        name: 'Omar A.',
                        quote:
                            '"Sent a capsule to my best friend for his wedding day. He still talks about it."',
                        time: '1 year ago',
                        color: AppColors.teal,
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: AppColors.cream,
          fontSize: 16,
          fontWeight: FontWeight.w700),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  final String emoji, title, desc;
  final Color color;
  const _TemplateCard(
      {required this.emoji,
      required this.title,
      required this.desc,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.18), AppColors.card],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const Spacer(),
          Text(title,
              style: TextStyle(
                  color: AppColors.cream,
                  fontWeight: FontWeight.w600,
                  fontSize: 13)),
          const SizedBox(height: 3),
          Text(desc,
              style: TextStyle(color: AppColors.textSub, fontSize: 11),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

class _HowItWorksCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final steps = [
      ('✍️', 'Write', 'Compose your heartfelt message'),
      ('🔐', 'Seal', 'Lock it with a date or location'),
      ('📬', 'Receive', 'Open it when the moment arrives'),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: steps.asMap().entries.map((e) {
          final i = e.key;
          final s = e.value;
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(s.$1, style: const TextStyle(fontSize: 24)),
                      const SizedBox(height: 6),
                      Text(s.$2,
                          style: TextStyle(
                              color: AppColors.amber,
                              fontWeight: FontWeight.w600,
                              fontSize: 12)),
                      const SizedBox(height: 2),
                      Text(s.$3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.textSub, fontSize: 10),
                          maxLines: 2),
                    ],
                  ),
                ),
                if (i < steps.length - 1)
                  Icon(Icons.chevron_right,
                      color: AppColors.border, size: 18),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final String avatar, name, quote, time;
  final Color color;
  const _StoryCard(
      {required this.avatar,
      required this.name,
      required this.quote,
      required this.time,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Center(
                    child: Text(avatar, style: const TextStyle(fontSize: 18))),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          color: AppColors.cream,
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                  Text(time,
                      style:
                          TextStyle(color: AppColors.textSub, fontSize: 11)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(quote,
              style: TextStyle(
                  color: AppColors.textSub,
                  fontSize: 13,
                  height: 1.5,
                  fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
//  PROFILE SCREEN
// ─────────────────────────────────────────
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          const StarfieldBackground(),
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  AppColors.purpleLight.withOpacity(0.1),
                  Colors.transparent,
                ]),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.amber, Color(0xFFC17B2E)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.amber.withOpacity(0.35),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: const Center(
                      child: Text('👤', style: TextStyle(fontSize: 38)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text('Hira Malik',
                      style: TextStyle(
                          color: AppColors.cream,
                          fontSize: 22,
                          fontWeight: FontWeight.w700)),
                  Text('hira.malik@email.com',
                      style:
                          TextStyle(color: AppColors.textSub, fontSize: 13)),
                  const SizedBox(height: 24),

                  // Stats
                  Row(
                    children: [
                      _ProfileStat(
                          value: '5',
                          label: 'Capsules',
                          color: AppColors.amber),
                      _ProfileStat(
                          value: '2',
                          label: 'Sent',
                          color: AppColors.teal),
                      _ProfileStat(
                          value: '1',
                          label: 'Opened',
                          color: AppColors.purpleLight),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Settings
                  _SettingsGroup(
                    title: 'Preferences',
                    items: [
                      _SettingsItem(
                          icon: Icons.notifications_outlined,
                          title: 'Notifications',
                          trailing: Switch(
                            value: true,
                            onChanged: (_) {},
                            activeColor: AppColors.amber,
                          )),
                      _SettingsItem(
                          icon: Icons.dark_mode_outlined,
                          title: 'Dark Mode',
                          trailing: Switch(
                            value: true,
                            onChanged: (_) {},
                            activeColor: AppColors.amber,
                          )),
                      _SettingsItem(
                          icon: Icons.language_outlined,
                          title: 'Language',
                          value: 'English'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _SettingsGroup(
                    title: 'Security',
                    items: [
                      _SettingsItem(
                          icon: Icons.lock_outline,
                          title: 'Change Password'),
                      _SettingsItem(
                          icon: Icons.fingerprint,
                          title: 'Biometric Lock',
                          trailing: Switch(
                            value: false,
                            onChanged: (_) {},
                            activeColor: AppColors.amber,
                          )),
                      _SettingsItem(
                          icon: Icons.security_outlined,
                          title: 'Two-Factor Auth'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _SettingsGroup(
                    title: 'About',
                    items: [
                      _SettingsItem(
                          icon: Icons.info_outline,
                          title: 'App Version',
                          value: '1.0.0'),
                      _SettingsItem(
                          icon: Icons.privacy_tip_outlined,
                          title: 'Privacy Policy'),
                      _SettingsItem(
                          icon: Icons.description_outlined,
                          title: 'Terms of Service'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacement(
                        _slideRoute(const AuthScreen())),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.rose.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: AppColors.rose.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout,
                              color: AppColors.rose, size: 18),
                          const SizedBox(width: 8),
                          Text('Sign Out',
                              style: TextStyle(
                                  color: AppColors.rose,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value, label;
  final Color color;
  const _ProfileStat(
      {required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    color: color,
                    fontSize: 22,
                    fontWeight: FontWeight.w700)),
            Text(label,
                style: TextStyle(color: AppColors.textSub, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> items;
  const _SettingsGroup({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(),
            style: TextStyle(
                color: AppColors.textSub,
                fontSize: 11,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: items.asMap().entries.map((e) {
              final isLast = e.key == items.length - 1;
              return Column(
                children: [
                  e.value,
                  if (!isLast) Divider(height: 1, color: AppColors.border),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  final Widget? trailing;
  const _SettingsItem(
      {required this.icon, required this.title, this.value, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSub, size: 18),
          const SizedBox(width: 12),
          Expanded(
              child: Text(title,
                  style: TextStyle(color: AppColors.cream, fontSize: 14))),
          if (value != null)
            Text(value!,
                style: TextStyle(color: AppColors.textSub, fontSize: 13)),
          if (trailing != null) trailing!,
          if (value == null && trailing == null)
            Icon(Icons.chevron_right, color: AppColors.textSub, size: 18),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
//  HELPERS
// ─────────────────────────────────────────
PageRouteBuilder _slideRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (ctx, anim, _, child) {
      return SlideTransition(
        position: Tween<Offset>(
                begin: const Offset(1, 0), end: Offset.zero)
            .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
