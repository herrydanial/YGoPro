--Frightfur Sabre Tiger
function c80000143.initial_effect(c)
	c:EnableReviveLimit()
	-- fusion material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c80000143.fscon)
	e1:SetOperation(c80000143.fsop)
	c:RegisterEffect(e1)
	
	-- SS 1 Frightfur
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c80000143.sscondition)
	e2:SetTarget(c80000143.sstarget)
	e2:SetOperation(c80000143.ssoperation)
	c:RegisterEffect(e2)
	
	-- Gain 400 atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xad))
	e3:SetValue(400)
	c:RegisterEffect(e3)
	
	-- Indestructable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetOperation(c80000143.indop)
	c:RegisterEffect(e4)
end

--fusion material
function c80000143.ffiltera(c)
	return c:IsSetCard(0xad) and c:IsType(TYPE_FUSION)
end
function c80000143.ffilterb(c)
	return c:IsSetCard(0xc3) or c:IsSetCard(0xa9)
end
function c80000143.mfilter(c,mg)
	return (mg:IsExists(Card.IsSetCard,1,c,0xad) and mg:IsExists(Card.IsType,1,c,TYPE_FUSION)) 
		and (mg:IsExists(Card.IsSetCard,1,c,0xa9) or mg:IsExists(Card.IsSetCard,1,c,0xc3))
end
function c80000143.fscon(e,mg,gc)
	if mg==nil then return false end
	if gc then return (gc:IsExists(Card.IsSetCard,1,nil,0xad) and gc:IsExists(Card.IsType,1,nil,TYPE_FUSION))
		and (mg:IsExists(Card.IsSetCard,1,gc,0xa9) or mg:IsExists(Card.IsSetCard,1,gc,0xc3)) end
	return mg:IsExists(c80000143.mfilter,1,nil,mg)
end
function c80000143.fsop(e,tp,eg,ep,ev,re,r,rp,gc)
	if gc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=eg:FilterSelect(tp,c80000143.ffilterb,1,63,nil)
		Duel.SetFusionMaterial(g1)
		return
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=eg:FilterSelect(tp,c80000143.ffiltera,1,1,nil,eg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g2=eg:FilterSelect(tp,c80000143.ffilterb,1,63,g1:GetFirst())
	g1:Merge(g2)
	Duel.SetFusionMaterial(g1)
end

--SS 1 Frightfur
function c80000143.sscondition(e,se,sp,st)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c80000143.ssfilter(c,e,tp)
	return c:IsSetCard(0xad) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c80000143.sstarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c80000143.ssfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c80000143.ssfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c80000143.ssfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c80000143.ssoperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
end

--Indestructable
function c80000143.indcon(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c80000143.indop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetMaterialCount()<3 then return false end             
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		c:RegisterEffect(e2)
end