SWEP.Author = "XmegaaAAa" -- Original Author : Hasster. Credits to him :)
SWEP.Purpose = ""
SWEP.PrintName = "Famas"
SWEP.Slot = 2
SWEP.SlotPos = 3
SWEP.ViewModelFlip = false -- Flip the model? Usally used for CS:S models
SWEP.ViewModelFOV = 54
SWEP.IconLetter = "x"
SWEP.Base = "weapon_base"
SWEP.Category = "Counter Strike: Source"
SWEP.ViewModel = "models/weapons/cstrike/c_rif_famas.mdl"
SWEP.WorldModel = "models/weapons/w_rif_famas.mdl"
SWEP.UseHands = true
SWEP.ReloadSound = "Weapon_SMG1.Reload"
SWEP.HoldType = "ar2"
SWEP.CSMuzzleFlashes = true
SWEP.Weight = 40
SWEP.AutoSwitchTo = true
SWEP.Spawnable = true
SWEP.Primary.Sound = Sound("weapons/famas/famas-1.wav")
SWEP.Primary.Damage = 17
SWEP.Primary.NumShots = 0
SWEP.Primary.Recoil = 3
SWEP.Primary.Cone = 2.4
SWEP.Primary.Delay = 0.2
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false
SWEP.Primary.ClipSize = 25
SWEP.Primary.DefaultClip = 160
SWEP.Primary.Force = 3
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "AR2"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.data = {}
SWEP.mode = "auto"
SWEP.data.auto = {}
SWEP.data.burst = {}
SWEP.data.burst.Delay = 0.08
SWEP.data.burst.Cone = 0.015
SWEP.data.burst.BurstDelay = 0.07
SWEP.data.burst.Shots = 3
SWEP.data.burst.Counter = 0
SWEP.data.burst.Timer = 0

function SWEP:Initialize()
    self:SetWeaponHoldType(self.HoldType)
end

function SWEP:PrimaryAttack()
    if (not self:CanPrimaryAttack()) then return end
    local bullet = {} -- Set up the shot
    bullet.Num = self.Primary.NumShots
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Spread = Vector(self.Primary.Cone / 90, self.Primary.Cone / 90, 0)
    bullet.Tracer = self.Primary.Tracer
    bullet.Force = self.Primary.Force
    bullet.Damage = self.Primary.Damage
    bullet.AmmoType = self.Primary.Ammo
    self.Owner:MuzzleFlash()
    self:EmitSound(Sound("weapons/famas/famas-1.wav"))
    self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self.Owner:FireBullets(bullet)

    if (self.Zoom == 1) then
        if (not self:CanPrimaryAttack()) then return end
        self.Primary.Delay = 0.1
        self:EmitSound(Sound("weapons/famas/famas-1.wav"))
        self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
        self.Owner:SetAnimation(PLAYER_ATTACK1)
    end

    if (self.Zoom == 0) then
        self.Primary.Delay = 0.5
        self.Owner:MuzzleFlash()

        timer.Create("First", 0.07, 1, function()
            if (not self:CanPrimaryAttack()) then return end

            if (self.Owner:IsPlayer()) then
                self.Owner:ViewPunch(Angle(-0.5, 0, 0))
            end

            bullet.Num = self.Primary.NumShots
            bullet.Src = self.Owner:GetShootPos()
            bullet.Dir = (self.Owner:GetAimVector(-5))
            bullet.Tracer = self.Primary.Tracer
            bullet.Force = self.Primary.Force
            bullet.Damage = self.Primary.Damage
            bullet.AmmoType = self.Primary.Ammo
            self.Owner:MuzzleFlash()
            self.Owner:FireBullets(bullet)
            self:EmitSound(Sound("weapons/famas/famas-1.wav"))
            self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
            self.Owner:SetAnimation(PLAYER_ATTACK1)

            -- I have enough of these NPCs trying to shoot even if the gun is empty.
            if (self.Owner:IsPlayer()) then
                self:TakePrimaryAmmo(1)
            end
        end)

        timer.Create("Second", 0.15, 1, function()
            if (not self:CanPrimaryAttack()) then return end
            bullet.Num = self.Primary.NumShots
            self.Primary.Cone = 6.9

            if (self.Owner:IsPlayer()) then
                self.Owner:ViewPunch(Angle(-0.5, 0, 0))
            end

            bullet.Src = self.Owner:GetShootPos()
            bullet.Dir = self.Owner:GetAimVector()
            bullet.Tracer = self.Primary.Tracer
            bullet.Force = self.Primary.Force
            bullet.Damage = self.Primary.Damage
            bullet.AmmoType = self.Primary.Ammo
            self.Owner:MuzzleFlash()
            self.Owner:FireBullets(bullet)
            self:EmitSound(Sound("weapons/famas/famas-1.wav"))
            self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
            self.Owner:SetAnimation(PLAYER_ATTACK1)

            -- I have enough of these NPCs trying to shoot even if the gun is empty.
            if (self.Owner:IsPlayer()) then
                self:TakePrimaryAmmo(1)
            end
        end)

        self:EmitSound(Sound("weapons/famas/famas-1.wav"))
        self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
        self.Owner:SetAnimation(PLAYER_ATTACK1)
    end

    if (self.Owner:IsPlayer()) then
        self.Owner:ViewPunch(Angle(-0.5, 0, 0))

        if (self.Primary.TakeAmmoPerBullet) then
            self:TakePrimaryAmmo(self.Primary.NumShots)
        else
            self:TakePrimaryAmmo(1)
        end
    end

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end

