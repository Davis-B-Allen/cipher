mobile.views.HelpPanel = Ext.extend(Ext.Panel, {
    title: 'Help',
    iconCls: 'info',
	layout:'fit',
    html:'SMS address here and we will text you back letting you know if you can park there <h1> 917.652.6945 </h1> <br/> <center> <img src="/mobile/FinalLogo.jpg"></img> </center>',
	initComponent: function() {
        mobile.views.HelpPanel.superclass.initComponent.apply(this, arguments);
    }
});
