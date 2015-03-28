package events
 {
     import flash.events.Event;
     
     public class PopupEvent extends Event
     {
		 public static const PopupCfgClick:String="PopupCfgClick";
		 public static const PopupCfgDoubleClick:String="PopupCfgDoubleClick";
         public static const PopupClick:String = "PopupClick";
		 public static const PopupDoubleClick:String = "PopupDoubleClick";
		 public static const PopupItemClick:String="PopupItemClick";
         
         public function PopupEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
         {
             super(type, bubbles, cancelable);
         }
         
         private var _hitDataItem: Object;
		 private var _hitCfgItem:Object;
 
         public function get hitDataItem():Object
         {
             return _hitDataItem;
         }
         public function set hitDataItem(value:Object):void
         {
			 _hitDataItem = value;
         }
		 
		 public function get hitCfgItem():Object
		 {
			 return _hitCfgItem;
		 }
		 public function set hitCfgItem(value:Object):void
		 {
			 _hitCfgItem = value;
		 }
         
         public override function clone():Event
         {
             var le:PopupEvent = new PopupEvent(type, bubbles, cancelable);
             le.hitDataItem = hitDataItem;
			 le.hitCfgItem =hitCfgItem;
             return le;
         }
 
     }
 }