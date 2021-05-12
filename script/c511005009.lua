--Mokusatsu
--  By Shad3

local scard=c511005009

function scard.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DRAW)
	e1:SetCategory(CATEGORY_HANDES+CATEGORY_DRAW)
	e1:SetCondition(scard.cont_cd)
	e1:SetTarget(scard.cont_tg)
	e1:SetOperation(scard.cont_op)
	c:RegisterEffect(e1)
	--Continuous
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DRAW)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCategory(CATEGORY_HANDES+CATEGORY_DRAW)
	e2:SetCondition(scard.cont_cd)
	e2:SetTarget(scard.cont_tg)
	e2:SetOperation(scard.cont_op)
	c:RegisterEffect(e2)
end

function scard.cont_cd(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and r==REASON_RULE
end

function scard.cont_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetParam(Duel.AnnounceCard(tp))
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,1,1-tp,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,1,1-tp,0)
end

function scard.cont_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tg=eg:Filter(Card.IsLocation,nil,LOCATION_HAND)
	if tg:GetCount()>0 then
		-- Revision with OCG ruling
		-- Duel.ConfirmCards(tp,tg)
		local ng=tg:Filter(Card.IsCode,nil,Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM))
		if ng:GetCount()>0 then
			Duel.HintSelection(ng)
			Duel.SendtoGrave(ng,REASON_EFFECT+REASON_DISCARD)
			Duel.ShuffleHand(1-tp)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetReset(RESET_PHASE+PHASE_END)
			e1:SetTargetRange(0,1)
			Duel.RegisterEffect(e1,tp)
		else
			Duel.ShuffleHand(1-tp)
			if Duel.SelectYesNo(1-tp,aux.Stringid(4001,3)) then Duel.Draw(1-tp,1,REASON_EFFECT) end
		end
	end
end