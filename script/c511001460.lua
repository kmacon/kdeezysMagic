local s,id,o=GetID()

-- Edopro Continuous Spell Card Script

-- ZXXXYYY range are reserved for pre-release TCG/OCG cards
-- Passcodes with 9 digits in the 100XXXYYY range are reserved for Video Game cards.
-- Passcodes with 9 digits in the 160XXXYYY range are reserved for Rush cards.
-- Passcodes with 9 digits in the 300XXXYYY range are reserved for skill cards.
-- Passcodes with 9 digits in the 5ZZXXXYYY and 200XXXYYY ranges are reserved for anime/manga cards.

function c511001460.initial_effect(c)
    -- Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DESTROY)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_DESTROYED)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetCondition(c511001460.condition)
    e1:SetTarget(c511001460.target)
    e1:SetOperation(c511001460.activate)
    c:RegisterEffect(e1)
end

function c511001460.condition(e,tp,eg,ep,ev,re,r,rp)
    return eg:IsExists(Card.IsReason,nil,REASON_BATTLE)
end

function c511001460.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
    if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_MZONE,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
    local g=Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,1,0,500)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end

function c511001460.activate(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and tc:IsFaceup() then
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(-500)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e1)
        local e2=e1:Clone()
        e2:SetCode(EFFECT_UPDATE_DEFENSE)
        tc:RegisterEffect(e2)
        local e3=Effect.CreateEffect(e:GetHandler())
        e3:SetType(EFFECT_TYPE_SINGLE)
        e3:SetCode(EFFECT_CANNOT_ATTACK)
        e3:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e3)
        if tc:GetFlagEffect(id)==0 then
            tc:RegisterFlagEffect(id,RESET_EVENT+0x1fe0000,0,1)
        else
            local ct=tc:GetFlagEffectLabel(id)+1
            tc:SetFlagEffectLabel(id,RESET_EVENT+0x1fe0000,0,ct)
            if ct==3 then
                Duel.Destroy(tc,REASON_EFFECT)
            end
        end
    end
end