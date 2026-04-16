# Travelike UI Overhaul — Kế Hoạch Triển Khai Toàn Diện

## Tổng Quan

Sau khi nghiên cứu kỹ **78 file Figma**, **53 ảnh chụp app thực tế**, và **toàn bộ 34 file Dart** hiện có, đây là đánh giá tổng quan:

### Trạng Thái Hiện Tại
- ✅ **Cấu trúc tốt**: Design system (AppColors, AppTextStyles, AppSpacing) đã có nền tảng
- ✅ **GlassContainer** đã có — nhưng chưa được dùng đúng mức "Liquid Glass"
- ✅ **34 màn hình** đã có code — nhưng nhiều màn hình chất lượng không đồng đều
- ❌ **Bottom Nav Bar** — là vùng trắng, không phải Liquid Glass như mong muốn
- ❌ **Emoji rẻ tiền** — dùng trong flights ('🔴','🟡','🟢'), settings ('👤','🔔','🔒'), itinerary ('🌉','🏔️')
- ❌ **Padding/Border không đồng bộ** — mỗi màn hình padding khác nhau
- ❌ **Dead-end navigation** — nhiều nút bấm `onTap: () {}` không dẫn đi đâu
- ❌ **Thiếu màn hình**: Saved, Gallery fullscreen, Map interactive, Flight search results

---

## User Review Required

> [!IMPORTANT]
> **Hiệu ứng Liquid Glass sẽ được triển khai theo tiêu chuẩn Apple WWDC 2025** — prismatic iridescent blur, chromatic aberration nhẹ, border gradient rainbow, adaptive tinting dựa trên content phía sau. Đây KHÔNG phải chỉ đơn giản là backdrop blur trắng.

> [!WARNING]
> **Loại bỏ 100% emoji** — Tất cả emoji ('🔴','👤','🌉', v.v.) sẽ được thay bằng Iconsax icons hoặc custom painted icons. Không có ngoại lệ.

> [!IMPORTANT]
> **Kế hoạch này rất lớn (~34 files)**. Tôi sẽ chia thành 6 Phase để thực hiện tuần tự. Mỗi Phase hoàn thành → build test → tiếp Phase sau.

---

## Proposed Changes

### Phase 1: Liquid Glass Design System & Bottom Navigation Bar

Đây là nền tảng — sửa trước để tất cả Phase sau dùng chung.

---

#### [MODIFY] [app_colors.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/core/theme/app_colors.dart)
- Thêm **Liquid Glass Prismatic tokens**: 
  - `glassPrismatic` — gradient cầu vồng nhẹ cho border
  - `glassIridescent` — shimmer overlay
  - `glassTint` — adaptive tinting color
  - `liquidGlassBlur` — sigma values tối ưu cho hiệu ứng liquid
- Thêm `navBarGlass` — color tokens riêng cho bottom nav
- Cải tiến `glassShadow` — thêm colored glow effect

#### [NEW] [liquid_glass.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/core/widgets/liquid_glass.dart)
- Widget `LiquidGlassContainer` — nâng cấp hoàn toàn từ GlassContainer
  - **Prismatic border**: Border gradient cầu vồng nhẹ, xoay theo angle
  - **Chromatic tinting**: Tự động lấy dominant color từ BG để tint
  - **Depth layers**: Multiple blur layers tạo cảm giác chiều sâu
  - **Specular highlight**: Highlight trắng ở cạnh trên mô phỏng ánh sáng
  - Factory: `.light()`, `.medium()`, `.heavy()`, `.navBar()`, `.pill()`

