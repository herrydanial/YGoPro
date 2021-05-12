--Mirror Knight Calling
function c700000126.initial_effect(c)
	c:EnableReviveLimit()
	--Special Summon Tokens
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c700000126.spcon)
	e1:SetTarget(c700000126.sptg)
	e1:SetOperation(c700000126.spop)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(63253763,0))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c700000126.cttg)
	e2:SetOperation(c700000126.ctop)
	c:RegisterEffect(e2)
	--Activate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetCondition(c700000126.con)
	e3:SetOperation(c700000126.op)
	e3:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e3)
end
function c700000126.spcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_RITUAL)==SUMMON_TYPE_RITUAL
end
function c700000126.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,4,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,4,tp,0)
end
function c700000126.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<3 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,700000127,0x530,0x4011,0,0,1,RACE_WARRIOR,ATTRIBUTE_DARK) then return end
	for i=1,4 do
		local token=Duel.CreateToken(tp,700000127)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		token:AddCounter(0x1106,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EFFECT_DESTROY_REPLACE)
		e1:SetTarget(c700000126.reptg)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1)
	end
	Duel.SpecialSummonComplete()
end
function c700000126.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsReason(REASON_REPLACE) and e:GetHandler():GetCounter(0x1106)>0 end
	e:GetHandler():RemoveCounter(tp,0x1106,1,REASON_EFFECT)
	return true
end
function c700000126.filter(c,ct)
	return c:GetCounter(0x1106)==ct and c:IsFaceup() and c:IsCode(700000127)
end
function c700000126.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c700000126.filter,tp,LOCATION_MZONE,0,1,nil,0) end
end
function c700000126.ctop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c700000126.filter,tp,LOCATION_MZONE,0,nil,0)
	local tc=g:GetFirst()
	while tc do
		tc:AddCounter(0x1106,1)
		tc=g:GetNext()
	end
end
function c700000126.con(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	local g=Group.FromCards(a,d)
	return g:IsExists(c700000126.filter,1,nil,1)
end
function c700000126.op(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return end
	local g=Group.FromCards(a,d)
	g=g:Filter(c700000126.filter,nil,1)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		if tc==a then
			e1:SetValue(d:GetAttack())
		else
			e1:SetValue(a:GetAttack())
		end
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
