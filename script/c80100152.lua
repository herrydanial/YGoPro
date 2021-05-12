--ＤＤＤ狙撃王テル
--D/D/D Tell the Sniper Overlord
function c80100152.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,2,c80100152.ovfilter,aux.Stringid(80100152,0))
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringid(80100152,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c80100152.condition)
	e1:SetCost(c80100152.cost)
	e1:SetTarget(c80100152.target)
	e1:SetOperation(c80100152.operation)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80100152,2))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c80100152.tgcon)
	e2:SetTarget(c80100152.tgtg)
	e2:SetOperation(c80100152.tgop)
	c:RegisterEffect(e2)
	--register
	if not c80100152.global_check then
		c80100152.global_check=true
		c80100152[0]=0
		c80100152[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DAMAGE)
		ge1:SetOperation(c80100152.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c80100152.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c80100152.ovfilter(c)
	return c:IsFaceup() and c:GetRank()==4 and c:IsSetCard(0x10af)
end
function c80100152.checkop(e,tp,eg,ep,ev,re,r,rp)
	if bit.band(r,REASON_EFFECT)~=0 then
		c80100152[ep]=1
	end
end
function c80100152.clear(e,tp,eg,ep,ev,re,r,rp)
	c80100152[0]=0
	c80100152[1]=0
end
function c80100152.condition(e,tp,eg,ep,ev,re,r,rp,chk)
	return c80100152[tp]~=0
end
function c80100152.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c80100152.filter(c)
	return c:IsFaceup() and c:IsAttackAbove(1)
end
function c80100152.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c80100152.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c80100152.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c80100152.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c80100152.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) then
		
			if tc:IsAttackAbove(1) then Duel.Damage(1-tp,1000,REASON_EFFECT) end
			
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(-1000)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENCE)
			tc:RegisterEffect(e2)

	end
end
function c80100152.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_MZONE)
end
function c80100152.tgfilter(c)
	return (c:IsSetCard(0xaf) or c:IsSetCard(0xae)) and c:IsAbleToGrave()
end
function c80100152.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80100152.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c80100152.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c80100152.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
