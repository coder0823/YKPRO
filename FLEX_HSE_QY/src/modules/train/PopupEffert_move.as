package modules.train{
	import flash.display.DisplayObject;
	import flash.display.DisplayObject;
	import flash.system.Capabilities;
	
	import mx.core.IFlexDisplayObject;
	import mx.effects.Blur;
	import mx.effects.Move;
	import mx.effects.Parallel;
	import mx.effects.Zoom;
	import mx.events.TweenEvent;
	import mx.managers.PopUpManager;
	
	import spark.effects.Move3D;

	public class PopupEffert_move
	{ 
		public var ss:String;
		public function PopupEffert_move() 
		{ 
		} 
		/* 显示特效 */ 
		public static function show(control:IFlexDisplayObject,parent:DisplayObject,modal:Boolean,local_x:Number,local_y:Number):void{ 
			var parallel:Parallel=new Parallel(); 
			var zoom:Zoom=new  Zoom(); 
			zoom.zoomHeightFrom=0; 
			zoom.zoomWidthFrom=0; 
			zoom.zoomHeightTo=1; 
			zoom.zoomWidthTo=1; 
			var mShowEffect:Move=new Move(); 
			mShowEffect.xFrom=local_x;
			mShowEffect.yFrom=local_y;
			mShowEffect.xTo=Capabilities.screenResolutionX/2-450;
			mShowEffect.yTo=Capabilities.screenResolutionY/2-300;
			parallel.duration=1000; 
			parallel.target=control; 
			parallel.addChild(mShowEffect); 
			parallel.addChild(zoom); 
//			PopUpManager.addPopUp(control,parent,modal); 
//			PopUpManager.centerPopUp(control); 
			parallel.play(); 
//			PopupModellocator.getInstance().push(control);
		} 


		public static function remove(control:IFlexDisplayObject,local_x:Number,local_y:Number):void 
		{ 
			var parallel:Parallel=new Parallel(); 
			var mHideEffect:Move3D=new Move3D(); 
			mHideEffect.xTo=local_x;
			mHideEffect.yTo=local_y;
			var zoom:Zoom=new  Zoom(); 
			zoom.zoomHeightFrom=1; 
			zoom.zoomWidthFrom=1; 
			zoom.zoomHeightTo=0; 
			zoom.zoomWidthTo=0; 
			parallel.addChild(mHideEffect); 
			parallel.addChild(zoom); 
			mHideEffect.addEventListener(TweenEvent.TWEEN_END,function(){ 
				PopUpManager.removePopUp(control); 
			}); 
			zoom.addEventListener(TweenEvent.TWEEN_END,function(){ 
				PopUpManager.removePopUp(control); 
			}); 
			parallel.duration=1000; 
			parallel.target=control; 
			parallel.play(); 
		} 
	} 
} 

