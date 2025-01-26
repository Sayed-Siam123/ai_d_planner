var getQuestionPageDummy = [
  {
    "ques" : "Your date location",
    "hint" : "Please write down your address",
    "isMultipleSelect" : false,
    "isRequired" : true,
    "textFieldType" : "text",
    "options" : []
    //this will be text_field widget - isMultipleSelect --> false and options would be empty
  },
  {
    "ques" : "Date details",
    "hint" : "Date time and date",
    "isMultipleSelect" : false,
    "isRequired" : true,
    "textFieldType" : "dateField",
    "options" : []
    //this will be text_field widget - isMultipleSelect --> false and options would be empty
  },
  {
    "ques" : "What’s your vibe for this date?",
    "isMultipleSelect" : true,
    "isRequired" : true,
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
    "isRequired" : true,
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
    "isRequired" : true,
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
    "isRequired" : true,
    "textFieldType" : "text",
    "options" : [
      "🎉 Yes",
      "No, stick to the plan",
      "Custom"
    ]
  }
];

var preSetDataDummy = [
  {
    "ques": "Your date location",
    "hint": "Pick your location",
    "isMultipleSelect": false,
    "isRequired": true,
    "options": [],
    "selected": [
      {
        "optionID": -1,
        "option": "New York"
      }
    ]
  },
  {
    "ques": "Date details",
    "hint": "Date time and date",
    "isMultipleSelect": false,
    "isRequired": true,
    "options": [],
    "selected": [
      {
        "optionID": -1,
        "option": "2025-01-26 12:23:02.111265"
      }
    ]
  },
  {
    "ques": "What’s your vibe for this date?",
    "hint": null,
    "isMultipleSelect": true,
    "isRequired": true,
    "options": [
      "❤️Romantic",
      "😌Casual",
      "🍹Chill",
      "🧗Adventure",
      "Custom"
    ],
    "selected": [
      {
        "optionID": 0,
        "option": "❤️Romantic"
      }
    ]
  },
  {
    "ques": "What’s your budget?",
    "hint": null,
    "isMultipleSelect": false,
    "isRequired": true,
    "options": [
      "\$50 - \$150",
      "\$150 - \$500",
      "\$500 - \$1500",
      "Custom"
    ],
    "selected": [
      {
        "optionID": 0,
        "option": "\$50 - \$150"
      }
    ]
  },
  {
    "ques": "How far are you willing to travel?",
    "hint": null,
    "isMultipleSelect": false,
    "isRequired": true,
    "options": [
      "🚶Nearby (5–10 miles)",
      "🚗Citywide (far from the distance)",
      "🌍Open to exploring",
      "Custom"
    ],
    "selected": [
      {
        "optionID": 0,
        "option": "🚶Nearby (5–10 miles)"
      }
    ]
  },
  {
    "ques": "Should I sprinkle in some surprises?",
    "hint": null,
    "isMultipleSelect": false,
    "isRequired": true,
    "options": [
      "🎉 Yes",
      "No, stick to the plan",
      "Custom"
    ],
    "selected": [
      {
        "optionID": 0,
        "option": "🎉 Yes"
      }
    ]
  }
];