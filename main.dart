
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const RouterControlApp());
}

class RouterControlApp extends StatelessWidget {
  const RouterControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تحكم الراوتر',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

// ============= GLOBAL STATE =============
class RouterConfig {
  static String ip = '192.168.1.1';
  static String username = '';
  static String password = '';
  static String model = 'ZTE_H188N';
  static String backendUrl = 'http://localhost:8000';
}

// ============= API SERVICE =============
class ApiService {
  static String get baseUrl => RouterConfig.backendUrl;

  static Future<Map<String, dynamic>> login() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'ip': RouterConfig.ip,
          'username': RouterConfig.username,
          'password': RouterConfig.password,
          'model': RouterConfig.model,
        }),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }

  static Future<Map<String, dynamic>> getWiFiSettings() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/wifi?ip=${RouterConfig.ip}&username=${RouterConfig.username}&password=${RouterConfig.password}&model=${RouterConfig.model}'),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {};
    }
  }

  static Future<Map<String, dynamic>> setWiFiSettings(Map<String, dynamic> settings) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/wifi?ip=${RouterConfig.ip}&username=${RouterConfig.username}&password=${RouterConfig.password}&model=${RouterConfig.model}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(settings),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  static Future<List<dynamic>> getDevices() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/devices?ip=${RouterConfig.ip}&username=${RouterConfig.username}&password=${RouterConfig.password}&model=${RouterConfig.model}'),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return [];
    }
  }

  static Future<Map<String, dynamic>> blockDevice(String mac) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/block?ip=${RouterConfig.ip}&username=${RouterConfig.username}&password=${RouterConfig.password}&model=${RouterConfig.model}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mac_address': mac}),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false};
    }
  }

  static Future<Map<String, dynamic>> unblockDevice(String mac) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/unblock?ip=${RouterConfig.ip}&username=${RouterConfig.username}&password=${RouterConfig.password}&model=${RouterConfig.model}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mac_address': mac}),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false};
    }
  }

  static Future<List<dynamic>> getBlockedDevices() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/blocked?ip=${RouterConfig.ip}&username=${RouterConfig.username}&password=${RouterConfig.password}&model=${RouterConfig.model}'),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return [];
    }
  }
}

// ============= LOGIN SCREEN =============
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _ipController = TextEditingController(text: '192.168.1.1');
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedModel = 'ZTE_H188N';
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade900, Colors.blue.shade600],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.router,
                      size: 80,
                      color: Colors.blue.shade700,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'تحكم الراوتر',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'WE - ZTE H188N / Huawei HG531',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 24),

                    DropdownButtonFormField<String>(
                      value: _selectedModel,
                      decoration: InputDecoration(
                        labelText: 'نوع الراوتر',
                        prefixIcon: const Icon(Icons.settings),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'ZTE_H188N',
                          child: Text('ZTE H188N (WE)'),
                        ),
                        DropdownMenuItem(
                          value: 'Huawei_HG531',
                          child: Text('Huawei HG531'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedModel = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: _ipController,
                      decoration: InputDecoration(
                        labelText: 'عنوان IP الراوتر',
                        hintText: '192.168.1.1',
                        prefixIcon: const Icon(Icons.computer),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'اسم المستخدم',
                        hintText: 'admin',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_ipController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      _showError('يرجى ملء جميع الحقول');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    RouterConfig.ip = _ipController.text;
    RouterConfig.username = _usernameController.text;
    RouterConfig.password = _passwordController.text;
    RouterConfig.model = _selectedModel;

    final result = await ApiService.login();

    setState(() {
      _isLoading = false;
    });

    if (result['success'] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else {
      _showError(result['message'] ?? 'فشل تسجيل الدخول');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// ============= DASHBOARD SCREEN =============
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const WiFiScreen(),
    const DevicesScreen(),
    const BlockedScreen(),
  ];

  final List<String> _titles = [
    'إعدادات الواي فاي',
    'الأجهزة المتصلة',
    'قائمة الحظر',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.wifi),
            label: 'الواي فاي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: 'الأجهزة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.block),
            label: 'الحظر',
          ),
        ],
      ),
    );
  }
}

// ============= WIFI SCREEN =============
class WiFiScreen extends StatefulWidget {
  const WiFiScreen({super.key});

  @override
  State<WiFiScreen> createState() => _WiFiScreenState();
}

