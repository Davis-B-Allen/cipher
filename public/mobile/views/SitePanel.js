mobile.views.SitePanel = Ext.extend(Ext.Panel, {
    title: 'Help',
    iconCls: 'info',
	layout: {
		type: 'vbox',
		align: 'stretch'	
	},
	defaults:{
		margin: '5px'
	},
	dockedItems: [
	{
		xtype:'toolbar',
		title:'Park It !'
	}
	],
    items:[
    	{
			xtype:'panel',
			html:' <center> <img style="height:280px" src="/mobile/FinalLogo.jpg"></img> </center>',
			height:280    		
    	},
    	{
    		xtype: 'button',
    		text: 'Use my Location via GPS',
    		ui: 'action',
    		height: 25,
    		handler: function(){
    			mobile.views.viewport.setActiveItem(
					mobile.views.tabPanel
				);
				mobile.views.tabPanel.setActiveItem(
					mobile.views.mapPanel
				);
    		}
    	},
    	{
    		xtype: 'button',
    		text: 'Search by SMS',
    		ui: 'action',
    		height: 25,
    		handler: function(){
    			mobile.views.viewport.setActiveItem(
					mobile.views.tabPanel
				);
				mobile.views.tabPanel.setActiveItem(
					mobile.views.helpPanel
				);
    		}
    	}
    ],
	initComponent: function() {
        mobile.views.HelpPanel.superclass.initComponent.apply(this, arguments);
    }
});
