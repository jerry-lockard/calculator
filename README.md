# Calculator

A modern, feature-rich calculator application built with Flutter. This app provides a beautiful user interface with support for basic mathematical operations, theme customization, and a responsive design. The calculator combines elegant Material Design 3 principles with powerful mathematical capabilities to deliver a superior user experience.

## Features

- Basic arithmetic operations (addition, subtraction, multiplication, division)
- Advanced mathematical expressions support with order of operations (PEMDAS)
- Dynamic theme switching (light/dark mode) with Material You integration
- Real-time calculation updates
- Responsive layout that works across different screen sizes and orientations
- Beautiful custom fonts (Pretendard) for enhanced readability
- Error handling and input validation
- History of calculations (coming soon)
- Gesture support for quick actions
- Haptic feedback for button presses
- Adaptive color schemes based on system theme

## User Interface

### Components
- **Header Display**: Shows both input expression and result in real-time
- **Input Pad**: Customized number pad with mathematical operations
- **Theme App Bar**: Quick access to theme switching and settings
- **Responsive Grid**: Automatically adjusts based on screen size

### Theme Customization
- Dynamic color schemes based on Material Design 3
- Automatic dark/light mode switching
- Custom color seeds for personalized themes
- Smooth theme transition animations

## Tech Stack

- **Framework**: Flutter
- **State Management**: Provider for reactive state updates
- **Math Operations**: math_expressions ^2.3.1 for precise calculations
- **Icons**: font_awesome_flutter ^10.2.1 for crisp, scalable icons
- **SDK**: Dart SDK 3.5.4
- **Architecture**: MVVM (Model-View-ViewModel) pattern

## Project Structure

```
lib/
├── screens/           # UI screens and layouts
│   └── calculator_screen.dart
├── viewmodels/        # Business logic and state management
│   ├── calculator_viewmodel.dart
│   └── theme_viewmodel.dart
├── widgets/           # Reusable UI components
│   ├── header_display.dart
│   ├── input_pad.dart
│   └── theme_app_bar.dart
├── models/           # Data models and calculations
├── utils/           # Helper functions and constants
└── main.dart        # Application entry point

assets/
├── fonts/           # Custom typography
└── images/         # Application icons and images
```

## Dependencies

- `provider`: ^6.0.4 - For efficient state management and dependency injection
- `math_expressions`: ^2.3.1 - For accurate mathematical calculations and expression parsing
- `font_awesome_flutter`: ^10.2.1 - For enhanced iconography
- `cupertino_icons`: ^1.0.2 - iOS style icons for platform adaptivity

## Getting Started

1. Ensure you have Flutter installed on your machine
   ```bash
   flutter --version
   ```

2. Clone the repository
   ```bash
   git clone https://github.com/jerry-lockard/calculator.git
   cd calculator
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Development Setup

### Prerequisites
- Flutter SDK (3.5.4 or higher)
- Dart SDK (3.5.4 or higher)
- Android Studio / VS Code with Flutter extensions
- iOS Simulator (for Mac users) / Android Emulator

### VS Code Configuration
Recommended extensions:
- Flutter
- Dart
- Flutter Widget Snippets
- Better Comments

### Performance Optimization
- Enable Flutter performance profiling:
  ```bash
  flutter run --profile
  ```
- Monitor widget rebuilds using Flutter DevTools

## Supported Platforms

- Android (API 21+)
- iOS (13.0+)
- Web (All modern browsers)
- Windows (Coming soon)
- macOS (Coming soon)
- Linux (Coming soon)

## Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## Contributing

We welcome contributions to make this calculator even better! Here's how you can help:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Code Style
- Follow the official [Flutter style guide](https://flutter.dev/docs/development/style-guide)
- Use meaningful variable and function names
- Add comments for complex logic
- Write unit tests for new features

## Troubleshooting

Common issues and solutions:
1. **Build fails after updating Flutter**
   - Run `flutter clean` and `flutter pub get`
   
2. **Performance issues**
   - Check for unnecessary widget rebuilds
   - Use const constructors where possible
   - Implement caching for expensive calculations

## License

This project is open source and available under the MIT License.

## Acknowledgments

- Flutter team for the amazing framework
- Material Design team for the design guidelines
- All contributors who have helped shape this project

## Contact

For support or queries, please open an issue in the GitHub repository.
