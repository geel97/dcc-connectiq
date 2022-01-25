import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class DCCApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    	downloadQR();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new DCCView() ] as Array<Views or InputDelegates>;
    }
    
	function onSettingsChanged() as Void {
    	downloadQR();
	}
    
    function getBitmapSize() as Number {
    	var screenSize as Number = Tools.min(System.getDeviceSettings().screenHeight, System.getDeviceSettings().screenWidth);
    	if (System.getDeviceSettings().screenShape == System.SCREEN_SHAPE_ROUND) {
    		return Toybox.Math.sqrt(screenSize*screenSize/2).toNumber();
    	}
    	return screenSize; 
    }

    function downloadQR() as Void {
 
     	var qrStr as String = Application.Properties.getValue("CODE");
    	if (qrStr.equals("")) {
    		return;
    	}
    	
    	var ecLevel as Char;
    	switch(Application.Properties.getValue("EC")) {
			case 0:
				ecLevel = "L";
				break;
			case 1:
				ecLevel = "M";
				break;
			case 2:
				ecLevel = "Q";
				break;
			case 3:
				ecLevel = "H";
				break;
		}
    	
    	var bitmapSize as Number = getBitmapSize();
		var strUrl as String = "https://chart.googleapis.com/chart?cht=qr";
		strUrl += "&chld=" + ecLevel +"|1";
		strUrl += "&chs=" + bitmapSize +"x"+ bitmapSize;
		strUrl += "&chl=" + Communications.encodeURL(qrStr);
		Communications.makeImageRequest(
			strUrl,
			{},
			{
				:palette => [ Graphics.COLOR_BLACK, Graphics.COLOR_WHITE],
				:maxWidth => bitmapSize,
				:maxHeight => bitmapSize,
				:dithering => Communications.IMAGE_DITHERING_NONE
			},
			self.method(:onReceiveImage)
		);
    }
    
    function onReceiveImage(code as Number, data as BitmapResource) as Void {
		if (code == 200){
			Application.Storage.setValue("CODE", data);
			WatchUi.requestUpdate(); 
		}
		else {
			
		}
	}
}

function getApp() as DCCApp {
    return Application.getApp() as DCCApp;
}