var getQuestionPageDummy = [
  {
    "ques" : "Your date location",
    "hint" : "Pick your location",
    "isMultipleSelect" : false,
    "textFieldType" : "location",
    "options" : []
    //this will be text_field widget - isMultipleSelect --> false and options would be empty
  },
  {
    "ques" : "Date details",
    "hint" : "Date time and date",
    "isMultipleSelect" : false,
    "textFieldType" : "dateField",
    "options" : []
    //this will be text_field widget - isMultipleSelect --> false and options would be empty
  },
  {
    "ques" : "What’s your vibe for this date?",
    "isMultipleSelect" : true,
    "textFieldType" : "text",
    "options" : [
      "❤️Romantic",
      "😌Casual",
      "🍹Chill",
      "🧗Adventure",
      "Custom"
    ],
    //this will be text_field widget - options selection is custom, then isMultipleSelect will work like false and will show a text_field,else mcq question
  },
  {
    "ques" : "What’s your budget?",
    "isMultipleSelect" : false,
    "textFieldType" : "text",
    "options" : [
      "\$50 - \$150",
      "\$150 - \$500",
      "\$500 - \$1500",
      "Custom"
    ]
  },
  {
    "ques" : "How far are you willing to travel?",
    "isMultipleSelect" : false,
    "textFieldType" : "text",
    "options" : [
      "🚶Nearby (5–10 miles)",
      "🚗Citywide (far from the distance)",
      "🌍Open to exploring",
      "Custom"
    ]
  },
  {
    "ques" : "Should I sprinkle in some surprises?",
    "isMultipleSelect" : false,
    "textFieldType" : "text",
    "options" : [
      "🎉 Yes",
      "No, stick to the plan",
      "Custom"
    ]
  }
];