--バリア・バブル
--Barrier Bubble
function c80100164.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c80100164.reptg)
	e2:SetValue(c80100164.repval)
	c:RegisterEffect(e2)
	--[[
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c80100164.target)
	e2:SetValue(c80100164.valcon)
	c:RegisterEffect(e2)
	]]--
	--avoid battle damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c80100164.tg)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c80100164.tg(e,c)
	return c:IsSetCard(0xc6) or c:IsSetCard(0x9f)
end
function c80100164.filter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and (c:IsSetCard(0xc6) or c:IsSetCard(0x9f)) and not c:IsReason(REASON_REPLACE)
		and c:GetFlagEffect(80100164)==0
end
function c80100164.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c80100164.filter,1,nil,tp) end
	return true
end
function c80100164.repval(e,c)
if c80100164.filter(c,e:GetHandlerPlayer()) then
	c:RegisterFlagEffect(80100164,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	return true
else
	return false
end
end
--[[
function c80100164.filter(c,tp)
	return c:IsFaceup() and (c:IsSetCard(0xc6) or c:IsSetCard(0x9f))
end
function c80100164.target(e,c)
	Debug.ShowHint("test")
	return c80100164.filter(c,e:GetHandlerPlayer())
end
function c80100164.valcon(e,re,r,rp)
	Debug.ShowHint("test")
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
function c80100164.op(e,tp,eg,ep,ev,re,r,rp)
	Debug.ShowHint("test")
end
]]--