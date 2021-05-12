--Revival Jam (Anime)
function c700000068.initial_effect(c)
    --Revival
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(700000068,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c700000068.spcon)
	e1:SetTarget(c700000068.sptg)
	e1:SetOperation(c700000068.spop)
	c:RegisterEffect(e1)
end
function c700000068.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_MZONE  and e:GetHandler():IsReason(REASON_DESTROY)
end
function c700000068.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,1,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c700000068.spop(e,tp,eg,ep,ev,re,r,rp)
    if e:GetHandler():IsRelateToEffect(e) then
        local np=e:GetHandler():GetPreviousControler()
        Duel.SpecialSummon(e:GetHandler(),1,np,np,false,false,POS_FACEUP_DEFENSE)
    end
end