--墓守の使徒
function c85646474.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	--e1:SetDescription(aux.Stringid(85646474,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c85646474.condition)
	e1:SetTarget(c85646474.target)
	e1:SetOperation(c85646474.operation)
	c:RegisterEffect(e1)
	
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(85646474,0))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetCost(c85646474.cost)
	e2:SetTarget(c85646474.target)
	e2:SetOperation(c85646474.operation)
	c:RegisterEffect(e2)
end
function c85646474.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		return true --e:GetHandler():IsAbleToRemoveAsCost() 
	end
	Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
end

function c85646474.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c85646474.filter(c,e,tp)
	return c:IsSetCard(0x2e) and not c:IsCode(85646474) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN)
end
function c85646474.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c85646474.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c85646474.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c85646474.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(1-tp,g)
	end
end
