import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Communications;
import Toybox.System;

class DCCView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();
        
		if (Application.Storage.getValue("CODE") == null) {
			var x as Number = (dc.getWidth()/2).toNumber();
			var y as Number = (dc.getHeight()/2).toNumber();
        	dc.drawText(x, y, Graphics.FONT_MEDIUM, Application.loadResource(Rez.Strings.NO_DATA), Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
			return;
		}
		
		
		var bitmapSize as Number = getApp().getBitmapSize();
		var x as Number = ((dc.getWidth() - bitmapSize)/2).toNumber();
		var y as Number = ((dc.getHeight() - bitmapSize)/2).toNumber();
		
		dc.drawBitmap(x, y, Application.Storage.getValue("CODE"));

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
