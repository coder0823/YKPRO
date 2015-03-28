package events
 {
     import flash.events.Event;
     
     public class ExportEvent extends Event
     {
		 public static const ExportClick:String="ExportClick";
         
         public function ExportEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
         {
             super(type, bubbles, cancelable);
         }
         
         public override function clone():Event
         {
             var le:ExportEvent = new ExportEvent(type, bubbles, cancelable);
             return le;
         }
 
     }
 }