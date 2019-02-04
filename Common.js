.pragma library

var strError = "ERR"
var strDisabled = "-"

function vDebugPrint(oObj)
{
    console.debug(oObj)
    for(var i in oObj)
    {
        if (oObj.hasOwnProperty(i))
            console.log(i, '=' + oObj[i])
    }
}

function oFindRoot(oObj) {
    while (oObj.parent) {
        oObj = oObj.parent;
    }
    return oObj;
}
function oFindAncestor(oItem, objectName) {
    while (oItem && oItem.objectName !== objectName)
        oItem = oItem.parent;
    return oItem;
}

function iFontPixelSize(strFontSize)
{
    switch (strFontSize)
    {
        case "switchValue": return 16
        case "switchValueLarge": return 24
        case "switchName": return 16
        case "infoLabel": return 20
        case "infoValueNormal": return 30
        case "infoValueLarge": return 44
        case "listItem": return 18
        case "listItemLarge": return 18
        case "textButton": return 20
        case "messageText": return 30
        case "messageTitle": return 50
        case "listHeader": return 14
        case "title": return 40
        case "premium.title": return 24;
        case "overlay": return 18
        case "sysInfo": return 19
        case "default": return 14
        case "ParamEditTitle": return 30
        case "ParamEditDescr": return 18
        case "hugeTextButton": return 50
        case "complexButton": return 24
        case "dateTime": return 24
    }
    return 14
}

var tableStyle = {}
tableStyle.header = {}
tableStyle.header.background="#bcbcbc"
tableStyle.header.text = "white"
tableStyle.header.border = "white"
tableStyle.row = {}
tableStyle.row.selected = {}
tableStyle.row.selected.background="#02ab50"
tableStyle.row.selected.text = "white"
tableStyle.row.odd = {}
tableStyle.row.odd.background="#d8d8d8"
tableStyle.row.even = {}
tableStyle.row.even.background="#bcbcbc"
tableStyle.row.text="black"

var premiumTableStyle = {}
premiumTableStyle.header = {}
premiumTableStyle.header.background="transparent"
premiumTableStyle.header.text = "white"
premiumTableStyle.header.border = "transparent"
premiumTableStyle.row = {}
premiumTableStyle.row.selected = {}
premiumTableStyle.row.selected.background="#bcbcbc"
premiumTableStyle.row.selected.text = "white"
premiumTableStyle.row.current = {}
premiumTableStyle.row.current.background="#0000ac"
//premiumTableStyle.row.current.background="#f39100"
premiumTableStyle.row.current.text = "white"
premiumTableStyle.row.odd = {}
premiumTableStyle.row.odd.background="transparent"
premiumTableStyle.row.even = {}
premiumTableStyle.row.even.background="transparent"
//premiumTableStyle.row.text="white"
premiumTableStyle.row.text="black"

var warningsList = {}
warningsList.columnWidth =
{
    type: 45,
    number: 60,
    status: 50,
    time: 145,
    description: 245
}

var premiumWarningsList = {}
premiumWarningsList.columnWidth =
{
    type: 45,
    number: 70,
    status: 100,
    time: 200,
    description: 250
}

var distanceControlList = {}
distanceControlList.columnWidth =
{
    name: 360,
    value: 100,
    measure: 70
}

var betriebsstundenList = {}
betriebsstundenList.columnWidth =
{
    name: 300,
    value: 200,
    unit: 30
}

var serviceDistanceControlList = {}
serviceDistanceControlList.columnWidth =
{
    name: 140,
    value: 100,
    measure: 60
}

var speedControlList = {}
speedControlList.columnWidth =
{
    number: 80,
    measure: 100,
    time: 80
}

var DynamicRowSpace = 4

var objectStorage = {}

function getObject(key) {
    var hash = key.toString()
    var object = objectStorage[hash]
    if (!object) {
        object = {}
        objectStorage[hash] = object
    }
    return object
}

var buttons =
{
    none: -1,
    plus: 1,
    minus: 2
}

var intervals =
{
    autoRepeatStart: 500,
    autoRepeatInterval: 100
}

var palette = {
    active: "white",
    inactive: "#bfbfbf",
    good: "#00bf00",
    bad: "#e50000",
}

function rClamp(rValue, rMin, rMax)
{
    var rNewValue = rValue
    if (rNewValue < rMin)
        rNewValue = rMin
    if (rNewValue > rMax)
        rNewValue = rMax
    return rNewValue
}

function point(x, y)
{
    return {x: x, y: y};
}
function range(min, max)
{
    return {min: min, max: max};
}

function circle(center, radius, angle)
{
    var x = center.x + radius * Math.sin(Math.PI * angle/ 180)
    var y = center.y - radius * Math.cos(Math.PI * angle/ 180)
    return point(x, y)
}

function rLinearInterpolation(rX, rX0, rX1, rY0, rY1)
{
    return rY0 + (rY1 - rY0) * (rX - rX0)/(rX1 - rX0)
}

function rLinearInterpolationWithRange(rX, valueRange, functionRange)
{
    var value = rClamp(rX, valueRange.min, valueRange.max);
    return rLinearInterpolation(value, valueRange.min, valueRange.max, functionRange.min, functionRange.max)
}

function formatIconUrl(template, argument) {
    return argument.length ? template.arg(argument) : ""
}

var dashboardStyle =
{
    background: "#8c8c8c",
    staticLine: { color: "white" },
    staticRectangle: { opacity: 0.5},
    oeldruckGauge: { textColor: "red" },
    waGauge: { textColor: "green" },
    motorGauge: { textColor: "black" },
    vakuumGauge: { textColor: "#ffd42a" },
    hochdruckGauge: { textColor: "#00b8ff" },
    posDuse: { valueFontSize: 60, textFontSize: 18 },
    smallGauge: { valueFontSize: 45, titleFontSize: 24, unitFontSize: 14, tickFontSize: 14 },
    bigGauge: { valueFontSize: 60, titleFontSize: 40, unitFontSize: 20, tickFontSize: 25 },
    schlammGauge: { color: "#ffd42a", labelFontSize: 14 },
    wasserGauge: { color: "#00b8ff", labelFontSize: 14 }
}

var premiumDashboardStyle =
{
    background: "#8c8c8c",
    staticLine: { color: "white" },
    staticRectangle: { opacity: 0.5 },
    oeldruckGauge: { textColor: "red" },
    waGauge: { textColor: "green" },
    motorGauge: { textColor: "white" },
    vakuumGauge: { textColor: "#ffd42a" },
    hochdruckGauge: { textColor: "#00b8ff" },
    posDuse: { valueFontSize: 60, textFontSize: 18 },
    smallGauge: { valueFontSize: 20, titleFontSize: 18, unitFontSize: 14, tickFontSize: 14 },
    bigGauge: { valueFontSize: 32, titleFontSize: 24, unitFontSize: 20, tickFontSize: 25 },
    schlammGauge: { color: "#ffd42a", labelFontSize: 14 },
    wasserGauge: { color: "#00b8ff", labelFontSize: 14 }
}

function check(func)
{
    if (func.condition())
    {
        var obj = {
            check: function(nestedFunc) { return obj; },
            value: function() { return func.value(); }
        }
        return obj
    }

    var result = {
        check: function (nestedFunc) { return check(nestedFunc); },
        value: function () { return undefined; }
    }
    return result
}
