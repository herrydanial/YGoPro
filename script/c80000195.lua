--Knight of the Evening Twilight
function c80000195.initial_effect(c)
	-- Search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80000195,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_REMOVE)
	e1:SetCountLimit(1,80000195)
	e1:SetCondition(c80000195.scon)
	e1:SetTarget(c80000195.starget)
	e1:SetOperation(c80000195.soperation)
	c:RegisterEffect(e1)
	
	-- BLS rit Effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c80000195.condition)
	e2:SetOperation(c80000195.operation)
	c:RegisterEffect(e2)
end

--Search
function c80000195.scon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_GRAVE)
end
function c80000195.sfilter(c)
	return c:IsType(TYPE_RITUAL) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c80000195.starget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80000195.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c80000195.soperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c80000195.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

--BLS rit Effect
function c80000195.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL
end
function c80000195.operation(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	while rc do
		if rc:GetFlagEffect(80000195)==0 and rc:IsSetCard(0xcf) then
			-- Banish
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringid(80000195,1))
			e1:SetCategory(CATEGORY_REMOVE)
			e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
			e1:SetType(EFFECT_TYPE_IGNITION)
			e1:SetCountLimit(1)
			e1:SetRange(LOCATION_MZONE)
			e1:SetTarget(c80000195.rmtg)
			e1:SetOperation(c80000195.rmop)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			rc:RegisterEffect(e1,true)
			rc:RegisterFlagEffect(80000195,RESET_EVENT+0x1fe0000,0,1)
			
			-- Banish from Hand
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetDescription(aux.Stringid(80000195,2))
			e2:SetCategory(CATEGORY_REMOVE)
			e2:SetType(EFFECT_TYPE_IGNITION)
			e2:SetCountLimit(1)
			e2:SetRange(LOCATION_MZONE)
			e2:SetTarget(c80000195.bhtg)
			e2:SetOperation(c80000195.bhop)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			rc:RegisterEffect(e2,true)
			rc:RegisterFlagEffect(80000195,RESET_EVENT+0x1fe0000,0,1)
		end
		rc=eg:GetNext()
	end
end

--Banish
function c80000195.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c80000195.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end

--Banish from Hand
function c80000195.bhtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	--if chkc then return true end
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_HAND)
end
function c80000195.bhop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
	if g:GetCount()==0 then return end
	local rg=g:RandomSelect(tp,1)
	local tc=rg:GetFirst()
	Duel.Remove(tc,POS_FACEDOWN,REASON_EFFECT)
	tc:RegisterFlagEffect(80000195,RESET_EVENT+0x1fe0000,0,1)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetLabelObject(tc)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	e1:SetCondition(c80000195.retcon)
	e1:SetOperation(c80000195.retop)
	Duel.RegisterEffect(e1,tp)
end
function c80000195.retcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffect(80000195)==0 then
		e:Reset()
		return false
	else
		return Duel.GetTurnPlayer()==1-tp
	end
end
function c80000195.retop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.SendtoHand(tc,1-tp,REASON_EFFECT)
end