class _WiFiScreenState extends State<WiFiScreen> {
  final _ssidController = TextEditingController();
  final _passwordController = TextEditingController();
  final _channelController = TextEditingController();
  String _encryption = 'WPA2-PSK';
  bool _isLoading = true;
  bool _isSaving = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _loadWiFiSettings();
  }

  Future<void> _loadWiFiSettings() async {
    final settings = await ApiService.getWiFiSettings();
    setState(() {
      _ssidController.text = settings['ssid'] ?? '';
      _passwordController.text = settings['password'] ?? '';
      _channelController.text = settings['channel']?.toString() ?? '6';
      _encryption = settings['encryption'] ?? 'WPA2-PSK';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.wifi, color: Colors.blue.shade700, size: 32),
                  const SizedBox(width: 12),
                  Text(
                    'إعدادات شبكة الواي فاي',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ],
              ),
              const Divider(height: 32),

              TextField(
                controller: _ssidController,
                decoration: InputDecoration(
                  labelText: 'اسم الشبكة (SSID)',
                  prefixIcon: const Icon(Icons.network_wifi),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'كلمة مرور الواي فاي',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _channelController,
                decoration: InputDecoration(
                  labelText: 'القناة (Channel)',
                  prefixIcon: const Icon(Icons.tune),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _encryption,
                decoration: InputDecoration(
                  labelText: 'نوع التشفير',
                  prefixIcon: const Icon(Icons.security),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'WPA2-PSK',
                    child: Text('WPA2-PSK (موصى به)'),
                  ),
                  DropdownMenuItem(
                    value: 'WPA-PSK',
                    child: Text('WPA-PSK'),
                  ),
                  DropdownMenuItem(
                    value: 'WEP',
                    child: Text('WEP (ضعيف)'),
                  ),
                  DropdownMenuItem(
                    value: 'None',
                    child: Text('بدون تشفير (غير آمن)'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _encryption = value!;
                  });
                },
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _isSaving ? null : _saveSettings,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.save),
                  label: Text(
                    _isSaving ? 'جاري الحفظ...' : 'حفظ الإعدادات',
                    style: const TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveSettings() async {
    setState(() {
      _isSaving = true;
    });

    final settings = {
      'ssid': _ssidController.text,
      'password': _passwordController.text,
      'channel': int.tryParse(_channelController.text) ?? 6,
      'encryption': _encryption,
      'hidden': false,
    };

    final result = await ApiService.setWiFiSettings(settings);

    setState(() {
      _isSaving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result['success'] == true
              ? 'تم حفظ الإعدادات بنجاح'
              : 'فشل حفظ الإعدادات',
        ),
        backgroundColor: result['success'] == true ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// ============= DEVICES SCREEN =============
class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  List<dynamic> _devices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  Future<void> _loadDevices() async {
    final devices = await ApiService.getDevices();
    setState(() {
      _devices = devices;
      _isLoading = false;
    });
  }

  Future<void> _blockDevice(String mac, String name) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحظر'),
        content: Text('هل تريد حظر الجهاز: $name؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حظر', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final result = await ApiService.blockDevice(mac);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result['success'] == true
                ? 'تم حظر الجهاز بنجاح'
                : 'فشل حظر الجهاز',
          ),
          backgroundColor: result['success'] == true ? Colors.green : Colors.red,
        ),
      );
      _loadDevices();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_devices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.devices_off, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'لا توجد أجهزة متصلة',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadDevices,
              icon: const Icon(Icons.refresh),
              label: const Text('تحديث'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadDevices,
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          final device = _devices[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Icon(
                  Icons.smartphone,
                  color: Colors.blue.shade700,
                ),
              ),
              title: Text(
                device['name'] ?? 'جهاز غير معروف',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('IP: ${device['ip_address'] ?? 'غير معروف'}'),
                  Text('MAC: ${device['mac_address'] ?? 'غير معروف'}'),
                  Text(
                    'الحالة: ${device['status'] ?? 'متصل'}',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.block, color: Colors.red),
                onPressed: () => _blockDevice(
                  device['mac_address'] ?? '',
                  device['name'] ?? 'جهاز غير معروف',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============= BLOCKED SCREEN =============
class BlockedScreen extends StatefulWidget {
  const BlockedScreen({super.key});

  @override
  State<BlockedScreen> createState() => _BlockedScreenState();
}

class _BlockedScreenState extends State<BlockedScreen> {
  List<dynamic> _blockedDevices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBlockedDevices();
  }

  Future<void> _loadBlockedDevices() async {
    final devices = await ApiService.getBlockedDevices();
    setState(() {
      _blockedDevices = devices;
      _isLoading = false;
    });
  }

  Future<void> _unblockDevice(String mac, String name) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد إلغاء الحظر'),
        content: Text('هل تريد إلغاء حظر الجهاز: $name؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('إلغاء الحظر', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final result = await ApiService.unblockDevice(mac);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result['success'] == true
                ? 'تم إلغاء الحظر بنجاح'
                : 'فشل إلغاء الحظر',
          ),
          backgroundColor: result['success'] == true ? Colors.green : Colors.red,
        ),
      );
      _loadBlockedDevices();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_blockedDevices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 80, color: Colors.green.shade400),
            const SizedBox(height: 16),
            Text(
              'لا توجد أجهزة محظورة',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadBlockedDevices,
              icon: const Icon(Icons.refresh),
              label: const Text('تحديث'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadBlockedDevices,
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _blockedDevices.length,
        itemBuilder: (context, index) {
          final device = _blockedDevices[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red.shade100,
                child: Icon(
                  Icons.block,
                  color: Colors.red.shade700,
                ),
              ),
              title: Text(
                device['name'] ?? 'جهاز غير معروف',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'MAC: ${device['mac_address'] ?? 'غير معروف'}',
              ),
              trailing: ElevatedButton.icon(
                onPressed: () => _unblockDevice(
                  device['mac_address'] ?? '',
                  device['name'] ?? 'جهاز غير معروف',
                ),
                icon: const Icon(Icons.check_circle, size: 18),
                label: const Text('إلغاء الحظر'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
