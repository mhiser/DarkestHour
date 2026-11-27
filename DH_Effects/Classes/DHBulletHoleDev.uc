//=============================================================================
// BulletHoleDev
//=============================================================================
// Projector for bullet impacts on Dev Material (visibility of where shots landed)
//=============================================================================

class DHBulletHoleDev extends ROBulletHole;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
    // Solid square that marks where a bullet landed. The old purple DevImpact
    // texture was lost, and ROBulletHole sets no texture, so this decal drew
    // nothing. The 512 pixel square at this scale is about bullet hole size.
    ProjTexture=Texture'DHEngine_tex.Orange_Square'
    DrawScale=0.01
    LifeSpan=30.0
}
