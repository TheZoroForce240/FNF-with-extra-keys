import flixel.FlxG;
import flixel.input.FlxInput;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionInput;
import flixel.input.actions.FlxActionInputDigital;
import flixel.input.actions.FlxActionManager;
import flixel.input.actions.FlxActionSet;
import flixel.input.gamepad.FlxGamepadButton;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

class KeyBinds
{

    public static var gamepad:Bool = false;

    public static function resetBinds():Void{

        FlxG.save.data.upBind = "W";
        FlxG.save.data.downBind = "S";
        FlxG.save.data.leftBind = "A";
        FlxG.save.data.rightBind = "D";
        FlxG.save.data.killBind = "R";
        FlxG.save.data.gpupBind = "DPAD_UP";
        FlxG.save.data.gpdownBind = "DPAD_DOWN";
        FlxG.save.data.gpleftBind = "DPAD_LEFT";
        FlxG.save.data.gprightBind = "DPAD_RIGHT";

        FlxG.save.data.N0Bind = "A";
        FlxG.save.data.N1Bind = "S";
        FlxG.save.data.N2Bind = "D";
        FlxG.save.data.N3Bind = "F";
        FlxG.save.data.N4Bind = "SPACE";
        FlxG.save.data.N5Bind = "H";
        FlxG.save.data.N6Bind = "J";
        FlxG.save.data.N7Bind = "K";
        FlxG.save.data.N8Bind = "L";

        FlxG.save.data.L1Bind = "S";
        FlxG.save.data.U1Bind = "D";
        FlxG.save.data.R1Bind = "F";
        FlxG.save.data.L2Bind = "J";
        FlxG.save.data.D1Bind = "K";
        FlxG.save.data.R2Bind = "L";
        PlayerSettings.player1.controls.loadKeyBinds();

	}

    public static function keyCheck():Void
    {
        if(FlxG.save.data.upBind == null){
            FlxG.save.data.upBind = "W";
            trace("No UP");
        }
        if (StringTools.contains(FlxG.save.data.upBind,"NUMPAD"))
            FlxG.save.data.upBind = "W";
        if(FlxG.save.data.downBind == null){
            FlxG.save.data.downBind = "S";
            trace("No DOWN");
        }
        if (StringTools.contains(FlxG.save.data.downBind,"NUMPAD"))
            FlxG.save.data.downBind = "S";
        if(FlxG.save.data.leftBind == null){
            FlxG.save.data.leftBind = "A";
            trace("No LEFT");
        }
        if (StringTools.contains(FlxG.save.data.leftBind,"NUMPAD"))
            FlxG.save.data.leftBind = "A";
        if(FlxG.save.data.rightBind == null){
            FlxG.save.data.rightBind = "D";
            trace("No RIGHT");
        }
        if (StringTools.contains(FlxG.save.data.rightBind,"NUMPAD"))
            FlxG.save.data.rightBind = "D";

        
        if(FlxG.save.data.gpupBind == null){
            FlxG.save.data.gpupBind = "DPAD_UP";
            trace("No GUP");
        }
        if(FlxG.save.data.gpdownBind == null){
            FlxG.save.data.gpdownBind = "DPAD_DOWN";
            trace("No GDOWN");
        }
        if(FlxG.save.data.gpleftBind == null){
            FlxG.save.data.gpleftBind = "DPAD_LEFT";
            trace("No GLEFT");
        }
        if(FlxG.save.data.gprightBind == null){
            FlxG.save.data.gprightBind = "DPAD_RIGHT";
            trace("No GRIGHT");
        }
        if(FlxG.save.data.N0Bind == null){
            FlxG.save.data.N0Bind = "A";
            trace("No N0");
        }
        if(FlxG.save.data.N1Bind == null){
            FlxG.save.data.N1Bind = "S";
            trace("No N1");
        }
        if(FlxG.save.data.N2Bind == null){
            FlxG.save.data.N2Bind = "D";
            trace("No N2");
        }
        if(FlxG.save.data.N3Bind == null){
            FlxG.save.data.N3Bind = "F";
            trace("No N3");
        }
        if(FlxG.save.data.N4Bind == null){
            FlxG.save.data.N4Bind = "SPACE";
            trace("No N4");
        }
        if(FlxG.save.data.N5Bind == null){
            FlxG.save.data.N5Bind = "H";
            trace("No N5");
        }
        if(FlxG.save.data.N6Bind == null){
            FlxG.save.data.N6Bind = "J";
            trace("No N6");
        }
        if(FlxG.save.data.N7Bind == null){
            FlxG.save.data.N7Bind = "K";
            trace("No N7");
        }
        if(FlxG.save.data.N8Bind == null){
            FlxG.save.data.N8Bind = "L";
            trace("No N8");
        }

        if(FlxG.save.data.L1Bind == null){
            FlxG.save.data.L1Bind = "S";
            trace("No L1");
        }
        if(FlxG.save.data.U1Bind == null){
            FlxG.save.data.U1Bind = "D";
            trace("No U1");
        }
        if(FlxG.save.data.R1Bind == null){
            FlxG.save.data.R1Bind = "F";
            trace("No R1");
        }
        if(FlxG.save.data.L2Bind == null){
            FlxG.save.data.L2Bind = "J";
            trace("No L2");
        }
        if(FlxG.save.data.D1Bind == null){
            FlxG.save.data.D1Bind = "K";
            trace("No D1");
        }
        if(FlxG.save.data.R2Bind == null){
            FlxG.save.data.R2Bind = "L";
            trace("No R2");
        }

        trace('${FlxG.save.data.leftBind}-${FlxG.save.data.downBind}-${FlxG.save.data.upBind}-${FlxG.save.data.rightBind}');
    }

}