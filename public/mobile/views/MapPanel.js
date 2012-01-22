mobile.views.MapPanel = Ext.extend(Ext.Panel, {
    title: 'Map',
    iconCls: 'locate',
	layout:'fit',
	id:'mapPanel',
	items : [
        {
            xtype : 'map',
            id:'map',
            useCurrentLocation: true,
            mapOptions:{
            	center: new google.maps.LatLng(40.7603225, -73.97918829999999),
		        zoom: 16,
		        mapTypeId: google.maps.MapTypeId.ROADMAP
            }
        }
    ],
    listeners: {
    	'render': function(){
    		console.info("rendered");
    		
    		var geo = new Ext.util.GeoLocation({
			    autoUpdate: true,
			    allowHighAccuracy: true,
			    listeners: {
			    	
			    	/*
			    	 * This method is called when current location changes. Would update current marker here.
			    	 */
			        locationupdate: function (geo) {
			        	console.info(geo.latitude, geo.longitude);
			        	
			        	 //if we already have the marker just update its location
			        	 if(mobile.views.mapPanel.myLocMarker){
			        		 mobile.views.mapPanel.myLocMarker.setPosition(new google.maps.LatLng(geo.latitude, geo.longitude));
 			        		
			        	 }else{
 			        		
			        		// create a car image
			        		var carPin = new google.maps.MarkerImage("/mobile/car.jpg",
						        new google.maps.Size(52, 41),
						        new google.maps.Point(0,0),
						        new google.maps.Point(10, 34)
						    );
							        		
							// create a car marker at current location which uses car image							        		
			        		mobile.views.mapPanel.myLocMarker = new google.maps.Marker({
							    position: new google.maps.LatLng(40.7603215, -73.97918829999999),
							    title:"This is where I am",
							    map:Ext.getCmp("map").map,
							    icon: carPin
							});
							
							// make a info windo
							var infowindow = new google.maps.InfoWindow({
							    content: "This is where i am here."
							});	
							
							// attaching clicking on marker to show info window
							google.maps.event.addListener(mobile.views.mapPanel.myLocMarker, 'click', function() {
							  infowindow.open(Ext.getCmp("map").map,mobile.views.mapPanel.myLocMarker);
							});
							
			        	}
			        	
			        },
			        locationerror: function (   geo,
			                                    bTimeout, 
			                                    bPermissionDenied, 
			                                    bLocationUnavailable, 
			                                    message) {
			            if(bTimeout){
			                console.info('Timeout occurred.');
			            }
			            else{
			                console.info('Error occurred.');
			            }
			        }
			    }
			});
			
			
			window.setTimeout(showSigns,1000);
			
    	}
    },
	initComponent: function() {
        mobile.views.MapPanel.superclass.initComponent.apply(this, arguments);
    }
});


function showSigns(){
	
	  var greenPin = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + "006600",
          new google.maps.Size(21, 34),
          new google.maps.Point(0,0),
          new google.maps.Point(10, 34));

      var redPin = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + "FF0000",
          new google.maps.Size(21, 34),
          new google.maps.Point(0,0),
          new google.maps.Point(10, 34));

  	// make ajax and show sigs


  	Ext.Ajax.request({
  	  url: '/geolocation/sign_lat_lons',
  	  success: function(resp,opts){
  	    locs = JSON.parse(resp.responseText);

  	    for (var i=0;i<locs.length;i++){
      		console.info("showing signs " + parseFloat(locs[i].la));
      		if (locs[i].color == "green"){
      			var m = new google.maps.Marker({
      			    position: new google.maps.LatLng(parseFloat(locs[i].la),parseFloat(locs[i].lo)),
      			    title:"This is where I am",
      			    map:Ext.getCmp("map").map,
      			    icon: greenPin
      			});	

      			var infowindow = new google.maps.InfoWindow({
      			    content: "Parking Here is Fine"
      			});

      			google.maps.event.addListener(m, 'click', function() {
      			  infowindow.open(Ext.getCmp("map").map,m);
      			});

      		}else {
      			var m = new google.maps.Marker({
      			    position: new google.maps.LatLng(locs[i].la,locs[i].lo),
      			    title:"This is where I am",
      			    map:Ext.getCmp("map").map,
      			    icon: redPin 
      			});

      			var infowindow = new google.maps.InfoWindow({
      			    content: "Parking Here is Fine"
      			});

      			google.maps.event.addListener(m, 'click', function() {
      			  infowindow.open(Ext.getCmp("map").map,m);
      			});
      		}
  	  }
  	}});




    
	

				
	}
	












