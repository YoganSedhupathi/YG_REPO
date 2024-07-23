    var syncResult=[];
    var currentIndex=0;
    var totalTables=0;
    var imagesDirectory;
    var myappFileSystem;
    var sync={
    	syncInProgress:false,
    	onSyncSuccess:null,
    	onSyncFail:null,
	    getLastTsid: function(callback,tableName) {
	    	db.transaction(
	        	function(tx) {
	            	var sql = "SELECT MAX(tsid) tsid FROM "+tableName;
	            	tx.executeSql(sql, db.onError,
	                	function(tx, results) {
	                    	var lastSync = results.rows.item(0).tsid;
	                    	if(lastSync==null){
								lastSync=0;	                    	
	                    	}
	                    	callback(lastSync);
	                	}
	            	);
	        	}
	    	);
		},
		getChanges: function(syncURL, tsid, callback) {
		    var branchcode=appdata.register.branch;
		    console.log(syncURL+"&tsid="+tsid+"&branchcode="+branchcode);
		    $.ajax({
        		url: syncURL+"&tsid="+tsid+"&branchcode="+branchcode,
        		success:function (changes) {
            		callback(changes);
        		},
        		error: function(model, response) {
            		alert(response.responseText);
        		}
    		});
		},
		applyChanges: function(data, query, params, isImage,imagePath,imageField,callback) {
 			db.transaction(
        	function(tx) {
            	var l = data.length;
            	var d;
            	var paramArray=params.split(",");
            	var s=paramArray.length;
            	var imageParamFields;
            	var y=0;
            	if(isImage==1){
            		imageParamFields=imageField.split(",");
            		imagePath=imagePath.replace("{domain}","localhost");
            		y=imageParamFields.length;				            		
                }else{
                	isImage=0;
                }
            	
            	console.log(query);
            	for (var i = 0; i < l; i++) {
                	d = data[i];
                	var p =[];
                	for(j=0;j<s;j++){                          		      	
                	 	p.push(d[paramArray[j]]);
                	}
                	tx.executeSql(query, p);
                	if(isImage==1){
	                	var fname=d[imageParamFields[y-1]];
	                	if(fname!=""){
		                	for(var x=0;x<y;x++){
	    	            		imagePath=imagePath.replace("{"+imageParamFields[x]+"}",d[imageParamFields[x]]);
	        	        	}
	                		sync.downloadFile("http://"+appdata.register.ip+imagePath,fname);
	                	}
	                }
            	}
        	},
        	db.onError,
        	function(tx) {
            	callback();
        	}
    		);
		},
		syncData: function(tableName,url,tscript,params,isImage,imagePath,imageField,callback) {
		    var self = this;
    		this.getLastTsid(function(lastSync){
        		sync.getChanges(url, lastSync,
            		function (data) {
                		sync.applyChanges(data, tscript,params,isImage,imagePath,imageField,callback);
            		}
        		);
    		},tableName);
		},
		getData: function(onSyncSuccess,onSyncFail) {
			sync.onSyncSuccess=onSyncSuccess;
			sync.onSyncFail=onSyncFail;
			sync.syncInProgress=true;
	    	db.transaction(
	        	function(tx) {
	            	var sql = "SELECT st_table_name,st_table_url,st_table_script,st_table_params,st_imagefield,st_imagepath,st_isimage FROM sync_tables ";
	            	tx.executeSql(sql, db.onError,
	                	function(tx, results) {
	                		var s=results.rows.length;
	                		totalTables=s;
							for(var i=0;i<s;i++){
								syncResult.push(results.rows.item(i));
							}
							var url="http://"+appdata.register.ip;
							var tableName=results.rows.item(0).st_table_name;
							var tableUrl=url+results.rows.item(0).st_table_url;
							var tableScript=results.rows.item(0).st_table_script;
							var tableParams=results.rows.item(0).st_table_params;
							var imageField=results.rows.item(0).st_imagefield;
							var imagePath=results.rows.item(0).st_imagepath;
							var isImage=results.rows.item(0).st_isimage;
	            			sync.syncData(tableName,tableUrl,tableScript,tableParams,isImage,imagePath,imageField,sync.callNextTableSync);        	
	                	}
	            	);
	        	}
	    	);
		},
		callNextTableSync:function(){
				var url="http://"+appdata.register.ip;
				currentIndex++;
	            if(currentIndex<totalTables){
        			var tableName=syncResult[currentIndex].st_table_name;
					var tableUrl=url+syncResult[currentIndex].st_table_url;
					var tableScript=syncResult[currentIndex].st_table_script;
					var tableParams=syncResult[currentIndex].st_table_params;
					var imageField=syncResult[currentIndex].st_imagefield;
					var imagePath=syncResult[currentIndex].st_imagepath;
					var isImage=syncResult[currentIndex].st_isimage;					
	            	sync.syncData(tableName,tableUrl,tableScript,tableParams,isImage,imagePath,imageField,sync.callNextTableSync);
	            }else{
	            	currentIndex=0;
	            	totalTables=0;
	            	syncResult=[];
	            	sync.syncInProgress=false;
	            	sync.onSyncSuccess();
	            }
	            return;
	    },
	    getFileSystem:function(){
	    	 window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, sync.onFSSuccess, null);
		},
		onFSSuccess:function(fileSystem){
			 myAppFileSystem=fileSystem;
			 fileSystem.root.getDirectory("FruitsApp",{create:true, exclusive: false},sync.gotFruitsAppDir,sync.onError);
		},
		gotFruitsAppDir:function(d){
			myAppFileSystem.root.getDirectory("images",{create:true, exclusive: false},sync.gotImagesDir,sync.onError);	 
		},
		gotImagesDir:function(d){
			imagesDirectory=d;
		},
		onError:function(e){
			console.log("error"+JSON.stringify(e));
			sync.syncInProgress=false;
			sync.onSyncFail(e);	
		},
		downloadFile:function(url,filename){
			 var ft = new FileTransfer();
			 var dlPath = imagesDirectory.fullPath + "/" + filename;
				console.log("downloading crap to " + dlPath+" url "+url);
				ft.download(url, dlPath, function(){
						  console.log("Successful download");
				}, sync.onError);
		}		
    };