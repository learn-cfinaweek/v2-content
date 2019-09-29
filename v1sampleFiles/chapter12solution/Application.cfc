component{
	this.name='learncfinaweek';
	this.datasource='learncfinaweek';
	this.applicationTimeout=CreateTimeSpan(10, 0, 0, 0);
	this.sessionManagement=true;
	this.sessionTimeout=CreateTimeSpan(0, 0, 30, 0);
	this.ormEnabled=true;
	this.ormSettings={
		logsql=true,
		dbcreate="update",
		cfclocation="com/entity"
		};
	this.invokeImplicitAccessor=true;
	this.sessionCookie.httpOnly=true;
	this.sessionCookie.timeout='10';
	this.sessionCookie.disableupdate=true;
	
	function onApplicationStart(){
		application.myName='Simon';
		application.myPosition='A Great Developer';
		application.utilities = CreateObject('cfc.utilities');
		return true;
	}
	
	function onRequestStart(string targetPage){
		if(structKeyExists(url, 'reload')){
			onApplicationStart();
			ormReload();
		}
	}
}