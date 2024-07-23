Date.prototype.adjust = function(part, amount){
	part = part.toLowerCase();
	
	let map = { 
				years: 'FullYear', months: 'Month', weeks: 'Hours', days: 'Hours', hours: 'Hours', 
				minutes: 'Minutes', seconds: 'Seconds', milliseconds: 'Milliseconds',
				utcyears: 'UTCFullYear', utcmonths: 'UTCMonth', weeks: 'UTCHours', utcdays: 'UTCHours', 
				utchours: 'UTCHours', utcminutes: 'UTCMinutes', utcseconds: 'UTCSeconds', utcmilliseconds: 'UTCMilliseconds'
			},
		mapPart = map[part];

	if(part == 'weeks' || part == 'utcweeks')
		amount *= 168;
	if(part == 'days' || part == 'utcdays')
		amount *= 24;
	
	this['set'+ mapPart]( this['get'+ mapPart]() + amount );

	return this;
}

Date.prototype.diff = function(date2, parts){
	let d1 = new Date(this.getTime()),
		d2 = new Date(date2.getTime()),
		pm = d1 <= d2? 1 : -1,
		result = { },
		factors = { weeks: (1000*60*60*24*7), days: (1000*60*60*24), hours: (1000*60*60), minutes: (1000*60), seconds: 1000, milliseconds: 1 };

	if(parts === undefined)
		parts = ['years', 'months', 'weeks', 'days', 'hours', 'minutes', 'seconds', 'milliseconds'];
	else if(typeof(parts) == "string")
		parts = [parts];
		
	for(let i=0, l=parts.length; i<l; i++){
		let k = parts[i];
		result[k] = 0;

		if(factors[k] === undefined){
			inaWhile: while( true ){
				d2.adjust(k, -1*pm);
				if( (pm === 1 && d1 > d2) || (pm === -1 && d1 < d2)){
					d2.adjust(k, 1*pm);
					break inaWhile;
				}
				result[k]++;
			}
		}
		else{
			let tmpDiff = Math.abs(d2.getTime() - d1.getTime());
			result[k] = Math.floor(tmpDiff / factors[k]);
			d2.adjust(k, result[k]*-1*pm);
		}
		result[k] *= pm;
	}
	
	if(parts.length == 1)
		return result[parts[0]];
	return result;
}