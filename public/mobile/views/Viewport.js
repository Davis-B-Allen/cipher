mobile.views.Viewport = Ext.extend(Ext.Panel, {
    fullscreen: true,
    layout: 'card',
    cardSwitchAnimation: 'slide',
    initComponent: function() {
        
        //put instances of cards into mobile.views namespace
        Ext.apply(mobile.views, {
        	sitePanel : new mobile.views.SitePanel(),
        	tabPanel : new mobile.views.TabPanel()
        });
        
        //put instances of cards into viewport
        Ext.apply(this, {
            items: [
            	mobile.views.SitePanel,
                mobile.views.tabPanel
            ]
        });
        
        mobile.views.Viewport.superclass.initComponent.apply(this, arguments);
    }
});