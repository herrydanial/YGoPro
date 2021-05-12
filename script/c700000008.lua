--Magic Removal Virus Cannon
function c700000008.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_TOGRAVE)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetOperation(c700000008.activate)
c:RegisterEffect(e1)
end
function c700000008.filter(c)
return c:IsType(TYPE_SPELL) and c:IsAbleToGrave()
end
function c700000008.activate(e,tp,eg,ep,ev,re,r,rp)
local sg=Duel.SelectMatchingCard(1-tp,c700000008.filter,1-tp,LOCATION_HAND+LOCATION_DECK,0,10,10,nil)
Duel.SendtoGrave(sg,REASON_EFFECT)
end