#### [MODIFY] [custom_bottom_nav.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/core/widgets/custom_bottom_nav.dart)
**ĐÂY LÀ THAY ĐỔI QUAN TRỌNG NHẤT** — từ "vùng trắng xấu" thành:
- **Floating pill design**: Thanh nav nổi, bo tròn hoàn toàn, cách bottom 16px
- **LiquidGlassContainer** làm nền — blur 30, prismatic border
- **Active indicator**: Liquid glass pill nhỏ highlight icon đang chọn
- **Center button**: Gradient orb với hiệu ứng glow pulsing
- **Icon animation**: Morphing smooth khi chuyển tab (spring physics)
- **Haptic feedback**: Light impact khi tap

---

### Phase 2: Loại Bỏ Emoji & Cải Tiến Mock Data

---

#### [MODIFY] [mock_data.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/data/mock_data.dart)
- **Flights**: `'logo': '🔴'` → `'logo': 'vietjet'` (dùng colored container)
- **Itinerary**: `'icon': '🌉'` → `'icon': 'bridge'` (map sang IconData)
- **Weather**: `'icon': '⛅'` → `'icon': 'cloud_sunny'` (map sang IconData)
- **Settings**: `'icon': '👤'` → dùng IconData trực tiếp
- **Currencies**: `'flag': '🇺🇸'` → dùng circle flag container với mã country
- Thêm mock data mới cho: Saved items, Gallery photos, Chat reactions

#### [NEW] [icon_mapper.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/core/utils/icon_mapper.dart)
- Utility class map string → IconData cho tất cả categories
- Map color cho từng airline, weather condition, itinerary type
- Loại bỏ hoàn toàn dependency vào emoji Text widgets

---

### Phase 3: Cải Tiến Tất Cả Core Widgets

---

#### [MODIFY] [glass_container.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/core/widgets/glass_container.dart)
- Deprecate → redirect sang LiquidGlassContainer
- Giữ backward compatibility nhưng internal dùng Liquid Glass mới

#### [MODIFY] [premium_card.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/core/widgets/premium_card.dart)
- Dùng LiquidGlassContainer cho card overlay
- Cải tiến shadow system — layered shadows cho depth
- Thêm hero animation support cho transition sang detail

#### [MODIFY] [app_search_bar.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/core/widgets/app_search_bar.dart)
- Liquid Glass search bar — frosted background
- Animated search icon → X icon khi typing
- Smooth expand animation khi focus

#### [MODIFY] [category_chips.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/core/widgets/category_chips.dart)
- Liquid Glass chips cho selected state
- Smooth morphing animation khi select/deselect
- Consistent sizing và spacing

#### [MODIFY] [section_header.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/core/widgets/section_header.dart)
- Thêm animated "See all" arrow
- Typography alignment với display system

#### [MODIFY] [app_back_button.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/core/widgets/app_back_button.dart)
- Liquid Glass circle button
- Ripple effect khi tap

---

### Phase 4: Cải Tiến Tất Cả Màn Hình Chính (Tab Screens)

---

#### [MODIFY] [home_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/home/home_screen.dart)
- Quick Access Grid: Dùng Liquid Glass containers thay vì plain colored boxes
- Destination Cards: Thêm parallax effect khi scroll
- Tour Cards: Liquid Glass overlay
- Blog Cards: Smooth tint background
- Header icons: Liquid Glass circles
- Đồng bộ padding 20px toàn bộ

#### [MODIFY] [reels_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/reels/reels_screen.dart)
- Action items: Liquid Glass background circles
- Bottom info: Glassmorphism panel
- Comment sheet: Liquid Glass header
- Hashtag chips: Liquid Glass pills
- Thêm: Region selector dropdown (reference Figma "Reels - Select Location")

#### [MODIFY] [weather_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/weather/weather_screen.dart)
- Main weather card: Liquid Glass với prismatic border
- Hourly forecast: Liquid Glass pills đồng bộ
- Metrics: Liquid Glass containers
- 5-day forecast: Thêm weather icons thay emoji
- Location picker: Liquid Glass sheet

#### [MODIFY] [profile_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/profile/profile_screen.dart)
- Stats bar: Liquid Glass container
- Tab bar: Frosted background khi scroll
- Action buttons: Liquid Glass outline
- Photo grid: Rounded corners đồng bộ