function SWEP:SecondaryAttack()
    if (self.Zoom == 0) then
        self.Zoom = 1
        self.Weapon:SetNextPrimaryFire(CurTime() + 0.2)
        self.Weapon:SetNextSecondaryFire(CurTime() + 0.2)
        self:NextThink(2)
    else
        if (self.Zoom == 1) then
            self.Zoom = 0
            self.Weapon:SetNextPrimaryFire(CurTime() + 0.2)
            self.Weapon:SetNextSecondaryFire(CurTime() + 0.2)
            self:NextThink(2)
        end
    end
end

function SWEP:DrawHUD()
    local x, y
    x, y = ScrW() / 2.0, ScrH() / 2.0
    local scale = 10 * self.Primary.Cone
    local LastShootTime = self.Weapon:GetNetworkedFloat("LastShootTime", 0)
    scale = scale * (2 - math.Clamp((CurTime() - LastShootTime) * 5, 0.0, 1.0))
    surface.SetDrawColor(0, 255, 0, 255)
    local gap = 0.9 * scale
    local length = gap + 0.4 * scale
    surface.DrawLine(x - length, y, x - gap, y)
    surface.DrawLine(x + length, y, x + gap, y)
    surface.DrawLine(x, y - length, x, y - gap)
    surface.DrawLine(x, y + length, x, y + gap)
end

function SWEP:Think()
    local ground = self.Owner:GetGroundEntity()

    if self.Owner:KeyDown(IN_FORWARD) and not self.Owner:KeyDown(IN_DUCK) and (ground:IsWorld() or ground:IsWorld()) then
        self.Primary.Cone = 3.5
    elseif self.Owner:KeyDown(IN_BACK) and self.Owner:KeyDown(IN_DUCK) and (IsValid(ground) or ground:IsWorld()) then
        self.Primary.Cone = 2
    elseif self.Owner:KeyDown(IN_MOVELEFT) and self.Owner:KeyDown(IN_DUCK) and (IsValid(ground) or ground:IsWorld()) then
        self.Primary.Cone = 2
    elseif self.Owner:KeyDown(IN_MOVERIGHT) and self.Owner:KeyDown(IN_DUCK) and (IsValid(ground) or ground:IsWorld()) then
        self.Primary.Cone = 2
    elseif self.Owner:KeyDown(IN_FORWARD) and self.Owner:KeyDown(IN_DUCK) and (IsValid(ground) or ground:IsWorld()) then
        self.Primary.Cone = 2
    elseif self.Owner:KeyDown(IN_BACK) and not self.Owner:KeyDown(IN_DUCK) and (ground:IsWorld() or ground:IsWorld()) then
        self.Primary.Cone = 3.5
    elseif self.Owner:KeyDown(IN_MOVELEFT) and not self.Owner:KeyDown(IN_DUCK) and (ground:IsWorld() or ground:IsWorld()) then
        self.Primary.Cone = 3.5
    elseif self.Owner:KeyDown(IN_MOVERIGHT) and not self.Owner:KeyDown(IN_DUCK) and (ground:IsWorld() or ground:IsWorld()) then
        self.Primary.Cone = 3.5
    elseif self.Owner:KeyDown(IN_DUCK) and (IsValid(ground) or ground:IsWorld()) then
        self.Primary.Cone = 1.4
    elseif not ground:IsWorld() or not ground:IsWorld() then
        self.Primary.Cone = 4.6
    else
        self.Primary.Cone = 2.5
    end
