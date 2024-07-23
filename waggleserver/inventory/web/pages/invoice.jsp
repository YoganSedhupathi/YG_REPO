<!DOCTYPE HTML>
<html>

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Invoice</title>
</head>

<body>
  <script src="js/inputvalidation.js"></script>
  <script src="js/attributedialog.js"></script>
  <script src="js/serialentrydialog.js"></script>
  <script src="js/tenderdialog.js"></script>
  <script>
<% String mode = request.getParameter("mode");
String code = request.getParameter("code");
String userId = (String)session.getAttribute("LOGIN_ID");
%>


var userName = '<%=userId%>';
  </script>


  <div class="card border-0 shadow">
    <div class="card-body lpage">
      <!--Header-->
      <div class="row w-100">
        <div class="col-md-6 d-flex align-items-center">
          <h4 class="header-title">Sales Invoice </h4>
        </div>
        <div  class="col-md-6 text-right">
          <div class="dropdown">
            <button class="btn btn-clear dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
              <span class="mdi mdi-menu-open"></span>
            </button>
            <ul id="submenu" class="dropdown-menu" aria-labelledby="dropdownMenuButton1"></ul>
          </div>
        </div>
      </div>
      <!--Header End-->
      <!--Listing -->
      <div class="row lpage" id="jqcontainer" style="display:none;">
        <div class="table-container">
          <div id="xyz" class="w-100">

          </div>
        </div>
      </div>
      <!--Listing End-->
      <!--Content Start-->
      <div id="callback" class="mt-3">
        <div id="divHide">
          <div id="divFirst" style="display:block">
            <div class="row w-100">
              <div class="col-sm-6 col-md-6 col-lg-6">
                <div id="group1" class=""></div>
              </div>
              <div class="col-sm-6 col-md-6 col-lg-6">
                <div id="group2" class="">
                </div>
              </div>
              <div class="col-sm-4 col-md-4 col-lg-4">
                <div id="billdetail" class="">
                </div>
              </div>
              <div class="col-sm-4 col-md-4 col-lg-4">
                <div id="dummyDiv" class="">
                </div>
              </div>
            </div>
          </div>
          <div id="divTransport" style="display:none">
            <div class="row w-100">
              <div class="col-sm-4 col-md-4 col-lg-4">
                <div id="group4" class=""></div>
              </div>
              <div class="col-sm-4 col-md-4 col-lg-4">
                <div id="lrdet" class=""></div>
              </div>
              <div class="col-sm-4 col-md-4 col-lg-4">
                <div id="dummyDiv1" class=""></div>
              </div>
            </div>
          </div>
        </div>
        <div class="hstack justify-content-end">
          <span id="showMoreButton" class="" onclick="showHideTransport()"><b id="transbutton"
              class="labelText">More...</b></span>
        </div>
        <div class="row">
          <div class="table-container">
            <div class="col-md-12 col-sm-12 garea" id="invoice"></div>
            <div id="group3" style="display:none;"></div>
          </div>
        </div>
        <div class="row w-100 mt-3">
          <div class="col-md-6">
            <div class="hstack justify-content-start">
              <div id="saveGrp">
              </div>
            </div>
          </div>

          <div class="col-md-6">
            <div class="hstack justify-content-end">
              <div class="p-2 hstack gap-2 bg-white shadow-sm rounded-3">
                  <div class="hstack gap-2 card-dicount px-3 bg-custom rounded-3">
                      <h6 class="dicount-type hstack gap-1">
                          <span class="text-custom">Gross Amount:</span>
                          <span class="amount-text" id="gross"></span>
                      </h6>
                    <div class="vr align-self-auto"></div>
                    <h6 class="dicount-type hstack gap-1">
                          <span class="text-custom">Disc:</span>
                          <span class="amount-text" id="disc"></span>
                      </h6>
                    <div class="vr align-self-auto"></div>
                      <h6 class="dicount-type hstack gap-1">
                          <span class="text-custom">VAT:</span>
                          <span class="amount-text" id="vat"></span>
                      </h6>
                  </div>
                  <div class="card-total px-3 rounded-3">
                    <h5 class="dicount-type hstack gap-1">
                      <span class="text-dark"><b>Net Amount&nbsp;:</b></span>
                      <span class="net-amount" id="netAmt"></span>
                  </h5>
                  </div>
                    <div class="col-md-8" style="display:none"><label id="totalamt"></label></div>
              </div>
           </div>
        </div>
        </div>

        <!--Content End-->
      </div>
    </div>
  </div>



  <div id='attrdlg'>
    <div id='productprops' class="pop_lov_box" style="height:250px;display:none" />
  </div>
  <div id='serialdlg'>
    <div id='productserial' class="pop_lov_box" style="height:250px;display:none" />
  </div>
  <div id='ttender' style="display:none"></div>
  <div id='tenderdlg' tabindex='-1' role='dialog' class="modal" aria-hidden='true'></div>

  <div id='showprescription' style="display:none">
    <div id='prescriptiondlg' class='pop_lov_box'>
      <div id='prestitle' class='pop_lov_hed_box'>
        <div class='pop_lov_clos'><a href='#'><span class='fa fa-times-circle'></span></a></div>
        <div class='pop_lov_hed_txt'>Prescription</div>
      </div>
      <div id='prescription' class='pop_lov_inp_box'>
        <table class="table" cellspacing=0 cellpadding=0 border=0 style="min-height:400px">
          <thead>
            <tr>
              <th>S.No</th>
              <th>Name</th>
              <th>Generic</th>
              <th>Morning</th>
              <th>Afternoon</th>
              <th>Evening</th>
              <th>Night</th>
              <th>After/Before Meal</th>
              <th>Days</th>
              <th>Notes</th>
            </tr>
          </thead>
          <tbody id="presitems">
          </tbody>
        </table>
        <div id='presbutton' style='float:right'><button type='button' class='btn btn-primary mRhAj'
            onclick="printPrescription()">Print</button><button type='button' class='btn btn-default'
            onclick="prescrCancel()">Cancel</button></div>
      </div>
    </div>
  </div>
  <script>
    $('.butt_sav').click(function (e) {
      e.preventDefault();
    });
    $('.butt_can').click(function (e) {
      e.preventDefault();
    });
    var l = new FlexUI.Ajax();
    var v = l.callAjax("GET", "/inventory/service/ajax", "ic=0&id=userdefbranch,config,custtype&configname=showmore");
    var defbranch = v.data.userdefbranch;
    var showMore = v.data.config[0][0] == 1 ? true : false;
    var showExpiry = false;
    var ew = 0;
    if (showExpiry) {
      ew = 100;
    }
    var cKeys = "All";
    var cValues = "0";
    var tilled = "~";
    if (!showMore) {
      $('#showMoreButton').css('display', 'none');
      $('#one').removeClass('col-sm-5 col-md-5 col-lg-5');
      $('#one').css('margin-top', '20px');
      $('#one').addClass('col-sm-8 col-md-8 col-lg-8');
      $('#three').css('display', 'none');
      $('#four').css('display', 'none');
      cKeys = "";
      cValues = "";
      tilled = "";
    }
    if (v.data.custtype.length > 0) {
      for (var m = 0; m < v.data.custtype.length; m++) {
        cKeys = cKeys + tilled + v.data.custtype[m][0];
        cValues = cValues + tilled + v.data.custtype[m][1];
        tilled = "~";
      }
    }

    var sProps = {
      title: { height: 25, width: 100, name: "Invoice" }, container: { id: "callback", isdialog: false }, js: "js/validations/invoice.js", screen: [
        {
          name: "group1", title: "", pcolumns: 0, height: 30, width: 98, minWidth: 500, minHeight: 200, colWidth: 45, float: "left", backColor: "biege", contentType: "Fields",
          fields: [{ colno: 0, name: "code", inputType: 0, type: "INT", caption: "Code", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "chkTag": false, nf: "branch" },
          { colno: 0, name: "name", inputType: 0, type: "TEXT", caption: "Name", mandatory: false, defaultValue: "", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "chkTag": false, nf: "branch" },
          { colno: 0, name: "mobile", inputType: 0, type: "TEXT", caption: "Mobile", mandatory: true, defaultValue: "", "maxValue": 0, "textLength": 30, "decimalLength": 0, "visible": false, "readOnly": false, "chkTag": false, nf: "billdate", validation: "fetchCustomer" },
          { colno: 0, name: "custtype", inputType: 1, type: "TEXT", caption: "Type", mandatory: true, defaultValue: "0", "maxValue": 0, "textLength": 100, "decimalLength": 0, "visible": false, "readOnly": true, "chkTag": false, nf: "custname", keys: cKeys, values: cValues, onchange: "validateCustType", validation: "validateCustType" },
          { colno: 0, name: "custalias", inputType: 0, type: "LOV", caption: "Alias", mandatory: false, defaultValue: "", "maxValue": 0, "textLength": 100, "decimalLength": 0, "visible": false, "readOnly": false, "chkTag": true, nf: "billdate", lovOptions: { url: "/inventory/service/ajax", ajax: "customer", scrollEnabled: true, searchFromList: false, dsi: 8, params: [{ n: "custtype", src: "custtype", ft: false }], results: [{ tgt: "custname", tt: true, id: "0" }, { tgt: "name", tt: false, id: "1" }, { tgt: "custname", tt: false, id: "1" }, { tgt: "mobile", tt: false, id: "2" }, { tgt: "address", tt: false, id: "3,4,5,6", m: true }, { tgt: "address1", tt: false, id: "3" }, { tgt: "address2", tt: false, id: "4" }, { tgt: "city", tt: false, id: "5" }, { tgt: "pincode", tt: false, id: "6" }, { tgt: "creditdays", tt: false, id: "7" }, { tgt: "showcreditdays", tt: false, id: "7" }, { tgt: "custalias", tt: false, id: "8" }, { tgt: "custalias", tt: true, id: "8" }, { tgt: "prfcode", tt: false, id: "9" }, { tgt: "professional", tt: true, id: "10" }, { tgt: "professional", tt: false, id: "10" }] }, validation: "validateCustomerAlias" },
          { colno: 0, name: "custname", inputType: 0, type: "LOV", caption: "Name", mandatory: true, defaultValue: "0", "maxValue": 0, "textLength": 100, "decimalLength": 0, "visible": true, "readOnly": false, "chkTag": true, "saveTag": true, nf: "billdate", lovOptions: { url: "/inventory/service/ajax", ajax: "customer", scrollEnabled: true, searchFromList: false, dsi: 2, params: [{ n: "custtype", src: "custtype", ft: false }], results: [{ tgt: "custname", tt: true, id: "0" }, { tgt: "name", tt: false, id: "1" }, { tgt: "custname", tt: false, id: "1" }, { tgt: "mobile", tt: false, id: "2" }, { tgt: "address", tt: false, id: "3,4,5,6", m: true }, { tgt: "address1", tt: false, id: "3" }, { tgt: "address2", tt: false, id: "4" }, { tgt: "city", tt: false, id: "5" }, { tgt: "pincode", tt: false, id: "6" }, { tgt: "creditdays", tt: false, id: "7" }, { tgt: "showcreditdays", tt: false, id: "7" }, { tgt: "custalias", tt: false, id: "8" }] }, validation: "validateCustName" },
          { colno: 0, name: "address", inputType: 4, type: "SPAN", caption: "Address", mandatory: false, defaultValue: "", "maxValue": 0, "textLength": 100, "decimalLength": 0, "visible": true, "readOnly": true, "chkTag": false, nf: "address2" },
          { colno: 0, name: "address1", inputType: 0, type: "TEXT", caption: "Building", mandatory: false, defaultValue: "", "maxValue": 0, "textLength": 100, "decimalLength": 0, "visible": false, "readOnly": true, "chkTag": false, nf: "address2" },
          { colno: 0, name: "address2", inputType: 0, type: "TEXT", caption: "Street", mandatory: false, defaultValue: "", "maxValue": 0, "textLength": 100, "decimalLength": 0, "visible": false, "readOnly": true, "chkTag": false, nf: "city" },
          { colno: 0, name: "city", inputType: 0, type: "TEXT", caption: "City", mandatory: false, defaultValue: "", "maxValue": 0, "textLength": 50, "decimalLength": 0, "visible": false, "readOnly": true, "chkTag": false, nf: "pincode" },
          { colno: 0, name: "pincode", inputType: 0, type: "TEXT", caption: "PinCode", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "chkTag": false, nf: "billdate" },
          { colno: 0, name: "creditdays", inputType: 0, type: "INT", caption: "Credit Days", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": false, "chkTag": false, nf: "salesman" },
          { colno: 0, name: "showcreditdays", inputType: 4, type: "INT", caption: "Credit", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": false, "chkTag": false, nf: "salesman" }
          ]
        },
        {
          name: "branch", title: "", pcolumns: 0, height: 30, width: 98, minWidth: 500, minHeight: 200, colWidth: 45, float: "left", backColor: "biege", contentType: "Fields",
          fields: [{ colno: 0, name: "branch", inputType: 0, type: "LOV", caption: "", mandatory: true, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": false, "chkTag": true, nf: "location", lovOptions: { url: "/inventory/service/ajax", ajax: "userbranch", scrollEnabled: true, searchFromList: false, dsi: 0, params: [], results: [{ tgt: "branch", tt: true, id: "1" }, { tgt: "branch", tt: false, id: "0" }, { tgt: "location", tt: false, id: "5" }, { tgt: "location", tt: true, id: "6" }] } },
          { colno: 0, name: "location", inputType: 0, type: "LOV", caption: "", mandatory: true, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": false, "chkTag": true, nf: "custname", lovOptions: { url: "/inventory/service/ajax", ajax: "branchlocations", scrollEnabled: true, searchFromList: false, dsi: 0, params: [{ n: "branch", src: "branch", ft: true }], results: [] } }
          ]
        },
        {
          name: "group2", title: "", pcolumns: 0, height: 30, width: 98, minWidth: 500, minHeight: 200, colWidth: 33, float: "left", backColor: "biege", contentType: "Fields",
          fields: [
            { colno: 0, name: "billtype", inputType: 1, type: "TEXT", caption: "Bill Type", keys: "Cash~Credit~Credit Card~Coupon~Cheque~Split", values: "CA~CR~CC~CO~CQ~SP", defaultValue: "C", "readOnly": false, "chkTag": false, nf: "billdate", visible: false },
            { colno: 0, name: "billno", inputType: 0, type: "INT", caption: "Bill No", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "chkTag": false, nf: "billdate" },
            { colno: 0, name: "showbillno", inputType: 4, type: "INT", caption: "Bill No", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": true, "chkTag": false, nf: "billdate" },
            { colno: 0, name: "billdate", inputType: 0, type: "DATE", caption: "Bill Date", format: "dd/mm/yyyy", defaultValue: "", "chkTag": false, visible: true, nf: "salesman" },
            { colno: 0, name: "salesman", inputType: 0, type: "LOV", caption: "Salesman", mandatory: false, defaultValue: "", "visible": true, "readOnly": false, "chkTag": false, nf: "invoice_data", lovOptions: { url: "/inventory/service/ajax", ajax: "employee", scrollEnabled: true, searchFromList: false, dsi: 0, params: [], results: [{ tgt: "salesman", tt: false, id: "0" }, { tgt: "salesman", tt: true, id: "1" }, { tgt: "empid", tt: false, id: "2" }] } },
            { colno: 0, name: "empid", inputType: 0, type: "INT", caption: "EmpId", mandatory: false, defaultValue: "0", "visible": false, "readOnly": false, "chkTag": false, nf: "" },
            { colno: 0, name: "professional", inputType: 0, type: "LOV", caption: "Professional", mandatory: false, defaultValue: "", "visible": true, "readOnly": false, "chkTag": true, saveTag: false, nf: "invoice_data", lovOptions: { url: "/inventory/service/ajax", ajax: "professional", scrollEnabled: true, searchFromList: false, cs: 0, dsi: 0, params: [], results: [{ tgt: "professional", tt: false, id: "0" }, { tgt: "professional", tt: true, id: "1" }, { tgt: "prfcode", tt: true, id: "1" }] } },
            { colno: 0, name: "prfcode", inputType: 0, type: "INT", caption: "Prfcode", mandatory: false, defaultValue: "0", "visible": false, "readOnly": false, "chkTag": false, nf: "" },
            { colno: 0, name: "despthro", inputType: 0, type: "LOV", caption: "Transport", mandatory: false, defaultValue: "", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": false, "chkTag": false, nf: "pf", colspan: 2, lovOptions: { url: "/inventory/service/ajax", ajax: "transport", scrollEnabled: true, searchFromList: false, dsi: 0, params: [], results: [] } }
          ]
        },
        {
          name: "billdetail", title: "", pcolumns: 0, height: 30, width: 98, minWidth: 500, minHeight: 200, colWidth: 33, float: "left", backColor: "biege", contentType: "Fields",
          fields: [
            { colno: 0, name: "dcno", inputType: 0, type: "INT", caption: "DC No", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": false, "chkTag": false, nf: "dcdate" },
            { colno: 0, name: "dcdate", inputType: 0, type: "DATE", caption: "DC Date", format: "dd/mm/yyyy", defaultValue: "", "chkTag": false, visible: false, nf: "ordertype" },
            { colno: 0, name: "ordertype", inputType: 1, type: "TEXT", caption: "Order Type", mandatory: false, defaultValue: "", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": false, "chkTag": false, nf: "sono", keys: "Direct Sale~Sales Order", values: "DS~SO", defaultValue: "SE" },
            { colno: 0, name: "sono", inputType: 0, type: "INT", caption: "SO No", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "chkTag": false, nf: "sodate" },
            { colno: 0, name: "sosno", inputType: 0, type: "INT", caption: "SO No", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "chkTag": false, nf: "sodate" },
            { colno: 0, name: "sodate", inputType: 0, type: "DATE", caption: "SO Date", format: "dd/mm/yyyy", defaultValue: "", "chkTag": false, visible: false, nf: "despthro" },
            { colno: 0, name: "showordertype", inputType: 4, type: "TEXT", caption: "Order Type", value: "Direct Sale", mandatory: false, defaultValue: "", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": false, "chkTag": false, nf: "sono", keys: "Direct Sale~Sales Order", values: "DS~SO", defaultValue: "SE" },
            { colno: 0, name: "showsono", inputType: 4, type: "INT", caption: "SO No", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": true, "chkTag": false, nf: "sodate" },
            { colno: 0, name: "showsodate", inputType: 4, type: "DATE", caption: "SO Date", format: "dd/mm/yyyy", defaultValue: "", "chkTag": false, visible: true, nf: "despthro" }
          ]
        }, {
          name: "dummyDiv", title: "", pcolumns: 0, height: 30, width: 98, minWidth: 500, minHeight: 200, colWidth: 33, float: "left", backColor: "biege", contentType: "Fields",
          fields: [
            { name: "dummy1", inputType: 4, type: "TEXT", caption: "", keys: "Cash~Cheque", values: "C~Q", defaultValue: "C", "readOnly": false, "chkTag": false, nf: "documents", visible: true },
            { name: "dummy2", inputType: 4, type: "TEXT", caption: "", keys: "Cash~Cheque", values: "C~Q", defaultValue: "C", "readOnly": false, "chkTag": false, nf: "documents", visible: true },
            { name: "dummy3", inputType: 4, type: "TEXT", caption: "", keys: "Cash~Cheque", values: "C~Q", defaultValue: "C", "readOnly": false, "chkTag": false, nf: "documents", visible: true }
          ]
        },
        {
          name: "dummyDiv1", title: "", pcolumns: 0, height: 30, width: 98, minWidth: 500, minHeight: 200, colWidth: 33, float: "left", backColor: "biege", contentType: "Fields",
          fields: [
            { name: "dummy4", inputType: 4, type: "TEXT", caption: "", keys: "Cash~Cheque", values: "C~Q", defaultValue: "C", "readOnly": false, "chkTag": false, nf: "documents", visible: true },
            { name: "dummy5", inputType: 4, type: "TEXT", caption: "", keys: "Cash~Cheque", values: "C~Q", defaultValue: "C", "readOnly": false, "chkTag": false, nf: "documents", visible: true },
            { name: "dummy6", inputType: 4, type: "TEXT", caption: "", keys: "Cash~Cheque", values: "C~Q", defaultValue: "C", "readOnly": false, "chkTag": false, nf: "documents", visible: true }
          ]
        },
        {
          name: "transport", title: "", pcolumns: 0, height: 30, width: 98, minWidth: 500, minHeight: 200, colWidth: 33, float: "left", backColor: "biege", contentType: "Fields",
          fields: [
            { colno: 0, name: "documents", inputType: 0, type: "TEXT", caption: "Documents", mandatory: false, defaultValue: "", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": false, "chkTag": false, nf: "paymode" },
            { colno: 0, name: "paymode", inputType: 1, type: "TEXT", caption: "Payment Mode", keys: "Cash~Cheque", values: "C~Q", defaultValue: "C", "readOnly": false, "chkTag": false, nf: "lrno", visible: false },
            { colno: 0, name: "pf", inputType: 0, type: "DECIMAL", caption: "P&F", mandatory: false, defaultValue: "0", "maxValue": 99999.99, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": false, "chkTag": false, nf: "discount", colspan: 2, onchange: "onTaxChange" },
            { colno: 0, name: "cdisc", inputType: 0, type: "DECIMAL", caption: "Cash Disc%", mandatory: false, defaultValue: "0", "maxValue": 99.99, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": false, "chkTag": false, nf: "invoice_data", colspan: 2, onchange: "" },
            { colno: 0, name: "cdiscamt", inputType: 0, type: "DECIMAL", caption: "Cash Disc Amt", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 2, "visible": false, "readOnly": false, "chkTag": false, nf: "invoice_data", colspan: 2, onchange: "" }
          ]
        },
        {
          name: "lrdet", title: "", pcolumns: 0, height: 30, width: 98, minWidth: 500, minHeight: 200, colWidth: 33, float: "left", backColor: "biege", contentType: "Fields",
          fields: [
            { colno: 0, name: "lrno", inputType: 0, type: "TEXT", caption: "LR No", mandatory: false, defaultValue: "NA", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": false, "chkTag": false, nf: "lrdate" },
            { colno: 0, name: "lrdate", inputType: 0, type: "DATE", caption: "LR Date", format: "dd/mm/yyyy", defaultValue: "", "chkTag": false, visible: true, nf: "creditdays" },
            { colno: 0, name: "go", inputType: 3, caption: "Go", onclick: "calculateCashDiscount", visible: true }
          ]
        },
        {
          name: "invoice", title: "Products", height: 30, width: 98, minWidth: 500, minHeight: 250, colWidth: 50, float: "left", backColor: "biege", contentType: "Table", tableProperties: {
            rowEmptyCheckColumn: 1, columns: [
              { order: "0", id: "sno", name: "SNo", field: "sno", defaultValue: "0", "inputType": 0, "type": "INT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": true, "mandatory": true, "chkTag": false, width: 50, sno: true },
              {
                order: "1", id: "product", name: "Product", field: "product", defaultValue: "0", "inputType": 0, "type": "LOV", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": false, "mandatory": true, lovOptions: {
                  url: "/inventory/service/ajax", ajax: "saleproduct", scrollEnabled: true, searchFromList: false, dsi: 0, params: [{ n: "branch", src: "branch", ft: true }, { n: "custtype", src: "custtype", ft: false }], results: [
                    { tgt: "invoice_data", tt: false, row: "cr", col: "1", id: "0" },
                    { tgt: "invoice_data", tt: true, row: "cr", col: "1", id: "1" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "2", id: "2" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "23", id: "5" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "30", id: "7" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "6", id: "8" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "7", id: "10" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "8", id: "12" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "14", id: "10" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "15", id: "12" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "36", id: "13" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "16", id: "14" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "38", id: "15" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "25", id: "16" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "3", id: "17" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "4", id: "18" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "39", id: "19" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "40", id: "20" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "41", id: "21" }
                    
                  ]
                }, width: 200, chkTag: true, validation: "getAttributeDetail"                 //    validation: "getAttributeDetail"  
              },
              { order: "2", id: "pgcode", name: "pgcode", field: "pgcode", defaultValue: "0", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "mandatory": false, width: 0 },
              { order: "3", id: "serialized", name: "serialized", field: "serialized", defaultValue: "0", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "mandatory": false, width: 0 },
              { order: "4", id: "isattribute", name: "isattribute", field: "isattribute", defaultValue: "0", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "mandatory": false, width: 0 },
              { order: "5", id: "attribid", name: "AttributeId", field: "attribid", defaultValue: "0", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "mandatory": false, width: 0, chkTag: false },
              { order: "6", id: "unitgroup", name: "UnitGroup", field: "unitgroup", defaultValue: "0", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "mandatory": false, width: 0 },
              {
                order: "7", id: "unitname",name: "Units", field: "unitname", defaultValue: "0", "inputType": 0, "type": "LOV", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": false, "mandatory": true, lovOptions: {
                  url: "/inventory/service/ajax", ajax: "units", scrollEnabled: true, searchFromList: false, dsi: 0, params: [{ n: "unitgroup", src: "invoice_data", row: "cr", col: "6", ft: false }], results: [
                    { tgt: "invoice_data", tt: false, row: "cr", col: "7", id: "0" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "8", id: "1" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "14", id: "0" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "15", id: "1" },
                    { tgt: "invoice_data", tt: false, row: "cr", col: "36", id: "2" }
                  ]
                }, width: 80, chkTag: false, validation: ""
              },
              { order: "8", id: "unitid", name: "unitid", field: "unitid", defaultValue: "0", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "mandatory": false, width: 0 },
              { order: "9", id: "batchno", name: "BatchNo", field: "batchno", defaultValue: "NA", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": showExpiry, "readOnly": true, "mandatory": showExpiry, width: ew, chkTag: false },
              { order: "10", id: "batchdt", name: "BatchDt", field: "batchdt", defaultValue: "NA", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "mandatory": false, width: 0, chkTag: false },
              { order: "11", id: "expdt", name: "ExpDt", field: "expdt", defaultValue: "", "inputType": 0, "type": "DATE", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": showExpiry, "readOnly": true, "mandatory": showExpiry, width: ew, chkTag: false },
              { order: "12", id: "qty", name: "Qty", field: "quantity", defaultValue: "0", "inputType": 0, "type": "DECIMAL", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": false, "mandatory": true, width: 100, onchange: "onRateQuantityChange", cTotal: true, validation: "validateStock" },
              { order: "13", id: "freeqty", name: "Free", field: "freeqty", defaultValue: "0", "inputType": 0, "type": "INT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": false, "mandatory": false, width: 80, onchange: "onRateQuantityChange", cTotal: true, validation: "getSerialDetail" },
              { order: "14", id: "funitname", name: "Units", field: "funitname", defaultValue: "0", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": false, "mandatory": true, width: 0, chkTag: false },
              { order: "15", id: "funitid", name: "unitid", field: "funitid", defaultValue: "0", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "mandatory": false, width: 0 },
              { order: "16", id: "unit", name: "Unit", field: "unit", defaultValue: "1", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "mandatory": false, width: 0, chkTag: false },
              { order: "17", id: "stock", name: "Stock", field: "stock", defaultValue: "0", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "mandatory": false, width: 0, chkTag: false },
              { order: "18", id: "rate", name: "Rate", field: "rate", defaultValue: "0", "inputType": 0, "type": "DECIMAL", "maxValue": 999999.99, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": false, "mandatory": true, width: 100, onchange: "onRateQuantityChange", align: "right" },
              { order: "19", id: "discperc", name: "Disc%", field: "discperc", defaultValue: "0", "inputType": 0, "type": "DECIMAL", "maxValue": 99.99, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": false, "mandatory": false, width: 100, onchange: "onRateQuantityChange", align: "right" },
              { order: "20", id: "discamt", name: "Disc Amt", field: "discamt", defaultValue: "0", "inputType": 0, "type": "DECIMAL", "maxValue": 999999.99, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": true, "mandatory": false, width: 100, align: "right" },
              { order: "21", id: "cashdiscperc", name: "Cash Disc%", field: "cashdiscperc", defaultValue: "0", "inputType": 0, "type": "DECIMAL", "maxValue": 999999.99, "textLength": 10, "decimalLength": 2, "visible": false, "readOnly": false, "mandatory": false, width: 0, onchange: "onRateQuantityChange", align: "right" },
              { order: "22", id: "cashdiscamt", name: "Cash Disc Amount", field: "cashdiscamt", defaultValue: "0", "inputType": 0, "type": "DECIMAL", "maxValue": 999999.99, "textLength": 10, "decimalLength": 2, "visible": false, "readOnly": false, "mandatory": false, width: 0, align: "right" },
              { order: "23", id: "staxperc", name: "S.Tax%", field: "staxperc", defaultValue: "0", "inputType": 0, "type": "DECIMAL", "maxValue": 999.99, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": false, "mandatory": false, width: 100, onchange: "onRateQuantityChange", align: "right" },
              { order: "24", id: "staxamt", name: "S.Tax Amt", field: "staxamt", defaultValue: "0", "inputType": 0, "type": "DECIMAL", "maxValue": 999999.99, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": true, "mandatory": false, width: 100, align: "right" },
              { order: "25", id: "srtax", name: "Service Tax%", field: "srtaxperc", defaultValue: "0", "inputType": 0, "type": "DECIMAL", "maxValue": 999.99, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": false, "mandatory": false, width: 100, onchange: "onRateQuantityChange", align: "right" },
              { order: "26", id: "srtaxamt", name: "Service Tax Amount", field: "srtaxamt", defaultValue: "0", "inputType": 0, "type": "DECIMAL", "maxValue": 999999.99, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": true, "mandatory": false, width: 100, align: "right" },
              { order: "27", id: "amount", name: "Amount", field: "amount", defaultValue: "0", "inputType": 0, "type": "DECIMAL", "maxValue": 999999.99, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": true, "mandatory": true, width: 150, cTotal: true, align: "right" },
              { order: "28", id: "netamount", name: "NetAmount", field: "netamount", defaultValue: "y", "inputType": 0, "type": "DECIMAL", "maxValue": 999999.99, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": true, "mandatory": true, width: 150, cTotal: true, align: "right" },
              { order: "29", id: "csdid", name: "CsdId", field: "csdid", defaultValue: "0", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": true, "mandatory": false, width: 0, chkTag: false },
              { order: "30", id: "taxincl", name: "TaxInclu", field: "taxincl", defaultValue: "0", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": true, "mandatory": false, width: 0, chkTag: false },
              { order: "31", id: "taxableamt", name: "TaxableAmt", field: "taxableamt", defaultValue: "0", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": true, "readOnly": true, "mandatory": false, width: 0, chkTag: false },
              { order: "32", id: "impno", name: "impno", field: "impno", defaultValue: "0", "inputType": 0, "type": "INT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "mandatory": false, width: 0, chkTag: false },
              { order: "33", id: "impsno", name: "impsno", field: "impsno", defaultValue: "0", "inputType": 0, "type": "INT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": true, "mandatory": false, width: 0, chkTag: false },
              { order: "34", id: "imptype", name: "imptype", field: "imptype", defaultValue: "NA", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 2, "decimalLength": 0, "visible": false, "readOnly": true, "mandatory": false, width: 0, chkTag: false },
              { order: "35", id: "selling", name: "selling", field: "selling", defaultValue: "0", "inputType": 0, "type": "DECIMAL", "maxValue": 999999.99, "textLength": 10, "decimalLength": 2, "visible": false, "readOnly": false, "mandatory": false, width: 0, align: "right" },
              { order: "36", id: "conversionvalue", name: "conversionvalue", field: "conversionvalue", defaultValue: "0", "inputType": 0, "type": "DECIMAL", "maxValue": 0, "textLength": 20, "decimalLength": 10, "visible": false, "readOnly": true, "mandatory": false, width: 0, chkTag: false },
              { order: "37", id: "basequantity", name: "BaseQuantity", field: "basequantity", defaultValue: "0", "inputType": 0, "type": "INT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": false, "mandatory": false, width: 0, chkTag: false },
              { order: "38", id: "allownegative", name: "AllowNegative", field: "allownegative", defaultValue: "0", "inputType": 0, "type": "INT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": false, "mandatory": false, width: 0, chkTag: false },
              { order: "39", id: "composite", name: "Composite", field: "composite", defaultValue: "0", "inputType": 0, "type": "INT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": false, "mandatory": false, width: 0, chkTag: false },
              { order: "40", id: "updatestock", name: "UpdateStock", field: "updatestock", defaultValue: "0", "inputType": 0, "type": "INT", "maxValue": 0, "textLength": 10, "decimalLength": 0, "visible": false, "readOnly": false, "mandatory": false, width: 0, chkTag: false },
              { order: "41", id: "hsncode", name: "HSN", field: "hsncode", defaultValue: "0", "inputType": 0, "type": "TEXT", "maxValue": 0, "textLength": 30, "decimalLength": 0, "visible": false, "readOnly": false, "mandatory": false, width: 0, chkTag: false }
            ]
          }
        },
        {
          name: "group3", height: 20, width: 45, minWidth: 250, minHeight: 50, colWidth: 98, float: "right", backColor: "biege", contentType: "Fields",
          fields: [{ name: "discamt", inputType: 0, type: "DECIMAL", caption: "Total Discount", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": true, "chkTag": false, nf: "taxamt", onchange: "onTaxChange" },
          { name: "taxamt", inputType: 0, type: "DECIMAL", caption: "VAT", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": true, "chkTag": false, nf: "total" },
          { name: "servtaxamt", inputType: 0, type: "DECIMAL", caption: "Service Tax", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 2, "visible": false, "readOnly": true, "chkTag": false, nf: "pf", onchange: "onTaxChange" },
          { name: "total", inputType: 0, type: "DECIMAL", caption: "Total:", mandatory: true, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": true, "chkTag": false, nf: "totalamt" },
          { name: "totalamt", inputType: 0, type: "DECIMAL", caption: "Net Amount", mandatory: true, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 2, "visible": true, "readOnly": true, "chkTag": false },
          { name: "advanceamt", inputType: 0, type: "DECIMAL", caption: "Advance Amount", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 2, "visible": false, "readOnly": true, "chkTag": false },
          { name: "roundedoff", inputType: 0, type: "NEGDEC", caption: "Round Off", mandatory: false, defaultValue: "0", "maxValue": 0, "textLength": 10, "decimalLength": 2, "visible": false, "readOnly": true, "chkTag": false }
          ]
        }]
    };
    /*
    ,
      {name:"group4",height:15,width:80,minWidth:500,minHeight:50,colWidth:15,float:"left",backColor:"beige",contentType:"Fields",fields:[
      {name:"add",inputType:3,caption:"Add",onclick:"add",visible:true},
      {name:"save",inputType:3,caption:"Save",onclick:"save",visible:true},
      {name:"savePrint",inputType:3,caption:"Save & Print",onclick:"savePrint",visible:true},
      {name:"loadservice",inputType:3,caption:"Load Service Order",onclick:"loadServiceOrder",visible:true},
      {name:"edit",inputType:3,caption:"Edit",onclick:"edit",visible:true},
      {name:"Delete",inputType:3,caption:"Delete",onclick:"delete1",visible:true},
      {name:"Print",inputType:3,caption:"Print",onclick:"printInvoice",visible:true}]}
      */
   
      function checkreload(){
              
               let stock=0;
               stock= $("#product").val();
	             if(stock=="" | stock==null){
		                    alert("Please fill in the Tender Correctly and continue JSP");
		            return true;	
	          }
      }

      function showHideTransport() {
        if ($('#divTransport').is(':visible')) {
          $('#divTransport').css("display", "none");
          $('#divFirst').css("display", "block");
          //$('#transbutton').removeClass("fa fa-minus-circle");
          //$('#transbutton').addClass("fa fa-plus-circle");
          $('#transbutton').html("More...");
        } else {
          $('#divTransport').css("display", "block");
          $('#divFirst').css("display", "none");
          //$('#transbutton').removeClass("fa fa-plus-circle");
          //$('#transbutton').addClass("fa fa-minus-circle");
          $('#transbutton').html("Less...");
        }
      }
    function getCardBankData() {
      var ajaxObj = new FlexUI.Ajax();
      var bData = ajaxObj.callAjax("GET", "/inventory/service/ajax", "ic=0&id=cardbanks");
      var bankData = bData.data;
      var bankCode = 1;
      var bankName = 0;
      invCardMachines += "<option value='0'>None</option>";
      for (var i = 0; i < bankData.length; i++) {
        invCardMachines += "<option value='" + bankData[i][bankCode] + "'>" + bankData[i][bankName] + "</option>";
      }
    }
    function showPrescription() {
      if ($('#appid').val() == "0" || $('#appid').val() == "") {
        setErrorMessage("No prescription details available for this invoice");
        return;
      }
      $('#prescriptiondlg').dialog({ autoOpen: false, modal: true, height: 'auto', minHeight: 600, minWidth: 900, position: 'center' });
      $('#prescriptiondlg').dialog('open');
      $('.butt_sav').click(function (e) {
        e.preventDefault();
      });
      $('.butt_can').click(function (e) {
        e.preventDefault();
      });
      var vl = $('#presitems');
      var v = l.callAjax("GET", "/HMS/service/prescription/patientmedicines", "page=1&rows=100&appid=" + $('#appid').val() + "&doctorcode=" + screenObjects.getScreenObject("prfcode").getValue() + "&hospitalcode=1", "");
      var s = v.rows.length;
      var action = "";
      $('#presitems').children().remove();
      for (var i = 0; i < s; i++) {
        vl.append('<tr><td>' + (i + 1) + '</td>' +
          '<td>' + v.rows[i].productname + '</td>' +
          '<td>' + v.rows[i].genericname + '</td>' +
          '<td>' + v.rows[i].pdp_course1 + '</td>' +
          '<td>' + v.rows[i].pdp_course2 + '</td>' +
          '<td>' + v.rows[i].pdp_course3 + '</td>' +
          '<td>' + v.rows[i].pdp_course4 + '</td>' +
          '<td>' + v.rows[i].pdp_ABMeal + '</td>' +
          '<td>' + v.rows[i].pdp_numbers + '</td>' +
          '</tr>');
      }
    }
    function prescrCancel() {
      $('#prescriptiondlg').dialog('close');
      $('#prescriptiondlg').dialog('destroy');
    }
    getCardBankData();

    var screenProps = changeScreenAttributes(310001, sProps);
    var invscreen = new FlexUI.Screen("xyz", screenProps);
    setDefaultBranch();
    screenObjects.getScreenObject("invoice_data").getInputField().onTextKeyDown.subscribe(tableTextKeyDown);
  <%if (mode != null && mode.equals("VIEW")) {%>
    
	    console.log("code no"+ <%=code %>);
      loadDataView(<%=code %>);
      $('#saveGrp').html('<button type="button" class="btn btn-clear mx-2" onclick="closeScreen()"><span class="mdi mdi-close-box"></span>Close</button>');
      $('#spnSetting').css("display", "none");
	<%} else {%>
      $('#spnSetting').css("display", "block");
	<%}%>
  </script>
</body>

</html>