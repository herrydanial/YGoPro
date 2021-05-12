--Sakuriboh
function c80000403.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_RELEASE)
	e1:SetTarget(c80000403.target)
	e1:SetOperation(c80000403.activate)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c80000403.reptg)
	e2:SetValue(c80000403.repval)
	e2:SetOperation(c80000403.repop)
	c:RegisterEffect(e2)
end
function c80000403.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c80000403.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end


function c80000403.repfilter(c,tp)
	return c:IsFaceup() and c:IsOnField() and c:IsControler(tp) and c:IsReason(REASON_BATTLE)
end
function c80000403.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c80000403.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(80000403,0))
end
function c80000403.repval(e,c)
	return c80000403.repfilter(c,e:GetHandlerPlayer())
end
function c80000403.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
