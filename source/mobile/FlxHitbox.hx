package mobile;

import flash.display.BitmapData;
import flash.display.Shape;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxButton;

/**
 * A zone with 4 hint's (A hitbox).
 * It's really easy to customize the layout.
 *
 * @author Mihai Alexandru (M.A. Jigsaw)
 */
class FlxHitbox extends FlxSpriteGroup
{
	public var buttonLeft:FlxButton = new FlxButton(0, 0);
	public var buttonDown:FlxButton = new FlxButton(0, 0);
	public var buttonUp:FlxButton = new FlxButton(0, 0);
	public var buttonRight:FlxButton = new FlxButton(0, 0);

	/**
	 * Create the zone.
	 */
	public function new()
	{
		super();

		add(buttonLeft = createHint(0, 0, Std.int(FlxG.width / 4), FlxG.height, 0xFF00FF));
		add(buttonDown = createHint(FlxG.width / 4, 0, Std.int(FlxG.width / 4), FlxG.height, 0x00FFFF));
		add(buttonUp = createHint(FlxG.width / 2, 0, Std.int(FlxG.width / 4), FlxG.height, 0x00FF00));
		add(buttonRight = createHint((FlxG.width / 2) + (FlxG.width / 4), 0, Std.int(FlxG.width / 4), FlxG.height, 0xFF0000));

		scrollFactor.set();
	}

	/**
	 * Clean up memory.
	 */
	override function destroy()
	{
		super.destroy();

		buttonLeft = null;
		buttonDown = null;
		buttonUp = null;
		buttonRight = null;
	}

	private function createHintGraphic(Width:Int, Height:Int, Color:Int = 0xFFFFFF):BitmapData
	{
		var shape:Shape = new Shape();
		shape.graphics.beginFill(Color);
		shape.graphics.lineStyle(10, Color, 1);
		shape.graphics.drawRect(0, 0, Width, Height);
		shape.graphics.endFill();

		var bitmap:BitmapData = new BitmapData(Width, Height, true, 0);
		bitmap.draw(shape);
		return bitmap;
	}

	private function createHint(X:Float, Y:Float, Width:Int, Height:Int, Color:Int = 0xFFFFFF):FlxButton
	{
		var hint:FlxButton = new FlxButton(X, Y);
		hint.loadGraphic(createHintGraphic(Width, Height, Color));
		hint.solid = false;
		hint.immovable = true;
		hint.scrollFactor.set();
		hint.alpha = 0.00001;
		hint.onDown.callback = function()
		{
			if (hint.alpha != 0.2)
				hint.alpha = 0.2;
		}
		hint.onUp.callback = function()
		{
			if (hint.alpha != 0.00001)
				hint.alpha = 0.00001;
		}
		hint.onOut.callback = hint.onUp.callback;
		hint.onOver.callback = hint.onDown.callback;
		#if FLX_DEBUG
		hint.ignoreDrawDebug = true;
		#end
		return hint;
	}
	    hitbox_hint.alpha = 0.75;
		add(hitbox_hint);
	}

	public function createhitbox(hitboxposeX:Float, frames:String) {
		var hitboxframes = getHitboxFrames().getByName(frames);
		var graphic:FlxGraphic = FlxGraphic.fromFrame(hitboxframes);
		var button = new FlxButton(hitboxposeX, 0);
		button.loadGraphic(graphic);
		button.alpha = 0;

		button.onDown.callback = function (){
			FlxTween.num(0, 0.75, 0.075, {ease:FlxEase.circInOut}, function(alpha:Float){ 
				button.alpha = alpha;
			});
		};

		button.onUp.callback = function (){
			FlxTween.num(0.75, 0, 0.1, {ease:FlxEase.circInOut}, function(alpha:Float){ 
				button.alpha = alpha;
			});
		}

		button.onOut.callback = function (){
			FlxTween.num(button.alpha, 0, 0.2, {ease:FlxEase.circInOut}, function(alpha:Float){ 
				button.alpha = alpha;
			});
		}

		return button;
	}

	public static function getHitboxFrames():FlxAtlasFrames
	{
		return Paths.getSparrowAtlas('androidcontrols/hitbox');
	}

	override public function destroy():Void
	{
		super.destroy();

		buttonLeft = null;
		buttonDown = null;
		buttonUp = null;
		buttonRight = null;
	}
}
