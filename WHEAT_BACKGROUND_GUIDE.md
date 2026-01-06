# 📱 PMFBY Enhanced Design Guide | डिज़ाइन गाइड

## 🌾 Wheat Field Background Setup | गेहूं के खेत की पृष्ठभूमि

### Required Images | आवश्यक छवियां

1. **Wheat Field Background** (गेहूं के खेत की पृष्ठभूमि)
   - Path: `assets/images/backgrounds/wheat_field.jpg`
   - Use: Full-screen background image on all screens
   - Requirements: 
     - Resolution: 1080x1920 (minimum)
     - Format: JPG
     - Quality: High (optimized for mobile)

2. **Farmer Avatar** (किसान अवतार)
   - Path: `assets/images/avatars/farmer_avatar.png`
   - Use: Profile icon, login screen avatar
   - Requirements:
     - Resolution: 512x512
     - Format: PNG (transparent background)
     - Style: Emoji/cartoon style farmer character

### 📥 Image Setup Instructions

```powershell
# Create image directories (already done)
# Place your images:
# 1. Save wheat field photo as: assets/images/backgrounds/wheat_field.jpg
# 2. Save farmer emoji as: assets/images/avatars/farmer_avatar.png
```

## 🎨 Design System | डिज़ाइन प्रणाली

### Color Scheme | रंग योजना

**Transparent Gradients** (पारदर्शी ग्रेडिएंट):
- Primary Overlay: `Colors.white.withOpacity(0.75)` - Main content overlay
- Secondary Overlay: `Colors.white.withOpacity(0.6)` - Mid-section fade
- Card Background: `Colors.white.withOpacity(0.85)` - Card containers
- Button Gradients: Subtle green/orange mix with 0.15 opacity

**Green Shades** (हरे रंग):
- Primary Green: `Colors.green.shade600` to `Colors.green.shade800`
- Border Green: `Colors.green.shade200.withOpacity(0.5)` - Soft borders
- Shadow Green: `Colors.green.shade100.withOpacity(0.3)` - Subtle shadows

**Text Colors** (टेक्स्ट रंग):
- Headings: `Colors.green.shade900` - Dark green for titles
- Body Text: `Colors.green.shade800` - Medium green for readable text
- Labels: `Colors.green.shade600` - Light green for hints/labels

### Component Specifications | घटक विशिष्टताएं

**Transparent Cards** (TransparentCard Widget):
```dart
TransparentCard(
  opacity: 0.85,  // 85% transparent white
  borderRadius: 20,
  borderColor: Colors.green.shade200.withOpacity(0.5),
  padding: EdgeInsets.all(20),
  child: YourContent(),
)
```

**Full Screen Background** (WheatFieldBackground Widget):
```dart
WheatFieldBackground(
  overlayOpacity: 0.75,  // 75% white overlay
  child: YourScreenContent(),
)
```

## 📄 Updated Screens | अद्यतन स्क्रीन

### 1. **Farmer Registration Screen** (किसान पंजीकरण स्क्रीन)
   - File: `lib/src/features/auth/presentation/farmer_registration_screen.dart`
   - Features:
     - ✅ OTP Verification
     - ✅ Mobile Number (10 digits)
     - ✅ Farmer Name (किसान का नाम)
     - ✅ Village (गांव)
     - ✅ Town/Tehsil (शहर/तहसील)
     - ✅ District (जिला)
     - ✅ State (राज्य)
     - ✅ Wheat field background
     - ✅ Farmer avatar image
     - ✅ Transparent card design

### 2. **Enhanced Login Screen** (बेहतर लॉगिन स्क्रीन)
   - File: `lib/src/features/auth/presentation/enhanced_login_screen.dart`
   - Updates:
     - ✅ Wheat field background (full screen)
     - ✅ Farmer avatar instead of logo
     - ✅ Transparent login card
     - ✅ Normalized colors (green tones, no harsh colors)
     - ✅ Demo login button with gradient
     - ✅ "New Farmer Registration" link