end

function SWEP:Reload()
    self.Weapon:DefaultReload(ACT_VM_RELOAD)

    return true
end

function SWEP:Deploy()
    self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
    self.Zoom = 1
    --self.Reloadaftershoot = CurTime() + 1
    self.Weapon:SetNextPrimaryFire(CurTime() + 1)

    return true
end

function SWEP:CSShootBullet(dmg, recoil, numbul, cone)
    numbul = numbul or 1
    cone = cone or 0.01
    local bullet = {}
    bullet.Num = numbul
    bullet.Src = self.Owner:GetShootPos() -- Source
    bullet.Dir = self.Owner:GetAimVector() -- Dir of bullet
    bullet.Spread = Vector(cone, cone, 0) -- Aim Cone
    bullet.Tracer = 4 -- Show a tracer on every x bullets 
    bullet.Force = 5 -- Amount of force to give to phys objects
    bullet.Damage = dmg
    self.Owner:FireBullets(bullet)

    if self.Weapon:Clip1() == 1 then
        self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
        local Animation = self.Owner:GetViewModel()
        Animation:SetSequence(Animation:LookupSequence(self.LastShoot))
        self.Owner:MuzzleFlash()
    else
        self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
        self.Owner:MuzzleFlash()
    end

    self.Owner:SetAnimation(PLAYER_ATTACK1) -- 3rd Person Animation
    if (self.Owner:IsNPC()) then return end

    -- CUSTOM RECOIL not 
    if ((game.SinglePlayer() and SERVER) or (not game.SinglePlayer() and CLIENT and IsFirstTimePredicted())) then
        local eyeang = self.Owner:EyeAngles()
        eyeang.pitch = eyeang.pitch - 0.7
        self.Owner:SetEyeAngles(eyeang)
    end
end

function SWEP:Holster()
    self.Zoom = 1

    return true
end

-- Fonctionnement de l'arme par NPCs
function SWEP:GetCapabilities()
    -- The NPC capabilities.
    return bit.bor(CAP_WEAPON_RANGE_ATTACK1, CAP_INNATE_RANGE_ATTACK1)
end

function SWEP:CanBePickedUpByNPCs()
    -- Weapon can be picked up by NPCs?
    return true
end

function SWEP:ShouldDropOnDie()
    -- Weapon should be dropped on death?
    return true
end

function SWEP:GetNPCRestTimes()
    -- Handles the time between bursts.
    -- First var is min, second var is max. (All in seconds)
    -- Rest time before the NPC shoots again.
    return 0.35, 0.5
end

function SWEP:GetNPCBurstSettings()
    -- Burst parameters
    -- 1st var is minimal burst number, 2nd var is maximal, 3rd var is the delay between each shots.
    -- The delay between each shots if weapon is automatic
    return 4, 7, self.Primary.Delay
end

function SWEP:GetNPCBulletSpread(proficiency)
    -- Determine the accuracy of the NPC holding the weapon. (We call that the Proficiency)
    -- The lower the var, the more accurate the NPC is. (Var in degrees)
    return 0.14
end