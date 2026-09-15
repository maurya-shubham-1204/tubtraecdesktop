import 'package:tubtrace_desktop/data/mock_dashboard_data.dart';

class MockPatient {
  const MockPatient({
    required this.id,
    required this.name,
    required this.ageSex,
    required this.date,
    required this.amount,
    required this.paid,
    required this.status,
  });

  final String id;
  final String name;
  final String ageSex;
  final String date;
  final String amount;
  final String paid;
  final String status;
}

class MockDoctor {
  const MockDoctor({
    required this.name,
    required this.phone,
    required this.commission,
    required this.wallet,
  });

  final String name;
  final String phone;
  final String commission;
  final String wallet;
}

class MockTestItem {
  const MockTestItem({
    required this.code,
    required this.name,
    required this.department,
    required this.price,
    required this.params,
  });

  final String code;
  final String name;
  final String department;
  final String price;
  final int params;
}

class MockPendingCase {
  const MockPendingCase({
    required this.id,
    required this.name,
    required this.tests,
    required this.date,
  });

  final String id;
  final String name;
  final String tests;
  final String date;
}

class MockCatalog {
  static const patients = <MockPatient>[
    MockPatient(
      id: 'P-10241',
      name: 'Mr. Rahul Sharma',
      ageSex: '32 / M',
      date: '13 Sep 2026',
      amount: '1,800',
      paid: '1,800',
      status: 'Verified',
    ),
    MockPatient(
      id: 'P-10240',
      name: 'Mrs. Anita Devi',
      ageSex: '45 / F',
      date: '13 Sep 2026',
      amount: '2,450',
      paid: '1,000',
      status: 'Due',
    ),
    MockPatient(
      id: 'P-10239',
      name: 'Ms. Priya Singh',
      ageSex: '28 / F',
      date: '12 Sep 2026',
      amount: '950',
      paid: '950',
      status: 'Pending',
    ),
    MockPatient(
      id: 'P-10238',
      name: 'Mr. Vikram Patel',
      ageSex: '51 / M',
      date: '12 Sep 2026',
      amount: '3,200',
      paid: '3,200',
      status: 'Verified',
    ),
    MockPatient(
      id: 'P-10237',
      name: 'Mrs. Sunita Rao',
      ageSex: '39 / F',
      date: '11 Sep 2026',
      amount: '1,150',
      paid: '500',
      status: 'Due',
    ),
    MockPatient(
      id: 'P-10236',
      name: 'Mr. Amit Joshi',
      ageSex: '26 / M',
      date: '11 Sep 2026',
      amount: '780',
      paid: '780',
      status: 'Pending',
    ),
  ];

  static const doctors = <MockDoctor>[
    MockDoctor(name: 'Dr. Mehta', phone: '98765 43210', commission: '20%', wallet: '12,400'),
    MockDoctor(name: 'Dr. Kapoor', phone: '98111 22334', commission: '15%', wallet: '8,750'),
    MockDoctor(name: 'Dr. Khan', phone: '99000 11223', commission: '18%', wallet: '6,200'),
    MockDoctor(name: 'Dr. Iyer', phone: '97654 32109', commission: '12%', wallet: '3,980'),
    MockDoctor(name: 'Dr. Bose', phone: '91234 56780', commission: '25%', wallet: '15,100'),
  ];

  static const tests = <MockTestItem>[
    MockTestItem(code: 'CBC', name: 'Complete Blood Count', department: 'Hematology', price: '350', params: 18),
    MockTestItem(code: 'LFT', name: 'Liver Function Test', department: 'Biochemistry', price: '650', params: 8),
    MockTestItem(code: 'KFT', name: 'Kidney Function Test', department: 'Biochemistry', price: '550', params: 7),
    MockTestItem(code: 'LIPID', name: 'Lipid Profile', department: 'Biochemistry', price: '500', params: 5),
    MockTestItem(code: 'TSH', name: 'Thyroid Stimulating Hormone', department: 'Hormones', price: '400', params: 1),
    MockTestItem(code: 'HBA1C', name: 'Glycated Hemoglobin', department: 'Biochemistry', price: '450', params: 1),
  ];

  static const pendingCases = <MockPendingCase>[
    MockPendingCase(id: 'P-10240', name: 'Mrs. Anita Devi', tests: 'CBC, LFT', date: '13 Sep'),
    MockPendingCase(id: 'P-10239', name: 'Ms. Priya Singh', tests: 'TSH', date: '12 Sep'),
    MockPendingCase(id: 'P-10236', name: 'Mr. Amit Joshi', tests: 'KFT, Lipid', date: '11 Sep'),
    MockPendingCase(id: 'P-10233', name: 'Mr. Deepak Kumar', tests: 'CBC', date: '10 Sep'),
    MockPendingCase(id: 'P-10230', name: 'Mrs. Meena Gupta', tests: 'HbA1c', date: '09 Sep'),
  ];

  static const registrationTests = [
    'CBC — ₹350',
    'LFT — ₹650',
    'KFT — ₹550',
    'Lipid Profile — ₹500',
    'TSH — ₹400',
  ];

  static String get labName => MockDashboardData.labName;
  static String get userName => MockDashboardData.userName;
}
