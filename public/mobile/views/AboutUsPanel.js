person = Ext.regModel("person", {
    idProperty: 'id',
    fields: [
        {name: "id", type: "int"},
        {name: "name", type: "string"},
        {name: "description", type: "string"},
        {name: "immge", type: "string"}
    ]
});

people = new Ext.data.Store({
    model: "person",
    data : [
        {name: 'Alex Felman', description: 'No sleep till Brooklyn', image: 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-snc4/372580_17503134_760878073_n.jpg'},
        {name: 'Ashod', description: 'Trouble maker for the good!', image: '/mobile/AshodPortrait.jpg'},
        {name: 'Andy', description: 'I am the man with Sencha Touch', image: '/mobile/Andy.jpg'},
        {name: 'Carla cricco-Lizza', description: 'NO !!!!!', image: 'https://www.google.com/images?q=tbn:ANd9GcR6HySypvXvdfsXL1zSb9S6FHk2uHHJ6Erg3WkdzT-wO3pxvG6oVEXtJA'},
        {name: 'Davis', description: 'rails DEV.. no physics', image: 'http://profile.ak.fbcdn.net/hprofile-ak-snc4/157273_13619618_1524285_n.jpg'},
        {name: 'Sandeep Arneja', description: 'yes i care!', image: 'http://profile.ak.fbcdn.net/hprofile-ak-snc4/186457_16309213_1831675570_n.jpg'}
    ]
});

mobile.views.AboutUsPanel = Ext.extend(Ext.List, {
    title: 'About Us',
    iconCls: 'team',
	layout:'hbox',
	store: people,
    itemTpl: new Ext.XTemplate(
    	'<div class="dealLineItem">',
			'<img src="{image}"></img>',
			'<div>',
				'<div> {name} </div>',
	    			'<div> {description}</div>',
			'</div>',
		'</div>'
    ), 
	initComponent: function() {
        mobile.views.AboutUsPanel.superclass.initComponent.apply(this, arguments);
    }
});
