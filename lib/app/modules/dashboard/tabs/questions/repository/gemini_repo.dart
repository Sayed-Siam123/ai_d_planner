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
      """Answer only in the format outlined below and nothing else. Do not include any placeholders. 
      Explicitly mention the name of the places for each activity. Try to fill the given time duration as much as possible. 
      If the budget is used up, recommend a free activity. Every activity MUST have a specific place name and address. 
      Do NOT respond with "near [place name]" or "to be determined" for locations. If a specific place can't be found within the given radius, extend the search radius as needed to find a named location. 
      For example, do NOT say "Enjoy dessert at a local bakery near [X]". Instead, find a specific bakery and provide its name and address. Do NOT leave any locations as "TBD."

•Given:
    - location: ${location.toString()}.
    
    - Maximum distance radius: 10 miles from the initial location.
      Activities within a date plan should ideally be no more than 5 miles apart, 
      but prioritize finding suitable activities over strict 5-mile adherence if necessary.
      
    - Maximum Date duration: ${duration.toString()}.
    
    - Preferred start time: ${time.toString()}.
    
    - Date Type: ${dateType.toString()}.
    
    - Preferred cuisine: ${foodType.toString()}.
    
    - Preferred Activities: ${activityType.toString()}.
    
    - Date Mood: ${dateMoodType.toString()}.
    
    - Total budget (2 people): ${budget.toString()} (including taxes/tips).
    
    - Reservations: Okay (mention explicitly if required).
    
    - Dietary restrictions:
        - Strictly filter for ${dateDietRestrictions.toString()}.
        - For other preferences/allergies (vegetarian, vegan, pescatarian, nut, dairy, etc.), ensure suitable options but do not strictly filter, note limitations.

•Generate 3 distinct date plans.  Prioritize finding locations within the 10-mile radius of the starting location (${location.toString()}).

•For each date plan, structure the response exactly as follows:

•Date Plan 1:
    Activity 1: [Action (4-8 words)] at [Place Name]. Start Time: [Time]. Duration: [Duration]. (Estimated Cost: \$[Cost]). Location: [Address].
    Activity 2: [Action (4-8 words)] at [Place Name]. Start Time: [Time]. Duration: [Duration]. (Estimated Cost: \$[Cost]). Location: [Address].
    Activity 3: [Action (4-8 words)] at [Place Name]. Start Time: [Time]. Duration: [Duration]. (Estimated Cost: \$[Cost]). Location: [Address].
    ... (More or fewer activities possible)

    Estimated Total Cost (Date Plan 1): \$[Total Cost].
    
    Same format for Date Plan 2 and Date Plan 3.

{
  "plans": [
    {
      "datePlanId": 1,
      "activities": [
        {
          "name": "[Activities you can generate suitable like - Kick off the [evening,morning or any other you can suggest] with [dinner,lunch or any other you can suggest] at [place name]]",
          "startTime": "[any time with AM/PM]",
          "durationHours": [1.5 or another duration] hours,
          "description": "[describe something in your words]",
          "estimatedCost": [estimated cost],
          "location": [location,address]    
        },
        {
          "name": "[Activities you can generate suitable like - Bowling at Whitestone Lanes]",
          "startTime": "[any time with AM/PM]",
          "durationHours": [1.5 or another duration] hours,
          "description": "[describe something in your words]",
          "estimatedCost": [estimated cost],
          "location": [location,address]
        },
        {
          "name": "[Activities you can generate suitable like - Dessert at Spot Dessert Bar]",
          "startTime": "[any time with AM/PM]",
          "durationHours": [1.5 or another duration] hours,
          "description": [describe something in your words]",
          "estimatedCost": [estimated cost],
          "location": [location,address]
        }
      ],
      "totalEstimatedCost": [estimated cost]
    },
    {
      "datePlanId": 1,
      "activities": [
        {
          "name": "[Activities you can generate suitable like - Kick off the [evening,morning or any other you can suggest] with [dinner,lunch or any other you can suggest] at [place name]]",
          "startTime": "[any time with AM/PM]",
          "durationHours": [1.5 or another duration] hours,
          "description": "[describe something in your words]",
          "estimatedCost": [estimated cost],
          "location": [location,address]    
        },
        {
          "name": "[Activities you can generate suitable like - Bowling at Whitestone Lanes]",
          "startTime": "[any time with AM/PM]",
          "durationHours": [1.5 or another duration] hours,
          "description": "[describe something in your words]",
          "estimatedCost": [estimated cost],
          "location": [location,address]
        },
        {
          "name": "[Activities you can generate suitable like - Dessert at Spot Dessert Bar]",
          "startTime": "[any time with AM/PM]",
          "durationHours": [1.5 or another duration] hours,
          "description": [describe something in your words]",
          "estimatedCost": [estimated cost],
          "location": [location,address]
        }
      ],
      "totalEstimatedCost": [estimated cost]
    },
    {
      "datePlanId": 1,
      "activities": [
        {
          "name": "[Activities you can generate suitable like - Kick off the [evening,morning or any other you can suggest] with [dinner,lunch or any other you can suggest] at [place name]]",
          "startTime": "[any time]",
          "durationHours": [1.5 or another duration] hours,
          "description": "[describe something in your words]",
          "estimatedCost": [estimated cost],
          "location": [location,address]    
        },
        {
          "name": "[Activities you can generate suitable like - Bowling at Whitestone Lanes]",
          "startTime": "[any time]",
          "durationHours": [1.5 or another duration] hours,
          "description": "[describe something in your words]",
          "estimatedCost": [estimated cost],
          "location": [location,address]
        },
        {
          "name": "[Activities you can generate suitable like - Dessert at Spot Dessert Bar]",
          "startTime": "[any time]",
          "durationHours": [1.5 or another duration] hours,
          "description": [describe something in your words]",
          "estimatedCost": [estimated cost],
          "location": [location,address]
        }
      ],
      "totalEstimatedCost": [estimated cost]
    },
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