package ;

import flixel.effects.FlxSpriteFilter;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import inputhelper.InputHelper;

/**
 * ...
 * @author Dave
 */
class StartState extends FlxSubState
{

	var bg:FlxSprite;
	var levelNumber:FlxText;
	var levelGoal:FlxText;
	var levelHint:FlxText;
	
	var kick:FlxText;
	var keep:FlxText;
	
	var showKickers:Array<FlxSprite>;
	var showKeepers:Array<FlxSprite>;
	
	public function new(BGColor:Int=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = .8;
		add(bg);
		
		kick = new FlxText(150, 30, 0, "KICK" , 40);
		keep= new FlxText(550, 30, 0, "KEEP" , 40);
		
		add(kick);
		add(keep);
		
		showKickers = new Array<FlxSprite>();
		showKeepers = new Array<FlxSprite>();
		
		for (s in Reg.kickSprites){
			var ns = new FlxSprite();
			ns.makeGraphic(150, 150, FlxColor.TRANSPARENT, true);
			ns.stamp(s);
			showKickers.push(ns);
		}
		for (s in Reg.keepSprites){
			var ns = new FlxSprite();
			ns.makeGraphic(150, 150, FlxColor.TRANSPARENT, true);
			ns.stamp(s);
			showKeepers.push(ns);
		}
		
		for (i in 0...showKickers.length) {
			showKickers[i].reset( 20 + (80*(i%4)), 100 + (130*(Math.ffloor(i/4)) ));
			add(showKickers[i]);
		}
		for (i in 0...showKeepers.length) {
			showKeepers[i].reset( 420 + (80*(i%4)), 100 + (130*(Math.ffloor(i/4)) ));
			add(showKeepers[i]);
		}
		
		levelHint = new FlxText(20, 500, 760, Reg.levelHint, 15);
		add(levelHint);
		levelNumber = new FlxText(0, 20, FlxG.width, "Level " + Reg.levelNum + "/" + Reg.MAX_LEVEL + "\nGoal: " + Reg.goal, 25);
		levelNumber.setFormat(null, 30, FlxColor.YELLOW, "center");
		add(levelNumber);
		
	}
	
	
	override public function update():Void 
	{
		super.update();
		InputHelper.updateKeys();
		if (InputHelper.isButtonJustPressed("kick")|| InputHelper.isButtonJustPressed("keep"))
		this.close();
	}
	
}