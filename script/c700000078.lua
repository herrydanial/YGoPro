--ディフェンド·スライム
function c700000078.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetTarget(c700000078.atktg1)
	e1:SetOperation(c700000078.atkop)
	c:RegisterEffect(e1)
	--change target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(700000078,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c700000078.atkcon)
	e2:SetTarget(c700000078.atktg2)
	e2:SetOperation(c700000078.atkop)
	c:RegisterEffect(e2)
end
function c700000078.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetAttackTarget()~=nil
end
function c700000078.filter(c)
	return c:IsFaceup() and c:IsCode(700000068)
end
function c700000078.atktg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c700000078.filter(chkc) end
	if chk==0 then return true end
	e:SetProperty(0)
	if Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and tp~=Duel.GetTurnPlayer() then
		local at=Duel.GetAttackTarget()
		if at and Duel.IsExistingTarget(c700000078.filter,tp,LOCATION_MZONE,0,1,at) and Duel.SelectYesNo(tp,aux.Stringid(700000078,1)) then
			e:SetProperty(EFFECT_FLAG_CARD_TARGET)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
			Duel.SelectTarget(tp,c700000078.filter,tp,LOCATION_MZONE,0,1,1,at)
		end
	end
end
function c700000078.atktg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c700000078.filter(chkc) end
	local at=Duel.GetAttackTarget()
	if chk==0 then return Duel.IsExistingTarget(c700000078.filter,tp,LOCATION_MZONE,0,1,at) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c700000078.filter,tp,LOCATION_MZONE,0,1,1,at)
end
function c700000078.atkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.ChangeAttackTarget(tc)
	end
end
