import 'package:ai_d_planner/app/data/models/gemini_response.dart';
import 'package:ai_d_planner/app/data/models/plan_from_ai_model.dart';
import 'package:ai_d_planner/app/network/api_client.dart';
import 'package:ai_d_planner/app/network/api_end_points.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/widgets/app_widgets.dart';

class GeminiRepo{
  GeminiRepo();

  final client = ApiClient(customBaseUrl: ApiEndPoints.baseUrlGemini);

  static String dataString({required String location, required String date,required String time}) =>
      """Answer only using your current data to the best of your ability.\n\n•⁠  ⁠Given:\n\n    - location: Tongi Government College, College Road, Tongi, Gazipur.\n\n    - Maximum distance radius: 5 mile. Time limit: 5 hours.\n\n    - Preferred date: 31 January, 2025. \n\n    - Preferred start time: 4pm.\n\n    - Date Type: Food and Activities.\n\n    - Preferred cuisine(if food mentioned in date type): Mediterranean Kebabs, Italian, surprise me.\n\n    - Preferred Activities(if activities mentioned in date type): Nothing.\n\n    - Date Mood: Energetic and fun.\n\n    - Total combined budget: 5000 BDT.\n\n•⁠  ⁠Generate 3 distinct comprehensive date plans with each activity/ event in order and with start time and duration mentioned for each. Ensure to strictly adhere to location, radius, and budget. But for others, if there are no good matches within the location, radius, and budget, then improvise. Ensure for any cost mentioned, it is for 2 people combined, and not only per person. Give in a proper format. It is fine if it is hypothetical and not real time date plan, as long as you use real places that existed as of your last knowledge. Do not include any other information and only give response in format below for each of the dates. the structure needs to be this but content can vary and so can each of the events, however give proper location for each according to your last knowledge. Format:\n\n•⁠  ⁠Date Plan 1:\n\n    - Activity 1: A at X. Start Time:  PM. Duration:  hour. Description:  (Estimated Cost: \$). Location: .\n\n    - Activity 2: Y at C. Start Time: PM. Duration: hours. Description: (Estimated Cost: \$). Location: .\n\n    - Activity 3: E at F. Start Time: PM. Duration: hour. Description: (Estimated Cost: \$10). Location:\n\n    - Estimated Total Cost (Date Plan 1): \$. \n\n{\n  \"plans\": [\n    {\n      \"datePlanId\": 1,\n      \"activities\": [\n        {\n          \"name\": \"Dinner at The Italian Place (hypothetical)\",\n          \"startTime\": \"6:00 PM\",\n          \"durationHours\": 2,\n          \"description\": \"Enjoy a delicious Italian dinner.\",\n          \"estimatedCost\": 20,\n          \"location\": \"A hypothetical Italian restaurant in Tongi, near the college.\"\n        },\n        {\n          \"name\": \"Ice Cream and stroll at Tongi Park\",\n          \"startTime\": \"8:00 PM\",\n          \"durationHours\": 1,\n          \"description\": \"Enjoy a relaxed evening stroll in the park and have some ice cream.\",\n          \"estimatedCost\": 10,\n          \"location\": \"Tongi Park, Gazipur.\"\n        },\n        {\n          \"name\": \"Street Food at a roadside stall (hypothetical)\",\n          \"startTime\": \"9:00 PM\",\n          \"durationHours\": 1,\n          \"description\": \"Enjoy some late-night street food.\",\n          \"estimatedCost\": 10,\n          \"location\": \"A hypothetical street food stall near Tongi.\"\n        }\n      ],\n      \"totalEstimatedCost\": 40\n    },\n    {\n      \"datePlanId\": 2,\n      \"activities\": [\n        {\n          \"name\": \"Dinner at a Mediterranean restaurant (hypothetical)\",\n          \"startTime\": \"6:00 PM\",\n          \"durationHours\": 2,\n          \"description\": \"Try some Mediterranean kebabs.\",\n          \"estimatedCost\": 25,\n          \"location\": \"A hypothetical Mediterranean restaurant in Tongi.\"\n        },\n        {\n          \"name\": \"Karaoke Night at a local Karaoke place (hypothetical)\",\n          \"startTime\": \"8:30 PM\",\n          \"durationHours\": 2,\n          \"description\": \"Sing your hearts out with your date.\",\n          \"estimatedCost\": 20,\n          \"location\": \"A hypothetical Karaoke place near Tongi.\"\n        },\n        {\n          \"name\": \"Enjoy a rickshaw ride at Tongi (hypothetical)\",\n          \"startTime\": \"10:30 PM\",\n          \"durationHours\": 1,\n          \"description\": \"Enjoy a fun ride.\",\n          \"estimatedCost\": 10,\n          \"location\": \"Tongi.\"\n        }\n      ],\n      \"totalEstimatedCost\": 55\n    },\n    {\n      \"datePlanId\": 3,\n      \"activities\": [\n        {\n          \"name\": \"Dinner at a Restaurant (hypothetical)\",\n          \"startTime\": \"6:00 PM\",\n          \"durationHours\": 2,\n          \"description\": \"Enjoy dinner.\",\n          \"estimatedCost\": 20,\n          \"location\": \"A hypothetical restaurant in Tongi.\"\n        },\n        {\n          \"name\": \"Visit a local park (hypothetical)\",\n          \"startTime\": \"8:00 PM\",\n          \"durationHours\": 2,\n          \"description\": \"Spend some time at the park, maybe play some games if available.\",\n          \"estimatedCost\": 5,\n          \"location\": \"A hypothetical local park near Tongi.\"\n        },\n        {\n          \"name\": \"Enjoy dessert at a shop (hypothetical)\",\n          \"startTime\": \"10:00 PM\",\n          \"durationHours\": 1,\n          \"description\": \"Enjoy desserts.\",\n          \"estimatedCost\": 10,\n          \"location\": \"A hypothetical dessert shop in Tongi.\"\n        }\n      ],\n      \"totalEstimatedCost\": 35\n    }\n  ]\n}""";

  Future<GeminiResponse?> getPlansFromGemini({String? location, String? date,String? time}) async{
    var response = await client.post(
        ApiEndPoints.getPrompt,
        {
          "contents": [
            {
              "parts": [
                {
                  "text": dataString(location: location!,date: date!,time: time!)
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