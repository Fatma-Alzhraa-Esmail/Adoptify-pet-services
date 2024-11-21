// import 'package:flutter/material.dart';
// import 'package:pet_services_app/services/servicesFeatures/model/service_model.dart';
// import 'package:pet_services_app/utilities/theme/media.dart';
// import 'package:pet_services_app/utilities/theme/text_styles.dart';


// class PetCard extends StatelessWidget {
//   const PetCard({
//     super.key,
//     required this.model,
//   });
//   final ServicesModel model;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 100,
//           width: MediaHelper.width,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             image: DecorationImage(
//               image: AssetImage(model.image ?? ""),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           model.title ?? "",
//           style: AppTextStyles.w500.copyWith(fontSize: 12),
//         ),
//       ],
//     );
//   }
// }
