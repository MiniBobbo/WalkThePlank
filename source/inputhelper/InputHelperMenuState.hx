package inputhelper ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Dave
 */
class InputHelperMenuState extends FlxSubState
{

	//Size variables
	public var BUTTON_TOP = 80;
	public var BUTTON_LEFT = 20;
	
	public var BUTTON_WIDTH = 600;
	public var BUTTON_HEIGHT = 20;
	public var BUTTON_FONT_SIZE = 8;

	
	//Other variables
	public var text:FlxText;
	public var btnKeyAssign:Array<FlxButton>;
	public var btnMessage:FlxButton;
	public var btnBack:FlxButton;

	//Have we selected anything?
	public var chosen = -1;
	
	//Chosen variables.
	public var dimScreen:FlxSprite;
	public var pressKey:FlxText;
	
	var bg:FlxSprite;
	
	override public function destroy():Void 
	{
		super.destroy();
		dimScreen = null;
		pressKey = null;
		text = null;
		btnBack = null;
		btnKeyAssign = null;
		btnMessage = null;
	}
	
	public function new()
	{
		super();
		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = .5;
		add(bg);
		text = new FlxText();
		btnKeyAssign = new Array<FlxButton>();
		btnMessage = new FlxButton((FlxG.width / 2) - (BUTTON_WIDTH / 2), FlxG.height / 2, "");
		btnBack = new FlxButton(0, 0, "Back", back);
		add(btnBack);
		//Create all the buttons we need for assignment.
		for (i in 0...InputHelper.getNumberOfButtons()) {
			//Sets a bunch of button size junk based off the variables supplied.
			var btnTemp = new FlxButton(BUTTON_LEFT, BUTTON_TOP + (BUTTON_HEIGHT * i), InputHelper.getButtonLabel(i), btnClicked);
			btnTemp.setGraphicSize(BUTTON_WIDTH, BUTTON_HEIGHT);
			btnTemp.updateHitbox();
			btnTemp.label = new FlxText(0, 0, btnTemp.width, "");
			btnTemp.label.setFormat(null, BUTTON_FONT_SIZE, 0x333333, "center");
			btnTemp.labelOffsets[FlxButton.NORMAL].y = (BUTTON_HEIGHT/ 2) - (BUTTON_FONT_SIZE);
			btnTemp.labelOffsets[FlxButton.PRESSED].y = (BUTTON_HEIGHT/ 2) - (BUTTON_FONT_SIZE)+2;
			btnTemp.labelOffsets[FlxButton.HIGHLIGHT].y = (BUTTON_HEIGHT / 2) - (BUTTON_FONT_SIZE);
			//btnTemp.resetSize();
			btnKeyAssign.push(btnTemp);
			add(btnTemp);
		}
		updateButtonText();
		text.text;
		add(text);
		
		dimScreen = new FlxSprite(0, 0);
		dimScreen.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		dimScreen.alpha = .5;
		dimScreen.set_visible(false);
		add(dimScreen);
		pressKey = new FlxText(0, 100, FlxG.width, "Press the key to assign:", 40);
		pressKey.visible = false;
		add(pressKey);
	}
	
	override public function update():Void 
	{
		super.update();
		InputHelper.updateKeys(FlxG.elapsed);
		text.text = "";
		if (chosen != -1 && FlxG.keys.getIsDown().length > 0) {
			assign();
		}
		
	}
	
	private function btnClicked() {
		var clicked:FlxPoint = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
		for (i in 0...btnKeyAssign.length) {
			if (btnKeyAssign[i].overlapsPoint(clicked))
				assignKey(i);
		}
		
	}
	
	private function assignKey(b:Int) {
		dimScreen.visible = true;
		pressKey.text = "Press key for " + InputHelper.getButtonLabel(b);
		pressKey.visible = true;
		chosen = b;
	}
	
	private function clearAssignKey() {
		dimScreen.visible = false;
		pressKey.visible = false;
		chosen = -1;
	}
	
	private function assign() {
		InputHelper.assignKeyToButton(FlxG.keys.firstJustPressed() , InputHelper.getButtonLabel(chosen));
		//InputHelper.keyMappedToButton.set(FlxG.keys.firstJustPressed(), chosen);
		clearAssignKey();
		updateButtonText();
	}
	
	/**
	 * Updates the text of the buttons.
	 */
	public function updateButtonText() {
		for (i in 0...btnKeyAssign.length)
			btnKeyAssign[i].text = InputHelper.getButtonLabel(i) + ":    " +  InputHelper.getKeysAssignedToButton(InputHelper.getButtonLabel(i));
	}
	
	/**
	 * Called by the Back button
	 */
	public function back() {
		close();
	}
	

}	
