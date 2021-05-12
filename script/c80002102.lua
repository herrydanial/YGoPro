--PSYFrame Circuit
function c80002102.initial_effect(c)
	
	-- Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)
	
	-- Synchro
    local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCondition(c80002102.spcon)
	e2:SetTarget(c80002102.sptg)
	e2:SetOperation(c80002102.spop)
	c:RegisterEffect(e2)
	
	-- Atk
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_START)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCondition(c80002102.condition)
	e3:SetCost(c80002102.cost)
	e3:SetOperation(c80002102.operation)
	c:RegisterEffect(e3)
end

--Synchro
function c80002102.filter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xd5) and c:IsControler(tp)
end
function c80002102.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c80002102.filter,1,nil,tp)
end
function c80002102.mfilter(c)
	return c:IsSetCard(0xd5)
end
function c80002102.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetMatchingGroup(c80002102.mfilter,tp,LOCATION_MZONE,0,nil)
		return Duel.IsExistingMatchingCard(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,1,nil,nil,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c80002102.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local mg=Duel.GetMatchingGroup(c80002102.mfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,nil,mg)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SynchroSummon(tp,sg:GetFirst(),nil,mg)
	end
end

--Atk
function c80002102.afilter(c)
	return c:IsSetCard(0xd5) and c:IsAbleToGraveAsCost() and c:IsType(TYPE_MONSTER)
end
function c80002102.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=Duel.GetAttackTarget()
	if not c then return false end
	if c:IsControler(1-tp) then c=Duel.GetAttacker() end
	e:SetLabelObject(c)
	return c and c:IsSetCard(0xd5) and c:IsRelateToBattle()
end
function c80002102.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80002102.afilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c80002102.afilter,tp,LOCATION_HAND,0,1,1,nil,tp)
	local atk=g:GetFirst():GetAttack()
	e:SetLabel(atk)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
end
function c80002102.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local c=e:GetLabelObject()
	local atk=e:GetLabel()
	if c:IsFaceup() and c:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(atk)
		c:RegisterEffect(e1)
	end
end