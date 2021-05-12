--Painful Escape
function c80004081.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c80004081.target)
	e1:SetOperation(c80004081.activate)
	c:RegisterEffect(e1)
end

function c80004081.ctffilter(c,ct,ca,cl,cn)
	return c:IsAbleToHand() c:GetOriginalRace()==ct and c:GetOriginalAttribute()==ca and c:GetOriginalLevel()==cl and c:GetOriginalCode()~=cn
end
function c80004081.ctfilter(c)
	local ct=c:GetOriginalRace()
	local ca=c:GetOriginalAttribute()
	local cl=c:GetOriginalLevel()
	local cn=c:GetOriginalCode()
	return Duel.IsExistingMatchingCard(c80004081.ctffilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,ct,ca,cl,cn)
end
function c80004081.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80004081.ctffilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	Duel.CheckReleaseGroup(tp,c80004081.ctffilter,1,nil)
	local g=Duel.SelectReleaseGroup(tp,c80004081.ctffilter,1,1,nil)
	local tc=g:GetFirst()
	Duel.Release(g,REASON_COST)
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c80004081.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c80004081.ctffilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,tc:GetOriginalRace(),tc:GetOriginalAttribute(),tc:GetOriginalLevel(),tc:GetOriginalCode())
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end