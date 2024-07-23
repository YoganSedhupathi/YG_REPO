function showReport(e,args){	
	let params=getParameters();
	window.open(context+"/index.do?src="+encodeURIComponent('/Base/base/ajax/html?'+params));
}

function getParameters(){
	let s=sProps.screen.length;
	let props=sProps.screen;
	let data="id="+reportId;
	for(let i=0;i<s;i++){
			let g=props[i];
			if(g.contentType=='Fields'){
				let fields=g.fields;
				let fs=fields.length;
				let v="";
				for(let p=0;p<fs;p++){				
					let f=fields[p];
					if(f.inputType!='3'){
						let w=screenObjects.getScreenObject(f.name);
						if(f.chkTag){
							v=w.getTag();
						}else{
							v=w.getValue();
						}
						if(v==""){
							v=f.defaultValue;
						}
						data+='&'+f.name+'='+v.replace(/"/g,'\\"');
					}				
				}
			}
		}
	return data;
}