import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_button.dart';
import '../widgets/forgot_password_sheet.dart';
import 'home_screen.dart';
import '../widgets/logout_sheet.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const LoginScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // State
  bool _isSignUp = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _rememberMe = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _fillDemoCredentials() {
    setState(() {
      _emailController.text = 'Ankit';
      _passwordController.text = 'Password@2026';
      if (_isSignUp) {
        _nameController.text = 'Alex Morgan';
        _confirmPasswordController.text = 'Password@2026';
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.amber, size: 18),
            SizedBox(width: 10),
            Text('Demo credentials applied!'),
          ],
        ),
        backgroundColor: const Color(0xFF1E293B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _handleDirectLogout(BuildContext context) async {
    final email = _emailController.text.trim().isNotEmpty
        ? _emailController.text.trim()
        : 'Ankit@gmail.com';
    final name = email.contains('@') ? email.split('@')[0] : 'User';

    final result = await LogoutSheet.show(
      context,
      userName: name,
      userEmail: email,
    );

    if (result != null && result['confirmed'] == true && mounted) {
      final bool shouldClearEmail = result['clearEmail'] == true;
      setState(() {
        _passwordController.clear();
        _confirmPasswordController.clear();
        if (shouldClearEmail || !_rememberMe) {
          _emailController.clear();
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'You have been logged out successfully.',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF1E293B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _handleAuthSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate network authentication request
    await Future.delayed(const Duration(milliseconds: 1400));

    if (!mounted) return;
    setState(() => _isLoading = false);

    final email = _emailController.text.trim();
    final name = _isSignUp
        ? _nameController.text.trim()
        : (email.contains('@') ? email.split('@')[0] : 'User');

    // Navigate to Home Dashboard and await logout result
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(
          userEmail: email,
          userName: name,
          onToggleTheme: widget.onToggleTheme,
          isDarkMode: widget.isDarkMode,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
              child: child,
            ),
          );
        },
      ),
    );

    if (result != null && result['confirmed'] == true && mounted) {
      final bool shouldClearEmail = result['clearEmail'] == true;
      setState(() {
        _passwordController.clear();
        _confirmPasswordController.clear();
        if (shouldClearEmail || !_rememberMe) {
          _emailController.clear();
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'You have been logged out successfully.',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF1E293B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _handleSocialAuth(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text('Connecting to $provider...'),
          ],
        ),
        backgroundColor: const Color(0xFF1E293B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background ambient gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: isDark
                  ? AppColors.backgroundGradientDark
                  : const LinearGradient(
                      colors: [Color(0xFFF1F5F9), Color(0xFFE2E8F0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
            ),
          ),

          // Glowing background accent orbs (ambient visual effects)
          if (isDark) ...[
            Positioned(
              top: -80,
              left: -80,
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.18),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.25),
                      blurRadius: 100,
                      spreadRadius: 40,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              right: -60,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary.withOpacity(0.18),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(0.25),
                      blurRadius: 90,
                      spreadRadius: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Theme toggle & Sign out buttons in the top-right corner
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'Sign Out / Clear Session',
                      onPressed: () => _handleDirectLogout(context),
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.error.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.error.withOpacity(0.25),
                          ),
                        ),
                        child: const Icon(
                          Icons.logout_rounded,
                          size: 18,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                      onPressed: widget.onToggleTheme,
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark ? AppColors.borderDark : AppColors.borderLight,
                          ),
                        ),
                        child: Icon(
                          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                          size: 20,
                          color: isDark ? Colors.amber : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Scrollable login card container
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width > 600 ? 32 : 20,
                  vertical: 24,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF131C31).withOpacity(0.85) : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withOpacity(0.4)
                              : Colors.grey.withOpacity(0.15),
                          blurRadius: 30,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(28.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // App Logo and Brand Header
                          _buildBrandHeader(isDark),

                          const SizedBox(height: 24),

                          // Tab switcher between Sign In & Sign Up
                          _buildTabSwitcher(isDark),

                          const SizedBox(height: 16),

                          // Active Session Banner with instant Log Out button
                          _buildActiveSessionBanner(isDark),

                          const SizedBox(height: 12),

                          // Quick Demo Credentials Chip
                          Center(
                            child: InkWell(
                              onTap: _fillDemoCredentials,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.primary.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.bolt_rounded, size: 16, color: AppColors.primaryLight),
                                    SizedBox(width: 6),
                                    Text(
                                      'Auto-Fill Demo Credentials',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryLight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 22),

                          // Full Name (Only in Sign Up mode)
                          if (_isSignUp) ...[
                            CustomTextField(
                              controller: _nameController,
                              label: 'Full Name',
                              hint: 'Alex Morgan',
                              prefixIcon: Icons.person_outline_rounded,
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Please enter your full name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                          ],

                          // Email Address
                          CustomTextField(
                            controller: _emailController,
                            label: 'Email Address',
                            hint: 'Ankit@gmail.com',
                            prefixIcon: Icons.alternate_email_rounded,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val.trim())) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          // Password
                          CustomTextField(
                            controller: _passwordController,
                            label: 'Password',
                            hint: 'Enter your password',
                            prefixIcon: Icons.lock_outline_rounded,
                            isPassword: true,
                            isPasswordVisible: _isPasswordVisible,
                            onTogglePasswordVisibility: () {
                              setState(() => _isPasswordVisible = !_isPasswordVisible);
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (val.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),

                          // Confirm Password (Only in Sign Up mode)
                          if (_isSignUp) ...[
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: _confirmPasswordController,
                              label: 'Confirm Password',
                              hint: 'Re-enter your password',
                              prefixIcon: Icons.lock_reset_rounded,
                              isPassword: true,
                              isPasswordVisible: _isConfirmPasswordVisible,
                              onTogglePasswordVisibility: () {
                                setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
                              },
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (val != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ],

                          const SizedBox(height: 12),

                          // Remember Me & Forgot Password Row
                          if (!_isSignUp) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Checkbox(
                                        value: _rememberMe,
                                        activeColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        onChanged: (val) {
                                          setState(() => _rememberMe = val ?? false);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Remember me',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: isDark
                                            ? AppColors.textSecondaryDark
                                            : AppColors.textSecondaryLight,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () => ForgotPasswordSheet.show(context),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryLight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],

                          const SizedBox(height: 24),

                          // Gradient Submit CTA Button
                          Container(
                            height: 52,
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.4),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleAuthSubmit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _isSignUp ? 'Create Account' : 'Sign In',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                            ),
                          ),

                          const SizedBox(height: 26),

                          // "Or continue with" divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                child: Text(
                                  'or continue with',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark
                                        ? AppColors.textMutedDark
                                        : AppColors.textMutedLight,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Social Logins (Google, Apple, GitHub)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialButton(
                                type: SocialType.google,
                                onPressed: () => _handleSocialAuth('Google'),
                              ),
                              const SizedBox(width: 14),
                              SocialButton(
                                type: SocialType.apple,
                                onPressed: () => _handleSocialAuth('Apple'),
                              ),
                              const SizedBox(width: 14),
                              SocialButton(
                                type: SocialType.github,
                                onPressed: () => _handleSocialAuth('GitHub'),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Switch between Sign In / Sign Up footer
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _isSignUp
                                    ? 'Already have an account?'
                                    : "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight,
                                ),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  setState(() => _isSignUp = !_isSignUp);
                                },
                                child: Text(
                                  _isSignUp ? 'Sign In' : 'Sign Up',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryLight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandHeader(bool isDark) {
    return Column(
      children: [
        // Brand logo icon with glowing gradient border
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.fingerprint_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          _isSignUp ? 'Join Nexus' : 'Welcome back',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _isSignUp
              ? 'Create your free account to get started.'
              : 'Please enter your credentials to access your account.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildTabSwitcher(bool isDark) {
    return Container(
      height: 46,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.inputBgDark : AppColors.inputBgLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_isSignUp) setState(() => _isSignUp = false);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: !_isSignUp
                      ? (isDark ? AppColors.cardDark : Colors.white)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: !_isSignUp
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: !_isSignUp ? FontWeight.bold : FontWeight.w500,
                    color: !_isSignUp
                        ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)
                        : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!_isSignUp) setState(() => _isSignUp = true);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: _isSignUp
                      ? (isDark ? AppColors.cardDark : Colors.white)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: _isSignUp
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: _isSignUp ? FontWeight.bold : FontWeight.w500,
                    color: _isSignUp
                        ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)
                        : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSessionBanner(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.25),
        ),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.primary.withOpacity(0.2),
                child: const Text(
                  'A',
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark ? const Color(0xFF131C31) : Colors.white,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Alex Morgan (Active)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Ankit@gmail.com',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: () => _handleDirectLogout(context),
            icon: const Icon(Icons.logout_rounded, size: 13),
            label: const Text('Log Out', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error, width: 1.2),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
