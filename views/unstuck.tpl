<script type="text/javascript">
    $(document).ready(function () {
        function initializeUnstuck() {
            if (typeof Unstuck != "undefined") {
                Unstuck.User.initialize({
                    vp: {$vp},
                    vp_price : {$service_cost_vp},
                    dp: {$dp},
                    dp_price: {$service_cost_dp},
                    gold : {$service_gold}
                });
            } else {
                setTimeout(initializeUnstuck, 50);
            }
        }

        initializeUnstuck();
    });
</script>

<div class="unstuck">
    <div class="page-desc-holder">
        {lang('description', 'unstuck')}
    </div>

    <form onSubmit="Unstuck.Submit(this); return false;">
        <div class="container_3 account-wide">
            <div class="row justify-content-center">
                <div class="col-sm-12 col-lg-5 mt-4">
                    <select name="realm" id="realm" onChange="Unstuck.RealmChanged();">
                        {if $characters}
                            {foreach from=$characters item=realm}
                                <option value="{$realm.realmId}">{$realm.realmName}</option>
                            {/foreach}
                        {else}
                            <option value="0">{lang('no_realm', 'unstuck')}</option>
                        {/if}
                    </select>
                </div>

                <div class="col-sm-12 col-lg-2 text-center">
                    <input type="submit" class="cooldown-ico" value="" data-bs-html="true" data-bs-toggle="tooltip" data-bs-title="{lang('take_me_home', 'unstuck')}"/>
                </div>

                <div class="col-sm-12 col-lg-5 mt-4">
                    {foreach from=$characters item=realm}
                        <select {if !$realm@first}style="display:none"{/if} name="character_selector" data-character id="character_select_{$realm.realmId}" onChange="Unstuck.CharacterChanged(this, {$realm.realmId});">
                            {if $realm.characters}
                                <option value="0">{lang('no_char_selected', 'unstuck')}</option>
                                {foreach from=$realm.characters item=character}
                                  {if $character.online == 0}
                                    <option value="{$character.guid}">{$character.name} - Lvl {$character.level}</option>
                                  {/if}
                                {/foreach}
                            {else}
                                <option value="0">{lang('no_character', 'unstuck')}</option>
                            {/if}
                        </select>
                    {/foreach}
                </div>
            </div>
            <div class="clear"></div>
            <div class="description-small">
                {lang('notify', 'unstuck')}<br>
                {if !$service_cost_vp &&  !$service_gold && !$service_cost_dp }
                     {lang('is_free', 'unstuck')}
                {elseif $service_cost_vp}
                    <div id="cost">{lang('service_fee', 'unstuck')}  <img src="http://localhost/application/images/icons/lightning.png" align="absmiddle">  VP {$service_cost_vp} </div>
                {elseif $service_cost_dp}
                    <div id="cost">{lang('service_fee', 'unstuck')}  <img src="http://localhost/application/images/icons/coins.png" align="absmiddle">   DP  {$service_cost_dp}  </div>
                {elseif $service_gold}
                    <div id="cost">{lang('service_fee', 'unstuck')}  <img src="{$url}application/modules/playtime/img/money-gold.gif" align="absmiddle" height="15" width="15" /> {$service_gold} </div>
                {/if}
            </div>
        </div>
    </form>
</div>
