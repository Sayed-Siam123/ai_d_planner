/*
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
];*/

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
    "ques" : "When is your date, and what time do you want to start?",
    "hint" : "Please enter time and date",
    "isMultipleSelect" : false,
    "isRequired" : true,
    "textFieldType" : "dateField",
    "options" : []
  },
  {
    "ques" : "When was the last time you planned a date that truly impressed your partner?",
    "isMultipleSelect" : false,
    "isRequired" : true,
    "textFieldType" : "text",
    "options" : [
      "It’s been a while",
      "I can’t remember",
      "I nail it every time (but could use some help)",
    ]
  },
  {
    "ques" : "What’s the hardest part about planning a date?",
    "isMultipleSelect" : false,
    "isRequired" : true,
    "textFieldType" : "text",
    "options" : [
      "Coming up with unique ideas.",
      "Finding something within my budget.",
      "Making sure my partner loves it.",
      "Juggling time to plan.",
      "Custom"
    ]
  },
  {
    "ques" : "Total Time Limit?",
    "isMultipleSelect" : false,
    "isRequired" : true,
    "textFieldType" : "text",
    "options" : [
      "2-3 hours",
      "3-5 hours",
      "5+ hours",
      "Full day"
    ]
  },
  {
    "ques" : "What kind of date are you planning?",
    "isMultipleSelect" : false,
    "isRequired" : true,
    "textFieldType" : "text",
    "options" : [
      "Food and activities.",
      "Food only.",
      "Activities only.",
      "Custom"
    ]
  },
  {
    "ques" : "Do you have a preference for indoor or outdoor activities?",
    "isMultipleSelect" : false,
    "isRequired" : true,
    "textFieldType" : "text",
    "options" : [
      "Indoor.",
      "Outdoor (like picnics, stargazing, and more).",
      "No preference."
    ]
  },
  {
    "ques" : "What’s the vibe you’re going for?",
    "isMultipleSelect" : false,
    "isRequired" : true,
    "textFieldType" : "text",
    "options" : [
      "Romantic and intimate.",
      "Adventurous and exciting.",
      "Relaxing and cozy.",
      "Energetic and fun.",
      "Custom"
    ]
  },
  {
    "ques" : "What does your partner enjoy most?",
    "isMultipleSelect" : true,
    "isRequired" : true,
    "textFieldType" : "text",
    "options" : [
      "Foodie spots 🍕",
      "Scenic views 🌅",
      "Outdoor adventures 🥾",
      "Unique experiences 🎨",
      "Relaxing activities 💆‍♀️",
      "Custom"
    ]
  },
  {
    "ques" : "What kind of food would you love for this date?",
    "isMultipleSelect" : true,
    "isRequired" : true,
    "textFieldType" : "text",
    "options" : [
      "Italian 🍝 (e.g., pasta, pizza)",
      "Mediterranean 🥗 (e.g., kebabs, falafel)",
      "Asian 🍣 (e.g., sushi, ramen, dim sum)",
      "Mexican 🌮 (e.g., tacos, burritos)",
      "American 🍔 (e.g., burgers, BBQ)",
      "Indian 🥘 (e.g., curry, naan)",
      "Seafood 🐟 (e.g., lobster, shrimp)",
      "Surprise me!",
      "Custom"
    ]
  },
  {
    "ques" : "What activities sound fun to you?",
    "isMultipleSelect" : true,
    "isRequired" : true,
    "textFieldType" : "text",
    "options" : [
      "Bowling 🎳",
      "Arcade games 🕹️",
      "Go-karting 🏎️",
      "Mini-golf ⛳",
      "Outdoor picnic 🌳",
      "Hiking or nature walk 🥾",
      "Rooftop dining or stargazing 🌃",
      "Surprise me!",
      "Custom"
    ]
  },
  {
    "ques" : "What’s your total budget for this date?",
    "isMultipleSelect" : false,
    "isRequired" : true,
    "textFieldType" : "text",
    "options" : [
      "\$50-\$100",
      "\$100-\$250",
      "\$250+",
      "Custom"
    ]
  },
  {
    "ques" : "Do you or your partner have any dietary preferences? (Optional)",
    "isMultipleSelect" : false,
    "isRequired" : false,
    "textFieldType" : "text",
    "options" : [
      "Vegetarian.",
      "Vegan.",
      "Halal",
      "Kosher.",
      "No restrictions.",
      "Custom"
    ]
  },
  {
    "ques" : "Want us to craft your dream date in seconds?",
    "isMultipleSelect" : false,
    "isRequired" : true,
    "textFieldType" : "text",
    "options" : [
      "Yes, show me!",
      "I’m curious to see what you’ve got."
    ]
  }
];
