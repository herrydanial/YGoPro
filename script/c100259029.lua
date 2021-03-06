--銀河眼の残光竜

--Scripted by nekrozar
function c100259029.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100259029,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,100259029)
	e1:SetCondition(c100259029.spcon1)
	e1:SetTarget(c100259029.sptg1)
	e1:SetOperation(c100259029.spop1)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100259029,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,100259129)
	e2:SetCondition(c100259029.spcon2)
	e2:SetTarget(c100259029.sptg2)
	e2:SetOperation(c100259029.spop2)
	c:RegisterEffect(e2)
end
function c100259029.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x107b)
end
function c100259029.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100259029.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c100259029.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c100259029.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c100259029.spcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_COST) and re:IsHasType(0x7e0) and re:IsActiveType(TYPE_MONSTER)
		and c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c100259029.spfilter(c,e,tp)
	return c:IsCode(93717133)
		and (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		or (Duel.IsExistingMatchingCard(c100259029.matfilter,tp,LOCATION_MZONE,0,1,nil) and c:IsCanOverlay()))
end
function c100259029.matfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c100259029.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100259029.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	local bpchk=0
	if Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<PHASE_BATTLE then bpchk=1 end
	e:SetLabel(bpchk)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c100259029.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x48) and c:IsType(TYPE_XYZ)
end
function c100259029.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100259029.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	local res=0
	if tc then
		if Duel.IsExistingMatchingCard(c100259029.matfilter,tp,LOCATION_MZONE,0,1,nil) and tc:IsCanOverlay()
			and (not tc:IsCanBeSpecialSummoned(e,0,tp,false,false) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
				or Duel.SelectOption(tp,1152,aux.Stringid(100259029,2))==1) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
			local sg=Duel.SelectMatchingCard(tp,c100259029.matfilter,tp,LOCATION_MZONE,0,1,1,nil)
			Duel.Overlay(sg:GetFirst(),Group.FromCards(tc))
			res=1
		else
			res=Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		end
		if res~=0 and e:GetLabel()==1 then
			local tg=Duel.GetMatchingGroup(c100259029.atkfilter,tp,LOCATION_MZONE,0,nil)
			local tc=tg:GetFirst()
			while tc do
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_SET_ATTACK_FINAL)
				e1:SetValue(tc:GetAttack()*2)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD)
				tc:RegisterEffect(e1)
				tc=tg:GetNext()
			end
		end
	end
end
