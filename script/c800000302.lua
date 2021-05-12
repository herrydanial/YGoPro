--不知火流 燕の太刀
function c800000302.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,800000302+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCost(c800000302.cost)
	e1:SetTarget(c800000302.target)
	e1:SetOperation(c800000302.activate)
	c:RegisterEffect(e1)
end
function c800000302.filter(c)
	return c:IsSetCard(0xd9) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c800000302.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c800000302.desfilter(c,tc,ec)
	return c:GetEquipTarget()~=tc and c~=ec
end
function c800000302.costfilter(c,ec,tp)
	if not c:IsRace(RACE_ZOMBIE) then return false end
	return Duel.IsExistingTarget(c800000302.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,2,c,c,ec)
end
function c800000302.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField() and chkc~=c end
	if chk==0 then
		if e:GetLabel()==1 then
			e:SetLabel(0)
			return Duel.CheckReleaseGroup(tp,c800000302.costfilter,1,c,c,tp)
				and Duel.IsExistingMatchingCard(c800000302.filter,tp,LOCATION_DECK,0,1,nil)
		else
			return Duel.IsExistingTarget(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,2,c)
				and Duel.IsExistingMatchingCard(c800000302.filter,tp,LOCATION_DECK,0,1,nil)
		end
	end
	if e:GetLabel()==1 then
		e:SetLabel(0)
		local sg=Duel.SelectReleaseGroup(tp,c800000302.costfilter,1,1,c,c,tp)
		Duel.Release(sg,REASON_COST)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,2,2,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function c800000302.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if Duel.Destroy(g,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local rg=Duel.SelectMatchingCard(tp,c800000302.filter,tp,LOCATION_DECK,0,1,1,nil)
		if rg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
		end
	end
end
