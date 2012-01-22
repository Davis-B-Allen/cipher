mobile.views.TabPanel = Ext.extend(Ext.TabPanel, {
    id: 'tabPanel',
    scroll: 'vertical',
    cardSwitchAnimation: 'fade',
    dockedItems: [{
        xtype: 'toolbar',
        title: 'Home',
        items:[
        	{
        		xtype:'button',
	        	iconCls: 'refresh',
	        	iconMask: true, 
	        	ui: 'plain',
	        	handler: function(){
	        		Ext.Msg.alert("Listen up", "do Update here");
	        	}
	        },
        	{
	        	xtype: 'spacer'
	        },
	        {
	        	xtype: 'button',
	        	text: 'Logout',
	        	ui: 'action',
	        	handler: function(){
	        		mobile.views.viewport.setActiveItem(
						mobile.views.sitePanel
					);
	        	}
	        },    
        ]
    }],
    tabBar: {
    	dock: 'bottom',
    	layout: {
    		pack: 'center'
    	},
    	scroll: {
    		direction: 'vertical',
    		useIndicators: true
    	}
    },
    initComponent: function() {
    	
    	Ext.apply(mobile.views, {
        	mapPanel : new mobile.views.MapPanel(),
        	helpPanel : new mobile.views.HelpPanel(),
        	aboutusPanel : new mobile.views.AboutUsPanel()
        });
    	
    	Ext.apply(this, {
            items: [
               mobile.views.mapPanel,
                mobile.views.helpPanel,
                mobile.views.aboutusPanel,
            ]
        });
        
    	
        mobile.views.TabPanel.superclass.initComponent.apply(this, arguments);
    }
});