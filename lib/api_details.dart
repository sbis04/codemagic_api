class APIDetails {
  static final List<String> text = [
    'Codemagic API Token',
    'App ID',
    'Workflow ID',
    'Branch',
    'Flutter',
    'Xcode',
    'CocoaPods',
  ];

  static final List<String> hint = [
    'Enter your token',
    'Enter your app ID',
    'Enter your workflow ID',
    'Enter your project branch',
    'Enter the Flutter version',
    'Enter the Xcode version',
    'Enter the CocoaPods version',
  ];

  static final List<String> initialValue = [
      '<Enter Your Codemagic Token Here>',
      '5d85eaa0e941e00019e81bc2', // app ID
      '5d85f242e941e00019e81bd2', // workflow ID
      'master', // branch
      '1.17.1', // Flutter version
      '11.4.1', // Xcode version
      '9.0', // CocoaPods version
    ];
}
