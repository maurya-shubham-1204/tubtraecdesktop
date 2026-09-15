class StatCardData {
  const StatCardData({
    required this.label,
    required this.today,
    required this.total,
    this.suffix = '',
    this.showToday = true,
    required this.iconColor,
  });

  final String label;
  final String today;
  final String total;
  final String suffix;
  final bool showToday;
  final int iconColor;
}

class NamedCount {
  const NamedCount(this.name, this.count);
  final String name;
  final int count;
}

class PatientRow {
  const PatientRow(this.name, this.dateLabel);
  final String name;
  final String dateLabel;
}

class MockDashboardData {
  static const labName = 'Demo Pathology Lab';
  static const userName = 'Lab Admin';

  static const stats = <StatCardData>[
    StatCardData(
      label: 'Patient',
      today: '12',
      total: '1,284',
      iconColor: 0xFF9694FF,
    ),
    StatCardData(
      label: 'Test Booked',
      today: '38',
      total: '4,562',
      iconColor: 0xFF57CAEB,
    ),
    StatCardData(
      label: 'Collection',
      today: '18,400',
      total: '6,42,800',
      suffix: ' ₹',
      iconColor: 0xFFFF7976,
    ),
    StatCardData(
      label: 'Earning',
      today: '14,200',
      total: '5,10,350',
      suffix: ' ₹',
      iconColor: 0xFF9694FF,
    ),
    StatCardData(
      label: 'Total Report',
      today: '',
      total: '1,102',
      showToday: false,
      iconColor: 0xFF5A8DEE,
    ),
    StatCardData(
      label: 'Total Doctor',
      today: '',
      total: '46',
      showToday: false,
      iconColor: 0xFFFF7976,
    ),
    StatCardData(
      label: 'Total Due',
      today: '',
      total: '48,750',
      suffix: ' ₹',
      showToday: false,
      iconColor: 0xFF435EBE,
    ),
    StatCardData(
      label: 'Pending Reports',
      today: '',
      total: '9',
      showToday: false,
      iconColor: 0xFF435EBE,
    ),
  ];

  static const monthLabels = [
    'Oct',
    'Nov',
    'Dec',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
  ];

  static const monthTests = <double>[
    210,
    245,
    198,
    260,
    302,
    288,
    315,
    340,
    295,
    360,
    378,
    410,
  ];

  static const dayLabels = [
    '07 Sep',
    '08 Sep',
    '09 Sep',
    '10 Sep',
    '11 Sep',
    '12 Sep',
    '13 Sep',
  ];

  static const dayCollection = <double>[
    12400,
    9800,
    15200,
    11000,
    17600,
    14300,
    18400,
  ];

  static const topTests = <NamedCount>[
    NamedCount('CBC', 186),
    NamedCount('LFT', 142),
    NamedCount('KFT', 128),
    NamedCount('Lipid Profile', 97),
    NamedCount('TSH', 84),
  ];

  static const recentPatients = <PatientRow>[
    PatientRow('Mr. Rahul Sharma', '13 Sep'),
    PatientRow('Mrs. Anita Devi', '13 Sep'),
    PatientRow('Ms. Priya Singh', '12 Sep'),
    PatientRow('Mr. Vikram Patel', '12 Sep'),
    PatientRow('Mrs. Sunita Rao', '11 Sep'),
    PatientRow('Mr. Amit Joshi', '11 Sep'),
  ];

  static const pendingReports = <PatientRow>[
    PatientRow('Mr. Deepak Kumar', '13 Sep'),
    PatientRow('Mrs. Meena Gupta', '12 Sep'),
    PatientRow('Mr. Suresh Yadav', '12 Sep'),
    PatientRow('Ms. Kavita Nair', '11 Sep'),
    PatientRow('Mr. Farhan Ali', '10 Sep'),
  ];

  static const quickActions = <String>[
    '+ New registration',
    'Enter & verify',
    'Patients',
    'Doctors',
    'Analytics',
    'Tests',
  ];
}
