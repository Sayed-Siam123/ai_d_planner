import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/data/models/gemini_response.dart';
import 'package:ai_d_planner/app/data/models/plan_from_ai_model.dart';
import 'package:ai_d_planner/app/network/api_client.dart';
import 'package:ai_d_planner/app/network/api_end_points.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/widgets/app_widgets.dart';

class GeminiRepo{
  GeminiRepo();

  final client = ApiClient(customBaseUrl: ApiEndPoints.baseUrlGemini);

  //Bowling, Arcade, GoKarting, or similar activities

  // - Dietary restrictions:
  // - Strictly filter for Halal/ Kosher/ Gluten-Free (Celiac Disease) requirements, Only suggest non-compliant restaurants if unavoidable, and explicitly mention it in response.
  // - For other preferences (vegetarian, vegan, pescatarian) or allergies (nut, dairy, etc.), ensure suitable options but do not strictly filter. Note if options are limited, and mention accordingly in response.

  static String dataString({
    required String location,
    required String date,
    required String time,
    required String budget,
    required String duration,
    required String dateType,
    required String foodType,
    required String activityType,
    required String dateMoodType,
    required String dateDietRestrictions,
  }) =>
      """Answer only using your current data to the best of your ability.

•Given:
    - location: ${location.toString()}.
    - Maximum distance radius: 5 mile.
    - Maximum Date duration: ${duration.toString()}.
    - Preferred start time: ${time.toString()}.
    - Date Type: ${dateType.toString()}.
    - Preferred cuisine(if food mentioned in date type): ${foodType.toString()}.
    - Preferred Activities(if activities mentioned in date type): ${activityType.toString()}.
    - Date Mood: ${dateMoodType.toString()}.
    - Total combined budget for whole date for 2 people: ${budget.toString()}.
    - Ensure all estimated costs include taxes and tips where applicable.
    - Reservations are ok but must be explicitly mentioned in the generated answer if required.
    - Dietary restrictions:
        - Strictly filter for ${dateDietRestrictions.toString()} requirements, Only suggest non-compliant restaurants if unavoidable, and explicitly mention it in response.
        - For other preferences (vegetarian, vegan, pescatarian) or allergies (nut, dairy, etc.), ensure suitable options but do not strictly filter. Note if options are limited, and mention accordingly in response.

•Generate 3 distinct date plans, each listing activities/events in order with start time and duration. Strictly follow location, radius, and budget. If no good matches fit all criteria, improvise while staying as close as possible to the given requirements.

•For each date plan, structure the response exactly as follows:

•Date Plan 1:
    - Activity 1: A at X. Start Time: PM. Duration: hour. Description: (Estimated Cost: \$). Location: .
    - Activity 2: Y at C. Start Time: PM. Duration: hours. Description: (Estimated Cost: \$). Location: .
    - Activity 3: E at F. Start Time: PM. Duration: hour. Description: (Estimated Cost: \$10). Location:
    - Etc. as there can be more than 3 or even less
    - Estimated Total Cost (Date Plan 1): \$.


{
  "plans": [
    {
      "datePlanId": 1,
      "activities": [
        {
          "name": "Dinner at a Mediterranean Restaurant (hypothetical)",
          "startTime": "4:00 PM",
          "durationHours": 1.5,
          "description": "Enjoy Mediterranean kebabs and a cozy dining atmosphere.",
          "estimatedCost": 40,
          "location": "RPM Raceway, Queens, NY."        
        },
        {
          "name": "Bowling at Whitestone Lanes",
          "startTime": "5:45 PM",
          "durationHours": 1.5,
          "description": "Fun and competitive bowling experience.",
          "estimatedCost": 30,
          "location": "Whitestone Lanes, Flushing, NY."
        },
        {
          "name": "Dessert at Spot Dessert Bar",
          "startTime": "7:30 PM",
          "durationHours": 1,
          "description": "Indulge in delicious desserts with a creative twist.",
          "estimatedCost": 20,
          "location": "Spot Dessert Bar, Flushing, NY."
        }
      ],
      "totalEstimatedCost": 90
    },
    {
      "datePlanId": 2,
      "activities": [
        {
          "name": "Go-Karting at RPM Raceway",
          "startTime": "4:00 PM",
          "durationHours": 2,
          "description": "Thrilling indoor go-karting experience.",
          "estimatedCost": 50,
          "location": "RPM Raceway, Queens, NY."
        },
        {
          "name": "Dinner at an Italian Restaurant",
          "startTime": "6:30 PM",
          "durationHours": 2,
          "description": "Enjoy authentic Italian cuisine with a great ambiance.",
          "estimatedCost": 50,
          "location": "RPM Raceway, Queens, NY."
        }
      ],
      "totalEstimatedCost": 100
    },
    {
      "datePlanId": 3,
      "activities": [
        {
          "name": "Arcade Games at Dave & Buster's",
          "startTime": "4:00 PM",
          "durationHours": 2,
          "description": "Play classic and modern arcade games.",
          "estimatedCost": 40,
          "location": "Dave & Buster's, Queens, NY."
        },
        {
          "name": "Dinner at a Surprise Location",
          "startTime": "6:30 PM",
          "durationHours": 2,
          "description": "Surprise choice based on available options (e.g., Mediterranean, Italian).",
          "estimatedCost": 60,
          "location": "RPM Raceway, Queens, NY."
        }
      ],
      "totalEstimatedCost": 100
    }
  ]
}

Please provide the output in JSON format. Please provide location address also.
""";

  Future<GeminiResponse?> getPlansFromGemini({String? location, String? date,String? time,String? budget,String? duration, String? dateType, String? foodType, String? activityType, String? dateMoodType, String? dateDietRestrictions}) async{
    var response = await client.post(
        ApiEndPoints.getPrompt,
        {
          "contents": [
            {
              "parts": [
                {
                  "text": dataString(
                      location: location!,
                      date: date!,
                      time: time!,
                      budget: budget!,
                      duration: duration!,
                      activityType: activityType!,
                      dateDietRestrictions: dateDietRestrictions!,
                      dateMoodType: dateMoodType!,
                      dateType: dateType!,
                      foodType: foodType!
                  )
                }
              ]
            }
          ]
        },
        getPlansFromGemini,
        isLoaderRequired: false,isHeaderRequired: false
    );

    if(response?.statusCode == 200){
      // var data = accountTypeFromJson(jsonEncode(response.data));
      var data = await compute(deserializePlansFromGemini,response.toString());

      return data;
    } else{
      AppWidgets().getSnackBar(status: SnackBarStatus.error,message: "Plan Fetching Error");
      return null;
    }
  }

}

GeminiResponse? deserializePlansFromGemini(String data){
  var dataMap = geminiResponseFromJson(data.toString());
  return dataMap;
}