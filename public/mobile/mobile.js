Ext.regApplication({
    name: 'mobile',
    launch: function() {
        Ext.namespace("mobile.helpers");
        mobile.views.viewport = new mobile.views.Viewport();
        
		
		mobile.views.viewport.setActiveItem(
			mobile.views.sitePanel
		);
    }
});