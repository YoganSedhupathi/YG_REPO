    var dbName="sales";
    var dbVersion="1.0";
    var dbDisplayName="Sales";
    var size=200000;
    
    var db = window.openDatabase(dbName, dbVersion, dbDisplayName, 200000);
    
    var sql="select * from registration_mast";
    var createSQL;
    var updateTable;
    var errorFunction;
    var querySuccessFunction;
	var onSuccessFunction;
    var version="1.0.0.1";
    	
	createSQL=new Array();
    createSQL[0]='CREATE TABLE if not exists registration_mast(reg_code integer PRIMARY KEY,server_ip text not null,imei_no text not null,version_no text,defaultbranch integer)';
    createSQL[1]='CREATE TABLE if not exists sync_tables(st_id integer primary key,st_table_name text,st_table_url text,st_table_script text,st_table_params text,st_last_sync_id bigint,st_isimage integer,st_imagefield text,st_imagepath text)';
	createSQL[2]='CREATE TABLE if not exists manufacturer_master ( mm_code integer primary key, mm_name text not null, mm_status text not null, tsid bigint)';
	createSQL[3]='CREATE TABLE if not exists product_group ( pg_code integer PRIMARY KEY, pg_name text, pg_status text, tsid bigint)';
	createSQL[4]='CREATE TABLE if not exists unit_master (um_code integer,um_name text,tsid bigint)';
	createSQL[5]='CREATE TABLE if not exists unitgroup_master ( ugm_id integer PRIMARY KEY , ugm_name text, ugm_baseunit integer, tsid bigint)';
	createSQL[6]='CREATE TABLE if not exists conversion_master ( cm_code integer primary key, cm_ugm_id integer, cm_um_id integer, cm_conv_value decimal(18,8),tsid bigint)';
	createSQL[7]='CREATE TABLE if not exists transporter_master ( trans_code integer primary key, trans_name text, trans_alias text, trans_phone text, trans_mobile text, trans_email text, trans_addr1 text, trans_addr2 text, trans_city text, trans_pincode text,  trans_status text,  tsid bigint)';
	createSQL[8]='CREATE TABLE if not exists supplier_type_master ( stype_code integer primary key, stype_name text, stype_credit_limit decimal(18,4), stype_credit_days integer, stype_credit_modifiable integer, stype_status text,  tsid bigint)';
	createSQL[9]='CREATE TABLE if not exists customer_type_master ( ctype_code integer primary key, ctype_name text, ctype_credit_limit decimal(18,4), ctype_credit_days integer, ctype_credit_modifiable integer, ctype_status text, tsid bigint)';
	createSQL[10]='CREATE TABLE if not exists supplier_master ( supp_code integer primary key, supp_name text, supp_alias text, supp_tax_no text, supp_dob date, supp_phone text, supp_mobile text, supp_email text, supp_credit_limit decimal(18,4), supp_credit_days integer, supp_addr1 text, supp_addr2 text, supp_city text, supp_state integer, supp_country integer, supp_cheque_name text, supp_type_code integer, supp_pincode text, supp_opening decimal(18,4), supp_pan_no text, branchcode integer, supp_status text, tsid bigint)';
	createSQL[11]='CREATE TABLE if not exists customer_master (cust_code integer primary key,cust_name text,cust_alias text,cust_tax_no text, cust_dob date, cust_phone text, cust_mobile text, cust_email text, cust_credit_limit decimal(18,4), cust_credit_days integer, cust_addr1 text, cust_addr2 text, cust_city text, cust_state integer, cust_country integer, cust_type_code integer, cust_pincode text, branchcode integer, cust_status text, cust_opening decimal(18,4), cust_pan_no text, tsid bigint)';
	createSQL[12]='CREATE TABLE if not exists branch_master ( branchcode integer primary key, branchname text, address1 text, address2 text, city text, email text, mobile text, contact_person text, phone text, pincode text, taxno text, status text, branchtype text, proptype text, rent decimal(18,2), tsid bigint)';
	createSQL[13]='CREATE TABLE if not exists hamali_master ( hm_code integer primary key, hm_name text, hm_alias text, hm_phone text, hm_mobile text, hm_email text, hm_addr1 text, hm_addr2 text, hm_city text, hm_pincode text, hm_status text, tsid bigint)';
	createSQL[14]='CREATE TABLE if not exists bin_master ( bm_bin_id integer primary key, bm_branchcode integer, bm_binname text, bm_noofrack integer, bm_status text, tsid bigint)';
	createSQL[15]='CREATE TABLE if not exists rack_master ( rm_rack_id integer primary key, rm_branchcode integer, rm_rackname text, rm_nooshelf integer, rm_bin_id integer, rm_status text, rm_rackorder integer, tsid bigint)';
	createSQL[16]='CREATE TABLE if not exists shelf_master ( sm_shelf_id integer primary key, sm_branchcode integer, sm_shelfname text, sm_noofbox integer, sm_bin_id integer, sm_rack_id integer, sm_status text, tsid bigint)';
	createSQL[17]='CREATE TABLE if not exists box_master ( bm_box_id integer primary key, bm_branchcode integer, bm_boxname text, bm_bin_id integer, bm_rack_id integer, bm_shelf_id integer, bm_status text, tsid bigint)';
	createSQL[18]='CREATE TABLE if not exists product_master ( pm_code integer primary key, pm_name text, pm_pg_code integer, pm_unit integer, pm_mm_code integer, pm_batch integer, pm_expiry integer, pm_selling_rate decimal(18,4), pm_status text, pm_purchaseunit integer, pm_saleunit integer, pm_transferunit integer, pm_gkm decimal(10,0) , pm_ugm_id integer, pm_purrate decimal(18,4), pm_mrp decimal(18,4), pm_allownegative integer, tsid bigint,pm_image text)';
	createSQL[19]='CREATE TABLE if not exists product_detail (  pd_pm_code integer, pd_branchcode integer, pd_minqty decimal(18,4), pd_maxqty decimal(18,4), tsid bigint,primary key(pd_pm_code,pd_branchcode))';   
	createSQL[20]='CREATE TABLE if not exists product_tax_config ( ptc_pm_code integer, ptc_stax integer, ptc_ptax integer, ptc_inclusive integer, ptc_location integer, tsid bigint,primary key(ptc_pm_code,ptc_location))';
	createSQL[21]='CREATE TABLE if not exists purchase_order_header ( poh_no integer primary key, poh_order_no integer, poh_supp_code integer, poh_order_type text, poh_supp_name text, poh_supp_addr1 text, poh_supp_addr2 text, poh_supp_city text, poh_supp_pin text, poh_supp_mobile text, poh_order_amount decimal(18,4), poh_tax_amt decimal(18,4), poh_disc_perc decimal(18,4), poh_disc_amt decimal(18,4), poh_net_amount decimal(18,4), poh_order_prefix text, poh_supp_type integer, poh_transporter integer, branchcode integer, poh_packing_charges decimal(18,4), poh_status text, poh_date date, poh_item_disc_amt decimal(18,4), poh_scheme_disc_amt decimal(18,4), poh_delivery_date date , poh_credit_days integer, tsid bigint)';
	createSQL[22]='CREATE TABLE if not exists purchase_order_detail ( pod_no integer, pod_order_no integer, branchcode integer, pod_product_code integer, pod_batch_no text, pod_unit integer, pod_qty decimal(18,4), pod_exp_dt date, pod_rate decimal(18,4), pod_tax_perc decimal(18,4), pod_tax_amt decimal(18,4), pod_total_amt decimal(18,4), pod_disc_perc decimal(18,4), pod_disc_amt decimal(18,4), pod_net_amount decimal(18,4), pod_batch_dt text, pod_taxable_amt decimal(18,4), pod_sno integer, pod_inclusive integer, pod_sale_tax_perc decimal(18,4), pod_mrp decimal(18,4), pod_selling decimal(18,4), pod_received_qty integer, pod_undel_qty integer, tsid bigint)';
	createSQL[23]='CREATE TABLE if not exists users (user_name text,user_pass text,role_id integer,user_type text,tsid bigint)';
	createSQL[24]='CREATE TABLE IF NOT EXISTS tran_seq_no(tran_id int,seq_no int)';
	createSQL[25]="CREATE TABLE IF NOT EXISTS grn_detail (gd_no integer NOT NULL DEFAULT '0',gd_pur_no integer DEFAULT NULL,branchcode integer DEFAULT NULL, gd_product_code integer DEFAULT NULL, gd_batch_no text DEFAULT NULL,gd_unit integer DEFAULT NULL,gd_qty double DEFAULT NULL,  gd_exp_dt date DEFAULT NULL, gd_rate double DEFAULT '0',gd_tax_perc double DEFAULT NULL,gd_tax_amt double DEFAULT NULL,  gd_total_amt double DEFAULT NULL,  gd_disc_perc double DEFAULT NULL,  gd_disc_amt double DEFAULT NULL,  gd_net_amount double DEFAULT NULL,  gd_csd_id integer NOT NULL DEFAULT '0',  gd_batch_dt text NOT NULL DEFAULT 'NA',  gd_taxable_amt double NOT NULL DEFAULT '0',  gd_sno integer NOT NULL DEFAULT '0',  gd_inclusive integer NOT NULL DEFAULT '0',  gd_sale_tax_perc double NOT NULL DEFAULT '0',  gd_mrp double NOT NULL DEFAULT '0',  gd_selling double NOT NULL DEFAULT '0',  gd_imp_no integer NOT NULL DEFAULT '0',  gd_imp_sno integer NOT NULL DEFAULT '0',  gd_imp_type text NOT NULL DEFAULT 'NA',  gd_received_qty integer DEFAULT '0',  gd_undel_qty integer DEFAULT '0',  gd_returned_qty double(18,4) NOT NULL DEFAULT '0.0000',  gd_cdisc_perc double NOT NULL,  gd_cdisc_amt double NOT NULL,  gd_freight double NOT NULL,gd_netcost double NOT NULL,gd_reg_code integer not null default 0,tsid bigint,PRIMARY KEY (gd_no,gd_sno))"; 
	createSQL[26]="CREATE TABLE IF NOT EXISTS grn_hamali (  grn_no integer NOT NULL,  grn_date date NOT NULL,  hamali_no integer NOT NULL,  sno integer NOT NULL, reg_code not null default 0,tsid bigint, PRIMARY KEY (grn_no,hamali_no))"; 
	createSQL[27]="CREATE TABLE IF NOT EXISTS grn_header (  gh_no integer NOT NULL DEFAULT '0',  gh_pur_no integer DEFAULT NULL,  gh_inv_no text DEFAULT NULL,  gh_inv_date date DEFAULT NULL,  gh_inv_amt double DEFAULT NULL,  gh_supp_code integer DEFAULT NULL,  gh_purc_type text DEFAULT 'C',  gh_supp_name text DEFAULT NULL,  gh_supp_addr1 text DEFAULT NULL,  gh_supp_addr2 text DEFAULT NULL,  gh_supp_city text DEFAULT NULL,  gh_supp_pin text DEFAULT NULL,  gh_supp_mobile text DEFAULT NULL,  gh_purchase_amount double DEFAULT NULL,  gh_tax_amt double DEFAULT NULL,  gh_disc_perc double DEFAULT NULL,  gh_disc_amt double DEFAULT NULL,  gh_net_amount double DEFAULT NULL,  gh_purc_prefix text DEFAULT NULL,  gh_supp_type integer DEFAULT NULL,  gh_transporter integer DEFAULT NULL,  branchcode integer DEFAULT NULL,  gh_packing_charges double NOT NULL DEFAULT '0',  gh_lr_no text NOT NULL DEFAULT '0',  gh_lr_date date DEFAULT NULL,  gh_po_no integer NOT NULL DEFAULT '0',  gh_po_sno integer NOT NULL DEFAULT '0',  gh_po_date date DEFAULT NULL,  gh_rn_no integer NOT NULL DEFAULT '0',  gh_rn_date date DEFAULT NULL,  gh_pay_mode text NOT NULL DEFAULT 'CA',  gh_status text NOT NULL DEFAULT 'N',  gh_documents text DEFAULT NULL,  gh_recd_thro text DEFAULT NULL,  gh_paid_amount double NOT NULL DEFAULT '0',  gh_date date NOT NULL,  gh_item_disc_amt double NOT NULL DEFAULT '0',  gh_scheme_disc_amt double NOT NULL DEFAULT '0',  gh_due_date date DEFAULT NULL,  gh_credit_days integer NOT NULL DEFAULT '0',  gh_transfer_status text NOT NULL DEFAULT 'P', gh_reg_code not null default 0,tsid bigint, PRIMARY KEY (gh_no))";
	createSQL[28]='CREATE TABLE if not exists sync_out_tables(sot_id integer primary key,sot_tran_id integer,sot_table_name text,sot_sync_url text,sot_table_script text,sot_table_params text,sot_table_fields text,sot_last_sync_id bigint)';
	
	
	//insert default records
	/*createSQL[28]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(1,"manufacturer_master","/Fruits/service/sync?id=1","insert or replace into manufacturer_master(mm_code,mm_name,mm_status,tsid) values(?,?,?,?)","mm_code,mm_name,mm_status,tsid","0")';
	createSQL[29]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(2,"product_group","/Fruits/service/sync?id=2","insert or replace into product_group(pg_code,pg_name,pg_status,tsid) values(?,?,?,?)","pg_code,pg_name,pg_status,tsid","0")';
	createSQL[30]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(3,"unit_master","/Fruits/service/sync?id=3","insert or replace into unit_master(um_code,um_name,tsid) values(?,?,?)","um_code,um_name,tsid","0")';
	createSQL[31]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(4,"unitgroup_master","/Fruits/service/sync?id=4","insert or replace into unitgroup_master(ugm_id,ugm_name,ugm_baseunit,tsid) values(?,?,?,?)","ugm_id,ugm_name,ugm_baseunit,tsid","0")';
	createSQL[32]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(5,"conversion_master","/Fruits/service/sync?id=5","insert or replace into conversion_master(cm_code,cm_ugm_id,cm_um_id,cm_conv_value,tsid) values(?,?,?,?,?)","cm_code,cm_ugm_id,cm_um_id,cm_conv_value,tsid","0")';
	createSQL[33]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(6,"transporter_master","/Fruits/service/sync?id=6","insert or replace into transporter_master(trans_code,trans_name,trans_status,tsid) values(?,?,?,?)","trans_code,trans_name,trans_status,tsid","0")';
	createSQL[34]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(7,"supplier_type_master","/Fruits/service/sync?id=7","insert or replace into supplier_type_master(stype_code,stype_name,stype_credit_limit,stype_credit_days,stype_credit_modifiable,stype_status,tsid) values(?,?,?,?,?,?,?)","stype_code,stype_name,stype_credit_limit,stype_credit_days,stype_credit_modifiable,stype_status,tsid","0")';
	createSQL[35]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(8,"customer_type_master","/Fruits/service/sync?id=8","insert or replace into customer_type_master(ctype_code,ctype_name,ctype_credit_limit,ctype_credit_days,ctype_credit_modifiable,ctype_status,tsid) values(?,?,?,?,?,?,?)","ctype_code,ctype_name,ctype_credit_limit,ctype_credit_days,ctype_credit_modifiable,ctype_status,tsid","0")';
	createSQL[36]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(9,"supplier_master","/Fruits/service/sync?id=9","insert or replace into supplier_master(supp_code,supp_name,supp_addr1,supp_addr2,supp_city,supp_type_code,supp_pincode,supp_mobile,supp_phone,branchcode,supp_status,supp_credit_limit,supp_credit_days,tsid) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)","supp_code,supp_name,supp_addr1,supp_addr2,supp_city,supp_type_code,supp_pincode,supp_mobile,supp_phone,branchcode,supp_status,supp_credit_limit,supp_credit_days,tsid","0")';
	createSQL[37]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(10,"customer_master","/Fruits/service/sync?id=10","insert or replace into customer_master(cust_code,cust_name,cust_addr1,cust_addr2,cust_city,cust_type_code,cust_pincode,cust_mobile,cust_phone,branchcode,cust_status,cust_credit_limit,cust_credit_days,tsid) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)","cust_code,cust_name,cust_addr1,cust_addr2,cust_city,cust_type_code,cust_pincode,cust_mobile,cust_phone,branchcode,cust_status,cust_credit_limit,cust_credit_days,tsid","0")';
	createSQL[38]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(12,"branch_master","/Fruits/service/sync?id=12","insert or replace into branch_master(branchcode,branchname,address1,address2,city,pincode,email,mobile,phone,taxno,contact_person,status,branchtype,proptype,tsid) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)","branchcode,branchname,address1,address2,city,pincode,email,mobile,phone,taxno,contact_person,status,branchtype,proptype,tsid","0")';
	createSQL[39]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(13,"hamali_master","/Fruits/service/sync?id=13","insert or replace into hamali_master(hm_code,hm_name,hm_mobile,hm_status,tsid) values(?,?,?,?,?)","hm_code,hm_name,hm_mobile,hm_status,tsid","0")';
	createSQL[40]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(14,"bin_master","/Fruits/service/sync?id=14","insert or replace into bin_master(bm_bin_id,bm_binname,bm_branchcode,bm_noofrack,bm_status,tsid) values(?,?,?,?,?,?)","bm_bin_id,bm_binname,bm_branchcode,bm_noofrack,bm_status,tsid","0")';
	createSQL[41]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(15,"rack_master","/Fruits/service/sync?id=15","insert or replace into rack_master(rm_rack_id,rm_rackname,rm_branchcode,rm_nooshelf,rm_bin_id,rm_status,rm_rackorder,tsid) values(?,?,?,?,?,?,?,?)","rm_rack_id,rm_rackname,rm_branchcode,rm_nooshelf,rm_bin_id,rm_status,rm_rackorder,tsid","0")';
	createSQL[42]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(16,"shelf_master","/Fruits/service/sync?id=16","insert or replace into shelf_master(sm_shelf_id,sm_shelfname,sm_branchcode,sm_noofbox,sm_status,sm_bin_id,sm_rack_id,tsid) values(?,?,?,?,?,?,?,?)","sm_shelf_id,sm_shelfname,sm_branchcode,sm_noofbox,sm_status,sm_bin_id,sm_rack_id,tsid","0")';
	createSQL[43]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(17,"box_master","/Fruits/service/sync?id=17","insert or replace into box_master(bm_box_id,bm_boxname,bm_branchcode,bm_bin_id,bm_rack_id,bm_shelf_id,bm_status,tsid) values(?,?,?,?,?,?,?,?)","bm_box_id,bm_boxname,bm_branchcode,bm_bin_id,bm_rack_id,bm_shelf_id,bm_status,tsid","0")';
	createSQL[44]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id,st_isimage,st_imagefield,st_imagepath) values(18,"product_master","/Fruits/service/sync?id=18","insert or replace into product_master(pm_code,pm_name,pm_pg_code,pm_unit,pm_mm_code,pm_batch,pm_expiry,pm_selling_rate,pm_status,pm_purchaseunit,pm_saleunit,pm_transferunit,pm_ugm_id,pm_purrate,pm_mrp,pm_allownegative,tsid,pm_image) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)","pm_code,pm_name,pm_pg_code,pm_unit,pm_mm_code,pm_batch,pm_expiry,pm_selling_rate,pm_status,pm_purchaseunit,pm_saleunit,pm_transferunit,pm_ugm_id,pm_purrate,pm_mrp,pm_allownegative,tsid,pm_image","0","1","pm_pg_code,pm_image","/Fruits/items/{domain}/{pm_pg_code}/{pm_image}")';
	createSQL[45]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(19,"product_detail","/Fruits/service/sync?id=19","insert or replace into product_detail(pd_pm_code,pd_branchcode,pd_minqty,pd_maxqty,tsid) values(?,?,?,?,?)","pd_pm_code,pd_branchcode,pd_minqty,pd_maxqty,tsid","0")';
	createSQL[46]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(20,"product_tax_config","/Fruits/service/sync?id=20","insert or replace into product_tax_config(ptc_pm_code,ptc_location,ptc_ptax,ptc_stax,ptc_inclusive,tsid) values(?,?,?,?,?,?)","ptc_pm_code,ptc_location,ptc_ptax,ptc_stax,ptc_inclusive,tsid","0")';
	createSQL[47]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(21,"purchase_order_header","/Fruits/service/sync?id=21","insert or replace into purchase_order_header(poh_no,poh_order_no,poh_supp_code,poh_order_type,poh_supp_name,poh_supp_addr1,poh_supp_addr2,poh_supp_city,poh_supp_pin,poh_supp_mobile,poh_order_amount,poh_tax_amt,poh_disc_perc,poh_disc_amt,poh_net_amount,poh_order_prefix,poh_supp_type,poh_transporter,branchcode,poh_packing_charges,poh_status,poh_date,poh_item_disc_amt,poh_credit_days,poh_delivery_date,tsid) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)","poh_no,poh_order_no,poh_supp_code,poh_order_type,poh_supp_name,poh_supp_addr1,poh_supp_addr2,poh_supp_city,poh_supp_pin,poh_supp_mobile,poh_order_amount,poh_tax_amt,poh_disc_perc,poh_disc_amt,poh_net_amount,poh_order_prefix,poh_supp_type,poh_transporter,branchcode,poh_packing_charges,poh_status,poh_date,poh_item_disc_amt,poh_credit_days,poh_delivery_date,tsid","0")';
	createSQL[48]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(22,"purchase_order_detail","/Fruits/service/sync?id=22","insert or replace into purchase_order_detail(pod_no,pod_order_no,branchcode,pod_product_code,pod_batch_no,pod_unit,pod_qty,pod_exp_dt,pod_rate,pod_tax_perc,pod_tax_amt,pod_total_amt,pod_disc_perc,pod_disc_amt,pod_net_amount,pod_batch_dt,pod_taxable_amt,pod_sno,pod_inclusive,pod_sale_tax_perc,pod_mrp,pod_selling,tsid) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)","pod_no,pod_order_no,branchcode,pod_product_code,pod_batch_no,pod_unit,pod_qty,pod_exp_dt,pod_rate,pod_tax_perc,pod_tax_amt,pod_total_amt,pod_disc_perc,pod_disc_amt,pod_net_amount,pod_batch_dt,pod_taxable_amt,pod_sno,pod_inclusive,pod_sale_tax_perc,pod_mrp,pod_selling,tsid","0")';
	createSQL[49]='insert into sync_tables(st_id,st_table_name,st_table_url,st_table_script,st_table_params,st_last_sync_id) values(23,"users","/Fruits/service/sync?id=23","insert or replace into users(user_name,user_pass,role_id,user_type,tsid) values(?,?,?,?,?)","user_name,user_pass,role_id,user_type,tsid","0")';
	createSQL[50]='insert into tran_seq_no(tran_id,seq_no) values(1008,0)';	
	*/
	
    var database={
    createTable:function(tx) {
    	var s=createSQL.length;
    	for(i=0;i<s;i++){
    		tx.executeSql(createSQL[i]);
    	}
    },

    executeUpdate:function(tx) {
    	var s=updateTable.length;
    	for(i=0;i<s;i++){
    		tx.executeSql(updateTable[i]);
    	}
    },
 
    //function will be called when an error occurred
    onError:function(err) {
    	if(errorFunction){
        	errorFunction(err);
        	}
    },
 
    //function will be called when process succeed
    onSuccess:function() {
       	if(onSuccessFunction){
        	onSuccessFunction();
        }
    },
 
    executeQuery:function(tx){
        tx.executeSql(sql,[],database.onQuerySuccess,database.onError);
    },
 
    onQuerySuccess:function(tx,result){
       	if(querySuccessFunction){
        	querySuccessFunction(result);
        	}
    }
    };