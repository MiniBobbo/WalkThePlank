package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.VarTween;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

/**
 * ...
 * @author Dave
 */
class Entity extends FlxSprite
{

	//Should this entity walk plank?
	public var walkThePlank:Bool;
	
	public var position:Int = 4;
	public var kicked:Bool = false;
	var lifetime:Float = 3;
	
	public var elapsed:Float = 0;
	
	public function new(walkPlank:Bool = true) 
	{
		super(-200,220);
		
		setSize(150, 150);
		
	}
	
	override public function update():Void 
	{
		super.update();
		if (kicked) {
			angle += FlxRandom.intRanged(2,5);

			elapsed += FlxG.elapsed;
			if (elapsed > lifetime){
			kicked = false;
			kill();
			}
		}
	}
	
	/**
	 * Sets the graphics and all the variables to make this sprite kicked.
	 * @param	s The sprite to build the kickSprite from.
	 */
	public function makeKickSprite(s:Entity) {
		makeGraphic(150, 150, FlxColor.TRANSPARENT,true);
		stamp(s);
		
		reset(Reg.getPoint(0).x, Reg.getPoint(0).y);
		
		acceleration.y = 500;
		velocity.x = 200+ FlxRandom.floatRanged(-50,50);
		velocity.y = -400 + FlxRandom.floatRanged(-100,100);
		elapsed = 0;
	}
	
	public function buildSprite(kicker:Bool, stamp:FlxSprite) {
		walkThePlank = kicker;
		makeGraphic(150, 150, FlxColor.TRANSPARENT, true);
		this.stamp(stamp);
	}
	
	var tween:VarTween;
	
	/**
	 * Moves this entity to a point.
	 * @param	p destination.
	 */
	public function advance(p:FlxPoint) {
		if (tween != null)
		tween.cancel();
		if (p != null) 
			tween = FlxTween.tween(this, { x:p.x, y:p.y }, .1, { ease:FlxEase.quadInOut } );
			else
			setPosition( -200, -200);
	
	}
}