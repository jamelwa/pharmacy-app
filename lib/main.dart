import 'package:flutter/material.dart';

void main() {
  runApp(const ApotekSehatPlusApp());
}

class ApotekSehatPlusApp extends StatelessWidget {
  const ApotekSehatPlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apotek SehatPlus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green),
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      home: const AppShell(),
    );
  }
}

class AppColors {
  static const green = Color(0xFF16A85F);
  static const darkGreen = Color(0xFF087444);
  static const softGreen = Color(0xFFEAF8F0);
  static const background = Color(0xFFF7F8F7);
  static const text = Color(0xFF17251E);
  static const muted = Color(0xFF7A8982);
  static const line = Color(0xFFE7ECE9);
  static const orange = Color(0xFFF6A21A);
  static const blue = Color(0xFF3B82F6);
  static const purple = Color(0xFF8B5CF6);
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  final _pages = const [
    HomePage(),
    CategoryPage(),
    PrescriptionPage(),
    OrdersPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth > 430
                ? 430.0
                : constraints.maxWidth;
            return Center(
              child: SizedBox(
                width: width,
                height: constraints.maxHeight,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: _pages[_index],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: _index,
        onChanged: (index) => setState(() => _index = index),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const ValueKey('home'),
      slivers: const [
        SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverToBoxAdapter(child: _AppHeader()),
        SliverToBoxAdapter(child: _GreetingBlock()),
        SliverToBoxAdapter(child: _SearchBox()),
        SliverToBoxAdapter(child: _PrescriptionBanner()),
        SliverToBoxAdapter(child: _FeatureGrid()),
        SliverToBoxAdapter(child: _RewardCards()),
        SliverToBoxAdapter(child: _ServiceStrip()),
        SliverToBoxAdapter(child: SizedBox(height: 92)),
      ],
    );
  }
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      const _Category(
        'Obat Demam',
        'Paracetamol, ibuprofen',
        Icons.thermostat,
        AppColors.green,
      ),
      const _Category(
        'Vitamin',
        'Imunitas & suplemen',
        Icons.sunny,
        AppColors.orange,
      ),
      const _Category(
        'Alat Kesehatan',
        'Masker, tensimeter, test kit',
        Icons.health_and_safety,
        AppColors.blue,
      ),
      const _Category(
        'Personal Care',
        'Perawatan harian',
        Icons.spa,
        AppColors.purple,
      ),
      const _Category(
        'Ibu & Anak',
        'Kebutuhan keluarga',
        Icons.child_care,
        AppColors.green,
      ),
      const _Category(
        'Obat Resep',
        'Perlu validasi apoteker',
        Icons.receipt_long,
        AppColors.orange,
      ),
    ];

    return _PageScaffold(
      key: const ValueKey('category'),
      title: 'Kategori',
      subtitle: 'Temukan produk kesehatan yang kamu butuhkan',
      child: Column(
        children: [
          const _SearchBox(compact: true),
          const SizedBox(height: 18),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (_, index) =>
                _CategoryCard(category: categories[index]),
          ),
          const SizedBox(height: 18),
          const _SectionTitle(title: 'Produk populer', action: 'Lihat semua'),
          const SizedBox(height: 12),
          const _ProductRow(
            name: 'Paracetamol 500mg',
            meta: 'Fever relief',
            price: 'Rp 12.000',
          ),
          const _ProductRow(
            name: 'Vitamin D3 1000 IU',
            meta: 'Suplemen harian',
            price: 'Rp 58.000',
          ),
          const _ProductRow(
            name: 'Masker Medis 3 Ply',
            meta: 'Personal care',
            price: 'Rp 24.000',
          ),
        ],
      ),
    );
  }
}

