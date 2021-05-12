--Super Quantum Mecha Ship Magnacarrier
function c80002038.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80002038,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(c80002038.cost)
	e2:SetTarget(c80002038.target)
	e2:SetOperation(c80002038.activate)
	c:RegisterEffect(e2)
	--special summon Great Magnus
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(80002038,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCost(c80002038.spcost)
	e3:SetTarget(c80002038.sptg)
	e3:SetOperation(c80002038.spop)
	c:RegisterEffect(e3)
end

function c80002038.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c80002038.filter1(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x10db)
		and Duel.IsExistingMatchingCard(c80002038.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,c:GetAttribute())
end
function c80002038.filter2(c,e,tp,mc,att)
	return c:IsAttribute(att) and mc:IsCanBeXyzMaterial(c) and c:IsSetCard(0x20db)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c80002038.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c80002038.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c80002038.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c80002038.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c80002038.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c80002038.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetAttribute())
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end

function c80002038.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c80002038.spfilter(c,e,tp)
	return c:IsSetCard(0x20db) and c:IsType(TYPE_XYZ)
end
function c80002038.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c80002038.spfilter,tp,LOCATION_GRAVE+LOCATION_MZONE,0,nil,e,tp)
	if chk==0 then return (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		or (Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.IsExistingMatchingCard(c80002038.spfilter,tp,LOCATION_MZONE,0,1,nil,e,tp)))
		and g:GetClassCount(Card.GetCode)>=3 
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EXTRA,0,1,nil,80002037) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g1=nil
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then
		local sg=Duel.GetMatchingGroup(c80002038.spfilter,tp,LOCATION_MZONE,0,nil,e,tp)
		g1=sg:Select(tp,1,1,nil)
		g:Remove(Card.IsCode,nil,g1:GetFirst():GetCode())
	else
		g1=g:Select(tp,1,1,nil)
		g:Remove(Card.IsCode,nil,g1:GetFirst():GetCode())
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g2=g:Select(tp,1,1,nil)
	g:Remove(Card.IsCode,nil,g2:GetFirst():GetCode())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g3=g:Select(tp,1,1,nil)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.SetTargetCard(g1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c80002038.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 and not Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EXTRA,0,1,nil,80002037) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g:GetCount()<3 then return end
	local tc=g:GetFirst()
	for i=1,3 do
		if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
		tc=g:GetNext()
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_EXTRA,0,1,1,nil,80002037)
	local sc=tg:GetFirst()
	if sc and sc:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		tc=g:GetFirst()
		local mg1=tc:GetOverlayGroup()
		tc=g:GetNext()
		local mg2=tc:GetOverlayGroup()
		mg1:Merge(mg2)
		tc=g:GetNext()
		local mg3=tc:GetOverlayGroup()
		mg1:Merge(mg3)
		if mg1:GetCount()~=0 then
			Duel.Overlay(sc,mg1)
		end
		sc:SetMaterial(g)
		Duel.Overlay(sc,g)
		Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end