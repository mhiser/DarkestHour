@REM Set your own admin account before you open this server to the internet.
@REM Add ?AdminName=YourName?AdminPassword=YourPassword to the map URL below,
@REM or add AdminUsers entries under [XAdmin.xAdminConfigIni] in xAdmin.ini.
@REM If no admin account exists, the engine creates "Admin" with password "Admin".
@REM Change or remove that account before the server goes public.
ucc server DH-Brecourt_Push.rom?game=DH_Engine.DarkestHourGame?MaxPlayers=64?Mutator=DH_AdminMenuMutator.DHAdminMenuMutator -log=DHServerLog_%RANDOM%.log -mod=DarkestHour -ini=DarkestHour.ini