### 3. **Dashboard Screen** (डैशबोर्ड स्क्रीन)
   - File: `lib/src/features/dashboard/presentation/dashboard_screen.dart`
   - Updates:
     - ✅ Wheat field background
     - ✅ Transparent app bar (green with 90% opacity)
     - ✅ All cards use transparent design
     - ✅ Consistent color scheme

### 4. **Profile Screen** (प्रोफाइल स्क्रीन)
   - Same wheat background applied via `WheatFieldBackground` widget

## 🚀 Running the App | ऐप चलाएं

```bash
# Get dependencies
flutter pub get

# Run on connected device
flutter run

# Or run on specific device
flutter run -d <device_id>
```

## 🧪 Testing Registration Flow | पंजीकरण प्रवाह परीक्षण

1. **Open App** → Enhanced Login Screen (wheat background visible)
2. **Click** "नए किसान हैं? | New Farmer? पंजीकरण करें"
3. **Fill Details**:
   - Name: किसान का नाम
   - Mobile: 10 digit number
   - Click "OTP भेजें"
   - Enter 6-digit OTP
   - Village, Town, District, State
4. **Submit** → Registration complete → Navigate to Dashboard

## 📱 Demo Login Flow | डेमो लॉगिन प्रवाह

1. **Open App** → Enhanced Login Screen
2. **Scroll Down**
3. **Click** "Quick Demo Login | डेमो लॉगिन" (orange/green gradient button)
4. **Instant Access** → Dashboard screen with wheat background

## 🎯 Key Features | मुख्य विशेषताएं

### Visual Design
- ✅ **Full Screen Wheat Background** - All screens
- ✅ **Transparent Overlays** - 60-75% white overlay for readability
- ✅ **Soft Gradients** - No solid colors, gentle transitions
- ✅ **Farmer Avatar** - Emoji-style farmer character
- ✅ **Green Color Palette** - Natural, agricultural theme
- ✅ **Consistent Shadows** - Subtle depth without harshness

### Functional Design
- ✅ **OTP Authentication** - Firebase phone auth
- ✅ **Complete Farmer Details** - Name, mobile, location
- ✅ **Bilingual UI** - Hindi + English everywhere
- ✅ **50+ Languages** - Translation support
- ✅ **Demo Access** - Quick testing without OTP
- ✅ **Offline Support** - Local data storage

## 📝 Image Credits | छवि श्रेय

- Wheat field image: Provided by user (golden wheat field)
- Farmer avatar: Provided by user (cartoon farmer emoji)
- Fallback: Auto-generated gradients if images missing

## 🔧 Customization | अनुकूलन

### Change Overlay Opacity
```dart
WheatFieldBackground(
  overlayOpacity: 0.8,  // Increase for more white overlay
  child: YourContent(),
)
```

### Change Card Transparency
```dart
TransparentCard(
  opacity: 0.9,  // Increase for more opaque cards
  child: YourContent(),
)
```

### Change Border Colors
```dart
TransparentCard(
  borderColor: Colors.amber.shade200,  // Golden border
  child: YourContent(),
)
```

## 🌟 Pro Tips | पेशेवर सुझाव

1. **Image Quality**: Use high-resolution wheat field images (1080p minimum)
2. **Performance**: Images are cached automatically by Flutter
3. **Fallbacks**: Gradient backgrounds appear if images fail to load
4. **Consistency**: All screens now use same background system
5. **Accessibility**: Text remains readable with 75% overlay opacity
6. **Animations**: Smooth fade-ins and slides enhance user experience

## 📚 Widget Reference | विजेट संदर्भ

### WheatFieldBackground
- Location: `lib/src/widgets/wheat_field_background.dart`
- Purpose: Reusable background widget
- Props: `child`, `overlayColors`, `overlayOpacity`

### TransparentCard
- Location: `lib/src/widgets/wheat_field_background.dart`
- Purpose: Glass-morphism style cards
- Props: `child`, `padding`, `opacity`, `borderColor`, `borderRadius`

---

**🌾 Happy Farming! | शुभ खेती! 🌾**
