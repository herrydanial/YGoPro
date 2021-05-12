--ＲＵＭ－ラプターズ・フォース
--Rank-Up-Magic Raptor's Force
function c80100157.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_TARGET)
	e1:SetCondition(c80100157.condition)
	e1:SetTarget(c80100157.target)
	e1:SetOperation(c80100157.activate)
	c:RegisterEffect(e1)
	--regop
	if not c80100157.global_check then
		c80100157.global_check=true
		c80100157[0]=0
		c80100157[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_TO_GRAVE)
		ge1:SetOperation(c80100157.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c80100157.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c80100157.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if tc:IsSetCard(0xba) and tc:IsType(TYPE_XYZ) and tc:IsReason(REASON_DESTROY) then
			c80100157[tc:GetPreviousControler()]=1
		end
		tc=eg:GetNext()
	end
end
function c80100157.clear(e,tp,eg,ep,ev,re,r,rp)
	c80100157[0]=0
	c80100157[1]=0
end
function c80100157.condition(e,tp,eg,ep,ev,re,r,rp)
	return c80100157[tp]~=0
end
function c80100157.filter1(c,e,tp)
	return c:IsSetCard(0xba) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c80100157.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
end
function c80100157.filter2(c,e,tp,mc)
	return c:IsSetCard(0xba) and mc:IsCanBeXyzMaterial(c,true)
		and c:GetRank()==mc:GetRank()+1
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c80100157.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c80100157.filter1(chkc,e,tp) end
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,2)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c80100157.filter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c80100157.filter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c80100157.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not Duel.IsPlayerCanSpecialSummonCount(tp,2) then return end
	local tc1=Duel.GetFirstTarget()	
	if tc1:IsRelateToEffect(e) and Duel.SpecialSummon(tc1,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c80100157.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc1)
		local tc2=g2:GetFirst()
		if tc2 then
			Duel.Overlay(tc2,g1)
			Duel.SpecialSummon(tc2,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
			tc2:CompleteProcedure()
		end
	end
end
