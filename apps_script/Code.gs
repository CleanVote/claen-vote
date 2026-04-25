var SHEET_ID = "1D516teoXPZV8fkUUBbj8V6w_qn0cpMRH1lJZ6fgDJfQ";

function doGet(e) {
  try {
    var action = e.parameter.action;
    var ss = SpreadsheetApp.openById(SHEET_ID);
    var result = {success: false, error: "Unknown action: " + action};

    if (action == "register_user") {
      result = registerUser(ss, e.parameter);
    } else if (action == "vote") {
      result = recordVote(ss, e.parameter);
    } else if (action == "report") {
      result = submitReport(ss, e.parameter);
    } else if (action == "get_projects") {
      result = getProjects(ss);
    } else {
      result = {success: true, message: "Open Budget API is running"};
    }

    return ContentService.createTextOutput(JSON.stringify(result)).setMimeType(ContentService.MimeType.JSON);
  } catch (err) {
    return ContentService.createTextOutput(JSON.stringify({success: false, error: String(err)})).setMimeType(ContentService.MimeType.JSON);
  }
}

function registerUser(ss, u) {
  var sheet = getOrCreate(ss, "Users", ["user_id","full_name","pinfl","phone","region","district","mahalla","address","registered_at","has_voted","voted_project_id","season"]);
  var data = sheet.getDataRange().getValues();
  for (var i = 1; i < data.length; i++) {
    if (data[i][2] == u.pinfl) {
      return {success: true, user_id: data[i][0], already_voted: data[i][9], voted_project_id: data[i][10]};
    }
  }
  var id = "usr_" + Utilities.getUuid().substring(0, 8);
  sheet.appendRow([id, u.full_name, u.pinfl, u.phone, u.region, u.district, u.mahalla, u.address, new Date().toISOString(), false, "", "2026-Q2"]);
  return {success: true, user_id: id};
}

function recordVote(ss, v) {
  var users = ss.getSheetByName("Users");
  if (users) {
    var ud = users.getDataRange().getValues();
    for (var i = 1; i < ud.length; i++) {
      if (ud[i][0] == v.user_id) {
        if (ud[i][9] == true) {
          return {success: false, error: "Already voted"};
        }
        users.getRange(i + 1, 10).setValue(true);
        users.getRange(i + 1, 11).setValue(v.project_id);
        break;
      }
    }
  }
  var sheet = getOrCreate(ss, "Votes", ["vote_id","user_id","project_id","mahalla","voted_at","season"]);
  var id = "vote_" + Utilities.getUuid().substring(0, 8);
  sheet.appendRow([id, v.user_id, v.project_id, v.mahalla, new Date().toISOString(), "2026-Q2"]);
  return {success: true, vote_id: id};
}

function submitReport(ss, r) {
  var sheet = getOrCreate(ss, "Reports", ["report_id","topic","description","has_attachment","submitted_at"]);
  var id = "rpt_" + Utilities.getUuid().substring(0, 8);
  sheet.appendRow([id, r.topic, r.description, false, new Date().toISOString()]);
  return {success: true, report_id: id};
}

function getOrCreate(ss, name, headers) {
  var sheet = ss.getSheetByName(name);
  if (!sheet) {
    sheet = ss.insertSheet(name);
    sheet.appendRow(headers);
  }
  return sheet;
}

function setupSheets() {
  var ss = SpreadsheetApp.openById(SHEET_ID);
  getOrCreate(ss, "Users", ["user_id","full_name","pinfl","phone","region","district","mahalla","address","registered_at","has_voted","voted_project_id","season"]);
  getOrCreate(ss, "Votes", ["vote_id","user_id","project_id","mahalla","voted_at","season"]);
  getOrCreate(ss, "Reports", ["report_id","topic","description","has_attachment","submitted_at"]);
  getOrCreate(ss, "Projects", ["project_id","title","description","category","mahalla","district","location","budget_amount","budget_formatted","season","deadline","status","vote_count"]);
}

// 
