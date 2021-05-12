--BF－孤高のシルバー・ウィンド
function c800000148.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x33),aux.NonTuner(nil),2)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(800000148,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c800000148.descon)
	e1:SetCost(c800000148.descost)
	e1:SetTarget(c800000148.destg)
	e1:SetOperation(c800000148.desop)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c800000148.drpcon)
	e2:SetTarget(c800000148.drptg)
	e2:SetValue(aux.TRUE)
	c:RegisterEffect(e2)
end
function c800000148.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c800000148.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_BATTLE_PHASE)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c800000148.filter(c,atk)
	return c:IsFaceup() and c:IsDefenseBelow(atk-1)
end
function c800000148.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c800000148.filter(chkc,c:GetAttack()) end
	if chk==0 then return Duel.IsExistingTarget(c800000148.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,c:GetAttack()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c800000148.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,2,nil,c:GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c800000148.desfilter(c,e,atk)
	return c:IsFaceup() and c:IsRelateToEffect(e) and c:IsDefenseBelow(atk-1)
end
function c800000148.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(c800000148.desfilter,nil,e,c:GetAttack())
	Duel.Destroy(sg,REASON_EFFECT)
end
function c800000148.drpcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_BATTLE and tp~=Duel.GetTurnPlayer() and eg:GetFirst():IsSetCard(0x33)
end
function c800000148.drptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(800000148)==0 end
	e:GetHandler():RegisterFlagEffect(800000148,RESET_EVENT+RESETS_STANDARD,0,1)
	return true
end
