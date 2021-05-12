--Utonomatopia
function c100236020.initial_effect(c)
	--Special summon from multiple archetypes from hand, ignition effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100236020,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,100236020)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c100236020.sptg)
	e1:SetOperation(c100236020.spop)
	c:RegisterEffect(e1)
	--setcode Gagaga
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_ADD_SETCODE)
	e2:SetValue(0x54)
	c:RegisterEffect(e2)
	--setcode Gogogo
	local e3=e2:Clone()
	e3:SetValue(0x59)
	c:RegisterEffect(e3)
	--setcode Dododo
	local e4=e2:Clone()
	e4:SetValue(0x82)
	c:RegisterEffect(e4)
	--setcode Zubaba
	local e5=e2:Clone()
	e5:SetValue(0x8f)
	c:RegisterEffect(e5)
end
	--Check for "Gagaga" monster
function c100236020.spfilter1(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x54) and not c:IsCode(100236020) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
	--Check for "Gogogo" monster
function c100236020.spfilter2(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x59) and not c:IsCode(100236020) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
	--Check for "Dododo" monster
function c100236020.spfilter3(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x82) and not c:IsCode(100236020) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
	--Check for "Zubaba" monster
function c100236020.spfilter4(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x8f) and not c:IsCode(100236020) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
	--Activation legality
function c100236020.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and (Duel.IsExistingMatchingCard(c100236020.spfilter1,tp,LOCATION_HAND,0,1,nil,e,tp)
		or Duel.IsExistingMatchingCard(c100236020.spfilter2,tp,LOCATION_HAND,0,1,nil,e,tp)
		or Duel.IsExistingMatchingCard(c100236020.spfilter3,tp,LOCATION_HAND,0,1,nil,e,tp)
		or Duel.IsExistingMatchingCard(c100236020.spfilter4,tp,LOCATION_HAND,0,1,nil,e,tp))
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
	--Performing the effect of special summoning "Gagaga", "Gogogo", "Dododo", and/or "Zubaba" monster(c100236020) from hand
function c100236020.spop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c100236020.spfilter1,tp,LOCATION_HAND,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(c100236020.spfilter2,tp,LOCATION_HAND,0,nil,e,tp)
	local g3=Duel.GetMatchingGroup(c100236020.spfilter3,tp,LOCATION_HAND,0,nil,e,tp)
	local g4=Duel.GetMatchingGroup(c100236020.spfilter4,tp,LOCATION_HAND,0,nil,e,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>0 and (#g1>0 or #g2>0 or #g3>0 or #g4>0) then
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
		local sg=Group.CreateGroup()
		if g1:GetCount()>0 and ((g2:GetCount()==0 and g3:GetCount()==0 and g4:GetCount()==0) or Duel.SelectYesNo(tp,aux.Stringid(100236020,1))) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg1=g1:Select(tp,1,1,nil)
			sg:Merge(sg1)
			ft=ft-1
		end
		if g2:GetCount()>0 and ft>0 and ((sg:GetCount()==0 and g3:GetCount()==0 and g4:GetCount()==0) or Duel.SelectYesNo(tp,aux.Stringid(100236020,2))) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg2=g2:Select(tp,1,1,nil)
			sg:Merge(sg2)
			ft=ft-1
		end
		if g3:GetCount()>0 and ft>0 and ((sg:GetCount()==0 and g4:GetCount()==0) or Duel.SelectYesNo(tp,aux.Stringid(100236020,3))) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg3=g3:Select(tp,1,1,nil)
			sg:Merge(sg3)
			ft=ft-1
		end
		if g4:GetCount()>0 and ft>0 and (sg:GetCount()==0 or Duel.SelectYesNo(tp,aux.Stringid(100236020,4))) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg4=g4:Select(tp,1,1,nil)
			sg:Merge(sg4)
		end
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		end
	local ge1=Effect.CreateEffect(e:GetHandler())
	ge1:SetType(EFFECT_TYPE_FIELD)
	ge1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	ge1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	ge1:SetTargetRange(1,0)
	ge1:SetTarget(c100236020.splimit)
	ge1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(ge1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_OATH)
	e2:SetDescription(aux.Stringid(100236020,5))
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetTargetRange(1,0)
	Duel.RegisterEffect(e2,tp)
end
	--Extra deck restriction to Xyz monsters
function c100236020.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsType(TYPE_XYZ) and c:IsLocation(LOCATION_EXTRA)
end
