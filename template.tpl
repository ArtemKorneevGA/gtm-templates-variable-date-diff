___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Days, Hours or Minutes Between Two Dates (or Now)",
  "description": "The Template will return the amount of full days, hours, etc. between the first and the second date. \nYou can use this template for example to check if it is more than X days after previous event.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "timeFormat",
    "displayName": "Time format of two dates",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "milliseconds",
        "displayValue": "Unix time"
      }
    ],
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "defaultValue": "milliseconds",
    "help": "Currently supported only \u003ca href\u003d\"https://en.wikipedia.org/wiki/Unix_time\"\u003eUnix time\u003c/a\u003e, time in milliseconds elapsed since January 1, 1970 00:00:00 UTC. Result of \u003ca href\u003d\"https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/now\"\u003eDate.now()\u003c/a\u003e"
  },
  {
    "type": "TEXT",
    "name": "firstDate",
    "displayName": "First Date should be in milliseconds",
    "simpleValueType": true,
    "help": "Constant or GTM Variable in milliseconds elapsed since January 1, 1970 00:00:00 UTC. Result of \u003ca href\u003d\"https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/now\"\u003eDate.now()\u003c/a\u003efunction.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "SELECT",
    "name": "secondDateType",
    "displayName": "Compare to",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "now",
        "displayValue": "Now"
      },
      {
        "value": "otherDate",
        "displayValue": "Other Date"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "now",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Now will be a result of \u003ca href\u003d\"https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/now\"\u003eDate.now()\u003c/a\u003e. Other Date should be a constant or GTM variable returning \u003ca href\u003d\"https://en.wikipedia.org/wiki/Unix_time\"\u003eUnix time\u003c/a\u003e."
  },
  {
    "type": "TEXT",
    "name": "secondDate",
    "displayName": "Second Date should be in milliseconds",
    "simpleValueType": true,
    "help": "Constant or GTM Variable in milliseconds elapsed since January 1, 1970 00:00:00 UTC. Result of \u003ca href\u003d\"https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/now\"\u003eDate.now()\u003c/a\u003e",
    "enablingConditions": [
      {
        "paramName": "secondDateType",
        "paramValue": "otherDate",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "LABEL",
    "name": "label1",
    "displayName": "The Template will return the amount of full days, hours, etc. (set by unit field) between the first and the second date"
  },
  {
    "type": "SELECT",
    "name": "timeUnit",
    "displayName": "Time Unit in which dates will be compared",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "seconds",
        "displayValue": "Seconds"
      },
      {
        "value": "minutes",
        "displayValue": "Minutes"
      },
      {
        "value": "hours",
        "displayValue": "Hours"
      },
      {
        "value": "days",
        "displayValue": "Days"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "days",
    "help": "The Template will return the amount of full days, hours, etc. (set by unit field) between the first and the second date",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Enter your template code here.
const log = require("logToConsole");
const getTimestampMillis = require("getTimestampMillis");
const makeInteger = require("makeInteger");
const makeString = require("makeString");
const Math = require("Math");
log("data =", data);

const checkDateIsUnix = (time) => {
  return makeString(time).length <= 13 &&
    makeString(time) === makeString(makeInteger(makeString(time)))
    ? true
    : false;
};

const getUnitInMillis = (unit) => {
  switch (unit) {
    case "seconds":
      return 1000;
    case "minutes":
      return 1000 * 60;
    case "hours":
      return 1000 * 60 * 60;
    case "days":
      return 1000 * 60 * 60 * 24;
    default:
      log("Unsupported unit format");
      return false;
  }
};

const getDiffInUnit = (diff, unit) => {
  const result = Math.floor(diff / getUnitInMillis(unit));
  return result < 0 ? result + 1 : result;
};

const firstDate = makeInteger(data.firstDate);
log("firstDate", firstDate);

if (!checkDateIsUnix(data.firstDate)) {
  log(
    "Wrong firstDate format, expected milliseconds elapsed since January 1, 1970 00:00:00 UTC. Result of Date.now() function."
  );
  return false;
}

if (data.secondDateType === "now") {
  const now = getTimestampMillis();
  log("now =", now);

  return getDiffInUnit(now - firstDate, data.timeUnit);
} else {
  const secondDate = makeInteger(data.secondDate);
  log("secondDate", secondDate);
  if (secondDate && !checkDateIsUnix(data.secondDate)) {
    log(
      "Wrong secondDate format, expected milliseconds elapsed since January 1, 1970 00:00:00 UTC. Result of Date.now() function."
    );
    return false;
  }
  return getDiffInUnit(secondDate - firstDate, data.timeUnit);
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Wrong format first day
  code: |-
    mockData.firstDate = "1651286979590123";
    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(false);
- name: Wrong format first day 2
  code: |-
    mockData.firstDate = "2022-12-12";
    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(false);
- name: Check timediff in seconds
  code: |
    mockData.firstDate = "1651286977000";
    mockData.timeUnit = "seconds";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(2);
- name: Check timediff in seconds as number
  code: |
    mockData.firstDate = 1651286977000;
    mockData.timeUnit = "seconds";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(2);
- name: Check timediff in minutes
  code: |
    mockData.firstDate = "1651286677000";
    mockData.timeUnit = "minutes";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(5);
- name: Check timediff in hours
  code: |
    mockData.firstDate = "1651275877000";
    mockData.timeUnit = "hours";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(3);
- name: Check timediff in days
  code: |
    mockData.firstDate = "1651275877000";
    mockData.timeUnit = "days";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(0);
- name: Check timediff in days2
  code: |
    mockData.firstDate = "1556505877000";
    mockData.timeUnit = "days";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(1097);
- name: Check timediff in days3
  code: |
    mockData.firstDate = "1651200277000";
    mockData.timeUnit = "days";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(1);
- name: First date more than now
  code: |
    mockData.firstDate = "1651287639000";
    mockData.timeUnit = "days";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(0);
- name: First date more than now 2
  code: |
    mockData.firstDate = "1651633239000";
    mockData.timeUnit = "days";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(-4);
- name: Wrong format second day
  code: |
    mockData.firstDate = "1556505877000";
    mockData.timeUnit = "days";
    mockData.secondDateType = "otherDate";
    mockData.secondDate = "1556505877000123";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(false);
- name: Check timediff in days between first and second date
  code: |
    mockData.firstDate = "1651633239001";
    mockData.timeUnit = "days";
    mockData.secondDateType = "otherDate";
    mockData.secondDate = "1651806039000";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(1);
setup: |-
  const mockData = {"secondDateType":"now","timeFormat":"milliseconds","firstDate":"1651286979590","timeUnit":"days","gtmEventId":3};

  mock('getTimestampMillis', 1651286979590);


___NOTES___

Created on 30/04/2022, 17:41:58


