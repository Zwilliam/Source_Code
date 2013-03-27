class ZeroPawn extends UDNPawn
    dependson(UDNPawn);
 
simulated function Tick(float DeltaTime)
{
        local vector tmpLocation;
    super.Tick(DeltaTime);
        tmpLocation = Location;
        tmpLocation.Y = 500;
        SetLocation(tmpLocation);
}

simulated function TakeFallingDamage()
{

}
 
function bool Dodge(eDoubleClickDir DoubleClickMove)
{
	local vector X,Y,Z, TraceStart, TraceEnd, Dir, Cross, HitLocation, HitNormal;
	local Actor HitActor;
	local rotator TurnRot;

	if ( bIsCrouched || bWantsToCrouch || (Physics != PHYS_Walking && Physics != PHYS_Falling) )
		return false;

	TurnRot.Yaw = Rotation.Yaw;
	GetAxes(TurnRot,X,Y,Z);

	
	
if (DoubleClickMove == DCLICK_Forward)
	{
		Dir = X;
		Cross = Y;
	}
	else if (DoubleClickMove == DCLICK_Back)
	{
		Dir = -1 * X;
		Cross = Y;
	}
	else if (DoubleClickMove == DCLICK_Left)
	{
		Dir = -1 * Y;
		Cross = X;
	}
	else if (DoubleClickMove == DCLICK_Right)
	{
		Dir = Y;
		Cross = X;
	}
	if ( AIController(Controller) != None )
		Cross = vect(0,0,0);
	return PerformDodge(DoubleClickMove, Dir,Cross);
}


//function bool DoWallJump( bool bUpdating )
//{
//    local Vector HitLocation, HitNormal, End, Start;
//    local Actor HitActor;
 
//    //Perform trace
//    Start = Location + (Vector(Rotation) * GetCollisionRadius()/2);
//    End = Start + (vector(Rotation) * GetCollisionRadius() * 2.5);
//    HitActor = Trace(HitLocation, HitNormal, End, Start, true,);
//    `Log("Player try to jump on " @ HitActor);
 
//    //check on what we want to jump, we jump only on world surfaces
//    if (HitActor == WorldInfo || HitActor.isA('StaticMeshActor'))
//    {
//        `Log("-Player jump on the wall !");
 
//        self.FaceRotation(rotator(HitNormal), GlobalDeltatime);
//        Controller.SetRotation( rotator(HitNormal) );
 
//        if( HitNormal.Y != 0)
//            HitNormal.Y *= WallJumpBoostXY;
//        else if(HitNormal.X != 0)
//            HitNormal.X *= WallJumpBoostXY;
 
//        Velocity = HitNormal;
 
//        //PlayerController(Controller).PlaySound(playerSoundWallJump, false, true);
 
//        Velocity.Z = JumpZ + WallJumpBoostZ;
 
//        return true;
//    }
 
//    return false;
//}

 
defaultproperties
{
 ControllerClass=class'Zero.ZeroBot'
 bCanStrafe=false
DefaultAirControl=+0.65
 MaxStepHeight=50.0
 MaxJumpHeight=96
 JumpZ=550
 WallJumpBoostXY=1
}