class PrescriptionPage extends StatelessWidget {
  const PrescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _PageScaffold(
      key: const ValueKey('prescription'),
      title: 'Resep',
      subtitle: 'Upload resep dan pantau validasi apoteker',
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.green, Color(0xFF1CCB78)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.upload_file_rounded,
                  color: Colors.white,
                  size: 34,
                ),
                const SizedBox(height: 14),
                const Text(
                  'Upload resep dokter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Apoteker akan memvalidasi resep, cek masa berlaku, lalu bantu proses pesanan.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .88),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: () => _openDetail(
                    context,
                    'Upload Resep',
                    Icons.upload_file_rounded,
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.add_photo_alternate_rounded),
                  label: const Text(
                    'Pilih foto resep',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _StatusCard(
            icon: Icons.verified_rounded,
            title: 'RX-2041 tervalidasi',
            subtitle: 'Resep hipertensi sudah disetujui apoteker',
            badge: 'Siap beli',
          ),
          const _StatusCard(
            icon: Icons.schedule_rounded,
            title: 'Refill Vitamin D3',
            subtitle: 'Jadwalkan pengingat refill bulanan',
            badge: '2 hari lagi',
          ),
          const _StatusCard(
            icon: Icons.medical_information_rounded,
            title: 'Catatan interaksi obat',
            subtitle: 'Cek efek samping dan interaksi sebelum checkout',
            badge: 'Info',
          ),
        ],
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _PageScaffold(
      key: const ValueKey('orders'),
      title: 'Pesanan',
      subtitle: 'Lacak pengiriman dan riwayat pembelian',
      child: Column(
        children: const [
          _DeliveryTracker(),
          SizedBox(height: 18),
          _SectionTitle(title: 'Riwayat pesanan', action: 'Filter'),
          SizedBox(height: 12),
          _OrderHistoryCard(
            id: 'ORD-8891',
            status: 'Dalam pengiriman',
            total: 'Rp 94.000',
          ),
          _OrderHistoryCard(
            id: 'ORD-8870',
            status: 'Selesai',
            total: 'Rp 156.000',
          ),
          _OrderHistoryCard(
            id: 'ORD-8812',
            status: 'Pickup point',
            total: 'Rp 38.000',
          ),
        ],
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _PageScaffold(
      key: const ValueKey('account'),
      title: 'Akun',
      subtitle: 'Profil, loyalty, voucher, dan bantuan',
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColors.line),
            ),
            child: Row(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: AppColors.softGreen,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: AppColors.green,
                    size: 34,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rani Putri',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: AppColors.text,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Member SehatPlus Gold',
                        style: TextStyle(
                          color: AppColors.muted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const _RewardCards(dense: true),
          const SizedBox(height: 16),
          const _MenuTile(
            icon: Icons.settings_rounded,
            title: 'Pengaturan profil',
            subtitle: 'Alamat, telepon, preferensi',
          ),
          const _MenuTile(
            icon: Icons.assignment_rounded,
            title: 'Riwayat resep',
            subtitle: 'Lihat semua resep tersimpan',
          ),
          const _MenuTile(
            icon: Icons.card_giftcard_rounded,
            title: 'Referral',
            subtitle: 'Ajak teman dan dapatkan poin',
          ),
          const _MenuTile(
            icon: Icons.support_agent_rounded,
            title: 'Pusat bantuan',
            subtitle: 'Live chat, FAQ, dan feedback',
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const DetailPage({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.line),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            color: AppColors.softGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(icon, color: AppColors.green, size: 30),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Ini halaman detail sederhana untuk melanjutkan flow dari mockup. Nanti bisa dikembangkan menjadi form, list produk, chat, atau checkout.',
                          style: TextStyle(
                            color: AppColors.muted,
                            height: 1.45,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const _StatusCard(
                    icon: Icons.check_circle_rounded,
                    title: 'UI flow siap',
                    subtitle: 'Halaman ini sudah terhubung dari home screen.',
                    badge: 'Ready',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppHeader extends StatelessWidget {
  const _AppHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 12, 22, 14),
      child: Row(
        children: [
          const _BrandMark(size: 42),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Apotek\nSehatPlus',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.green,
                fontWeight: FontWeight.w900,
                height: 1.05,
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const _CircleIcon(icon: Icons.notifications_none_rounded),
              Positioned(
                right: -2,
                top: -4,
                child: Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE84141),
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GreetingBlock extends StatelessWidget {
  const _GreetingBlock();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Halo, Rani',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.text,
              fontWeight: FontWeight.w900,
              letterSpacing: -.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                size: 18,
                color: AppColors.green,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  'Kirim ke Jakarta Selatan',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.muted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.muted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  final bool compact;

  const _SearchBox({this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: compact ? 0 : 22),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColors.line),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 14,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: AppColors.muted, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Cari obat, vitamin, produk kesehatan',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.muted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.qr_code_scanner_rounded,
            color: AppColors.green,
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _PrescriptionBanner extends StatelessWidget {
  const _PrescriptionBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.fromLTRB(22, 18, 22, 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF129B58), Color(0xFF1CCB78)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3016A85F),
            blurRadius: 28,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -6,
            bottom: -8,
            child: CustomPaint(
              size: const Size(156, 136),
              painter: _DeliveryIllustrationPainter(),
            ),
          ),
          Positioned(
            right: 86,
            top: 4,
            child: Icon(
              Icons.cloud_rounded,
              color: Colors.white.withValues(alpha: .18),
              size: 42,
            ),
          ),
          Positioned(
            right: 5,
            top: -2,
            child: Icon(
              Icons.cloud_rounded,
              color: Colors.white.withValues(alpha: .13),
              size: 62,
            ),
          ),
          SizedBox(
            width: 206,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upload Resep,\nObat Diantar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    height: 1.04,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Praktis, aman, & terpercaya',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .88),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 42,
                  child: FilledButton(
                    onPressed: () => _openDetail(
                      context,
                      'Upload Resep',
                      Icons.upload_file_rounded,
                    ),
                    style: FilledButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Unggah Resep',
                      style: TextStyle(fontWeight: FontWeight.w900),
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

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid();

  @override
  Widget build(BuildContext context) {
    const features = [
      _Feature('Katalog\nObat', Icons.medication_rounded),
      _Feature('Upload\nResep', Icons.upload_file_rounded),
      _Feature('Cek\nLab', Icons.science_rounded),
      _Feature('Konsultasi\nApoteker', Icons.forum_rounded),
      _Feature('Voucher', Icons.percent_rounded),
      _Feature('Riwayat\nPesanan', Icons.assignment_rounded),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: features.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: .94,
        ),
        itemBuilder: (context, index) => _FeatureTile(feature: features[index]),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final _Feature feature;

  const _FeatureTile({required this.feature});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => _openDetail(
        context,
        feature.label.replaceAll('\n', ' '),
        feature.icon,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.line),
          boxShadow: const [
            BoxShadow(
              color: Color(0x07000000),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.softGreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(feature.icon, color: AppColors.green, size: 24),
              ),
              const SizedBox(height: 10),
              Text(
                feature.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 12,
                  height: 1.12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RewardCards extends StatelessWidget {
  final bool dense;

  const _RewardCards({this.dense = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        dense ? 0 : 22,
        dense ? 0 : 18,
        dense ? 0 : 22,
        0,
      ),
      child: Row(
        children: const [
          Expanded(
            child: _RewardCard(
              icon: Icons.workspace_premium_rounded,
              title: 'Poin SehatPlus',
              value: '2.450',
              subtitle: 'Tukar poin untuk diskon menarik',
              showArrow: true,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _RewardCard(
              icon: Icons.confirmation_number_rounded,
              title: 'Voucher Spesial',
              value: 'Diskon 15%',
              subtitle: 'Min. belanja Rp100.000',
              showArrow: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final bool showArrow;

  const _RewardCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.showArrow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 132),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: AppColors.line),
        boxShadow: const [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 18,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.orange, size: 28),
              const SizedBox(height: 9),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 11,
                  height: 1.25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          if (showArrow)
            const Positioned(
              right: -5,
              top: 38,
              child: Icon(Icons.chevron_right_rounded, color: AppColors.muted),
            ),
        ],
      ),
    );
  }
}

class _ServiceStrip extends StatelessWidget {
  const _ServiceStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(22, 16, 22, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.line),
      ),
      child: const Row(
        children: [
          Expanded(
            child: _ServiceItem(
              icon: Icons.local_shipping_rounded,
              title: 'Gratis Ongkir',
              subtitle: 'Min. belanja Rp50.000',
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            height: 42,
            child: VerticalDivider(color: AppColors.line, width: 1),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _ServiceItem(
              icon: Icons.bolt_rounded,
              title: 'Pengiriman Cepat',
              subtitle: '1–2 jam sampai',
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ServiceItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.softGreen,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.green, size: 20),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const _BottomNav({required this.currentIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.home_rounded, 'Beranda'),
      (Icons.grid_view_rounded, 'Kategori'),
      (Icons.receipt_long_rounded, 'Resep'),
      (Icons.assignment_rounded, 'Pesanan'),
      (Icons.person_rounded, 'Akun'),
    ];

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 22,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Align(
          heightFactor: 1,
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (var i = 0; i < items.length; i++)
                    _NavItem(
                      icon: items[i].$1,
                      label: items[i].$2,
                      active: currentIndex == i,
                      onTap: () => onChanged(i),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.green : const Color(0xFF9BA8A2);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 23),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: active ? FontWeight.w900 : FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _PageScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 92),
      children: [
        const _AppHeader(),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 32,
            height: 1,
            fontWeight: FontWeight.w900,
            letterSpacing: -.6,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.muted,
            fontWeight: FontWeight.w600,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 20),
        child,
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final _Category category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openDetail(context, category.title, category.icon),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: category.color.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(category.icon, color: category.color),
            ),
            const Spacer(),
            Text(
              category.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.text,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  final String name;
  final String meta;
  final String price;

  const _ProductRow({
    required this.name,
    required this.meta,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.softGreen,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.medication_rounded, color: AppColors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  meta,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              color: AppColors.green,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String badge;

  const _StatusCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.softGreen,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    height: 1.25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.softGreen,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                color: AppColors.green,
                fontSize: 11,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliveryTracker extends StatelessWidget {
  const _DeliveryTracker();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkGreen,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ORD-8891 sedang dikirim',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Estimasi tiba 18 menit lagi',
            style: TextStyle(
              color: Colors.white.withValues(alpha: .78),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          for (final step in const [
            ('Resep tervalidasi', true),
            ('Pesanan dikemas', true),
            ('Kurir menuju lokasi', false),
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(
                    step.$2
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: step.$2 ? const Color(0xFF86EFAC) : Colors.white54,
                    size: 21,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    step.$1,
                    style: TextStyle(
                      color: step.$2 ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.w800,
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

class _OrderHistoryCard extends StatelessWidget {
  final String id;
  final String status;
  final String total;

  const _OrderHistoryCard({
    required this.id,
    required this.status,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          const Icon(Icons.shopping_bag_rounded, color: AppColors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  status,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            total,
            style: const TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.softGreen,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: AppColors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String action;

  const _SectionTitle({required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            color: AppColors.green,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;

  const _CircleIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 43,
      height: 43,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line),
      ),
      child: Icon(icon, color: AppColors.text, size: 22),
    );
  }
}

class _BrandMark extends StatelessWidget {
  final double size;

  const _BrandMark({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _BrandMarkPainter()),
    );
  }
}

class _BrandMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final green = Paint()..color = AppColors.green;
    final white = Paint()..color = Colors.white;
    final shield = Path()
      ..moveTo(size.width * .5, size.height * .05)
      ..cubicTo(
        size.width * .78,
        size.height * .1,
        size.width * .93,
        size.height * .23,
        size.width * .9,
        size.height * .5,
      )
      ..cubicTo(
        size.width * .87,
        size.height * .75,
        size.width * .66,
        size.height * .9,
        size.width * .5,
        size.height * .97,
      )
      ..cubicTo(
        size.width * .34,
        size.height * .9,
        size.width * .13,
        size.height * .75,
        size.width * .1,
        size.height * .5,
      )
      ..cubicTo(
        size.width * .07,
        size.height * .23,
        size.width * .22,
        size.height * .1,
        size.width * .5,
        size.height * .05,
      )
      ..close();
    canvas.drawPath(shield, green);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width * .5, size.height * .5),
          width: size.width * .17,
          height: size.height * .52,
        ),
        Radius.circular(size.width * .04),
      ),
      white,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width * .5, size.height * .5),
          width: size.width * .52,
          height: size.height * .17,
        ),
        Radius.circular(size.width * .04),
      ),
      white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DeliveryIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white;
    final pale = Paint()..color = const Color(0xFFEAF8F0);
    final green = Paint()..color = AppColors.darkGreen;
    final dark = Paint()..color = const Color(0xFF0A3B28);
    final orange = Paint()..color = const Color(0xFFFFBE4D);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * .05,
          size.height * .02,
          size.width * .42,
          size.height * .72,
        ),
        const Radius.circular(13),
      ),
      white,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * .1,
          size.height * .1,
          size.width * .32,
          size.height * .52,
        ),
        const Radius.circular(8),
      ),
      pale,
    );
    final rxStyle = TextPainter(
      text: const TextSpan(
        text: 'Rx',
        style: TextStyle(
          color: AppColors.green,
          fontWeight: FontWeight.w900,
          fontSize: 24,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    rxStyle.paint(canvas, Offset(size.width * .19, size.height * .27));
    canvas.drawCircle(Offset(size.width * .58, size.height * .9), 13, dark);
    canvas.drawCircle(Offset(size.width * .88, size.height * .9), 13, dark);
    final scooter = Path()
      ..moveTo(size.width * .48, size.height * .78)
      ..quadraticBezierTo(
        size.width * .68,
        size.height * .67,
        size.width * .92,
        size.height * .78,
      )
      ..lineTo(size.width * .82, size.height * .86)
      ..lineTo(size.width * .55, size.height * .86)
      ..close();
    canvas.drawPath(scooter, white);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * .62,
          size.height * .47,
          size.width * .25,
          size.height * .24,
        ),
        const Radius.circular(9),
      ),
      white,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * .65,
          size.height * .5,
          size.width * .19,
          size.height * .08,
        ),
        const Radius.circular(4),
      ),
      pale,
    );
    canvas.drawCircle(Offset(size.width * .56, size.height * .42), 13, orange);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * .5,
          size.height * .53,
          size.width * .14,
          size.height * .24,
        ),
        const Radius.circular(9),
      ),
      green,
    );
    canvas.drawLine(
      Offset(size.width * .62, size.height * .59),
      Offset(size.width * .72, size.height * .68),
      Paint()
        ..color = const Color(0xFFFFD27A)
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void _openDetail(BuildContext context, String title, IconData icon) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => DetailPage(title: title, icon: icon),
    ),
  );
}

class _Feature {
  final String label;
  final IconData icon;

  const _Feature(this.label, this.icon);
}

class _Category {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _Category(this.title, this.subtitle, this.icon, this.color);
}