#### [MODIFY] [create_post_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/social/create_post_screen.dart)
- Full UI cho tạo post: Image picker, text input, location tag, categories
- Liquid Glass action bar
- Smooth keyboard animation

---

### Phase 5: Cải Tiến Tất Cả Màn Hình Phụ

---

#### [MODIFY] [splash_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/splash/splash_screen.dart)
- Logo animation: Liquid ripple effect
- Background: Animated gradient shift

#### [MODIFY] [onboarding_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/onboarding/onboarding_screen.dart)
- Bottom card: Liquid Glass
- Page indicators: Liquid morphing dots
- Parallax background images

#### [MODIFY] [signin_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/auth/signin_screen.dart) + [signup_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/auth/signup_screen.dart)
- Form card: Liquid Glass
- Input fields: Frosted glass style
- Social buttons: Liquid Glass pills
- Smooth form validation animations

#### [MODIFY] [events_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/events/events_screen.dart)
- Toggle: Liquid Glass segmented control
- Event cards: Đồng bộ với premium_card
- Detail screen bottom bar: Liquid Glass

#### [MODIFY] [book_flight_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/flights/book_flight_screen.dart)
- Airline logos: Colored circles thay emoji
- Flight cards: Liquid Glass
- Swap button: Animated rotation

#### [MODIFY] [hotel_list_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/hotels/hotel_list_screen.dart) + [hotel_detail_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/hotels/hotel_detail_screen.dart)
- Room cards: Liquid Glass
- Amenity badges: Icon pills
- Gallery: Hero animation

#### [MODIFY] [tour_list_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/tours/tour_list_screen.dart) + [tour_detail_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/tours/tour_detail_screen.dart)
- Tour cards: Đồng bộ design system
- Include chips: Liquid Glass pills
- Book button: Gradient với glow

#### [MODIFY] [local_dishup_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/food/local_dishup_screen.dart) + [restaurant_detail_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/food/restaurant_detail_screen.dart)
- Food grid: Staggered layout đẹp hơn
- Price badges: Styled pills
- Restaurant menu: Liquid Glass cards

#### [MODIFY] [currency_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/currency/currency_screen.dart)
- Country flags: Circle containers thay emoji
- Exchange card: Liquid Glass
- Rate list: Clean dividers

#### [MODIFY] [blog_list_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/blog/blog_list_screen.dart) + [blog_detail_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/blog/blog_detail_screen.dart)
- Featured post: Hero card
- List items: Liquid Glass hover
- Detail: Rich text layout

#### [MODIFY] [message_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/social/message_screen.dart) + [chat_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/social/chat_screen.dart)
- Message list: Clean cards
- Chat bubbles: Liquid Glass cho received messages
- Input bar: Frosted glass

#### [MODIFY] [map_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/map/map_screen.dart)
- Map placeholder: Styled container
- Bottom sheet: Liquid Glass với drag handle
- Location cards: Horizontal scroll

#### [MODIFY] [itinerary_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/plan/itinerary_screen.dart)
- Timeline: Custom painted line
- Activity icons: Iconsax thay emoji
- Cards: Liquid Glass

#### [MODIFY] [search_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/search/search_screen.dart)
- Full search UI: Auto-focus keyboard mở
- Recent searches: Tappable chips
- Results: Categorized sections

#### [MODIFY] [region_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/region/region_screen.dart)
- Grid cards: Đồng bộ border radius
- Flag badges: Country-specific

#### [MODIFY] [settings_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/settings/settings_screen.dart)
- Setting items: Iconsax icons thay emoji
- Section dividers: Subtle separators
- Log out: Destructive style

#### [MODIFY] [saved_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/saved/saved_screen.dart)
- Bookmarked items: Tab categories
- Empty state: Illustrated message

