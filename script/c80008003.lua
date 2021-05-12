--Exod Flame
function c80008003.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c80008003.target)
	e1:SetOperation(c80008003.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,80008003)
	e2:SetHintTiming(0,0x1e0)
	e2:SetCost(c80008003.cost)
	e2:SetTarget(c80008003.ctarget)
	e2:SetOperation(c80008003.activate)
	e2:SetLabel(1)
	c:RegisterEffect(e2)
	--grave to hand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,80008003)
	e3:SetCondition(c80008003.thcon)
	e3:SetCost(c80008003.cost)
	e3:SetTarget(c80008003.thtg)
	e3:SetOperation(c80008003.thop)
	c:RegisterEffect(e3)
end

function c80008003.filter(c)
	return (c:IsType(TYPE_MONSTER) and c:IsSetCard(0x40)) or c:IsSetCard(0xde)
end
function c80008003.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToHand() and Duel.IsExistingMatchingCard(c80008003.filter,tp,LOCATION_HAND,0,1,nil) end
	if chk==0 then return true end
	if Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
	and Duel.GetFlagEffect(tp,80008003)==0 and Duel.SelectYesNo(tp,94) then
		Duel.RegisterFlagEffect(tp,80008003,RESET_PHASE+PHASE_END,0,1)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
		e:SetLabel(1)
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetLabel(0)
	end
end
function c80008003.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,80008003)==0 end
	Duel.RegisterFlagEffect(tp,80008003,RESET_PHASE+PHASE_END,0,1)
end
function c80008003.ctarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(c80008003.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c80008003.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 or not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.SelectMatchingCard(tp,c80008003.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil)
	local tg=g:GetFirst()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tg and Duel.SendtoGrave(tg,REASON_EFFECT)~=0 and tg:IsLocation(LOCATION_GRAVE) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end

function c80008003.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_SZONE)
end
function c80008003.thfilter(c)
	return ((c:IsType(TYPE_MONSTER) and c:IsSetCard(0x40)) or c:IsSetCard(0xde)) and c:IsAbleToHand()
end
function c80008003.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c80008003.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c80008003.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c80008003.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c80008003.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end