#### [MODIFY] [notification_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/notifications/notification_screen.dart)
- Notification items: Read/unread styling
- Type icons: Colored circles

#### [MODIFY] [edit_profile_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/profile/edit_profile_screen.dart)
- Form fields: Liquid Glass input
- Avatar picker: Camera overlay
- Save button: Gradient

#### [MODIFY] [payment_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/payment/payment_screen.dart)
- Payment methods: Card icons
- Summary: Liquid Glass breakdown
- Confirm: Animated success

#### [MODIFY] [photo_gallery_screen.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/gallery/photo_gallery_screen.dart)
- Grid tiles: Staggered masonry
- Full screen viewer: Pinch zoom, swipe
- Share sheet: Liquid Glass

---

### Phase 6: Navigation Flow & Polish Final

---

#### [MODIFY] [main_shell.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/features/main_shell.dart)
- **extendBody: true** + **extendBodyBehindAppBar: true** 
- Bottom nav floating trên content
- Smooth page transitions khi chuyện tab (fade + slide)

#### [MODIFY] [page_transitions.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/core/utils/page_transitions.dart)
- Thêm: Shared element hero transitions
- Thêm: iOS-style interactive pop gesture
- Thêm: Modal sheet transition (slideUp)

#### [MODIFY] [app_animations.dart](file:///Users/thanhhuy_23/Workspace/mobile/Travelike/travelike/lib/core/utils/app_animations.dart)
- Thêm: Spring physics constants
- Thêm: Stagger delays system
- Thêm: Liquid morphing curves

#### Full Navigation Audit — Kết nối 100%
- Tất cả "See all" → dẫn tới list screen tương ứng ✅ (đã có phần lớn)
- Tất cả list items → dẫn tới detail screen ✅
- Tất cả "Book Now" → dẫn tới payment screen
- Tour cards trên Home → Tour Detail screen
- Settings items → sub-pages tương ứng
- Profile photos → Gallery fullscreen
- Search results → Detail screens tương ứng
- Map locations → Attraction detail

---

## Open Questions

> [!IMPORTANT]
> **1. Có muốn Dark Mode không?** — Hiện tại design system chỉ có Light theme. Liquid Glass sẽ đẹp hơn rất nhiều trên dark background. Tôi có thể thêm toggle trong Settings nếu muốn.

> [!IMPORTANT]  
> **2. Thứ tự ưu tiên Phase nào?** — Tôi đề xuất Phase 1 (Bottom Nav) → Phase 2 (Remove Emoji) → Phase 4 (Main Screens) → Phase 5 (Sub Screens) → Phase 3 (Core Widgets lúc này refactor lại) → Phase 6 (Navigation & Polish). Bạn có muốn thay đổi thứ tự không?

> [!IMPORTANT]
> **3. Có thêm dependency mới không?** — Hiện tại `flutter_animate`, `iconsax_flutter`, `cached_network_image` đã đủ. Tôi KHÔNG cần thêm package nào mới. Tất cả Liquid Glass effects sẽ được build bằng Flutter native (BackdropFilter, CustomPainter, ShaderMask).

---

## Verification Plan

### Build Test
```bash
cd /Users/thanhhuy_23/Workspace/mobile/Travelike/travelike
flutter analyze
flutter build ios --no-codesign  # hoặc flutter build apk
```

### Visual Verification
- Chạy app trên iOS Simulator sau mỗi Phase
- Screenshot so sánh trước/sau
- Kiểm tra smooth animation 60fps
- Test scroll performance
- Verify tất cả navigation paths hoạt động

### Checklist Mỗi Phase
- [ ] Không có emoji nào còn sót
- [ ] Tất cả nút bấm đều có navigation hoặc action
- [ ] Padding đồng bộ 20px screen padding
- [ ] Border radius đồng bộ (20px cards, 24px sheets, 28px nav)
- [ ] Liquid Glass effect thống nhất
- [ ] Animation smooth, không lag
