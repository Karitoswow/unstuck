const Unstuck = {

    User: {
        vp: null,
        dp: null,
        dp_price: 0,
        vp_price: 0,
        gold : 0 ,
        character: 0,

        initialize: function (vp,vp_price ,dp ,dp_price , gold) {
            this.vp = vp;
            this.dp = dp;
            this.dp_price = dp_price ;
            this.vp_price = vp_price ;
            this.gold = gold ;

        }
    },

    RealmChanged: function () {
        const realmId = $('select[id="realm"]').val();

        $(`[data-character]`).each(function() {
            $(this).next().hide();
        });
        $(`select[id="character_select_${realmId}"]`).next().show();

        this.User.realm = realmId;
    },
    CharacterChanged: function (selectField, realmId) {
        const selected = $(selectField).find('option:selected');

        if (typeof selected != 'undefined' && selected.length > 0) {
            this.User.character = parseInt(selected.val());
        }

        this.User.realm = realmId;
    },

    busy: false,

    Submit: function () {
        if (Unstuck.busy)
            return;

        //Check if we have selected realm
        if (this.User.realm === 0) {
            Swal.fire({
                icon: 'error',
                title: 'Unstuck',
                text: lang("no_realm_selected", "unstuck"),
            })
            return;
        }

        //Check if we have selected character
        if (this.User.character === 0) {
            Swal.fire({
                icon: 'error',
                title: 'Unstuck',
                text: lang("no_char_selected", "unstuck"),
            })
            return;
        }

        var CanAfford = true;
   
        if (CanAfford) {
            // Make the user confirm the purchase
            Swal.fire({
                title: 'Unstuck',
                text: lang("sure_want_unstack", "unstuck"),
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Mark as busy
                    Unstuck.busy = true;

                    // Post the data
                    $.post(Config.URL + "unstuck/submit", {
                        realm: Unstuck.User.realm,
                        guid: Unstuck.User.character,
                        csrf_token_name: Config.CSRF
                    }, function (data) {
                        Unstuck.busy = false;
                        data = JSON.parse(data);
                        Swal.fire({
                            text: data.text,
                            icon: data.icon,
                            willClose: () => {
                                if (data.status)
                                    window.location.reload();
                            }
                        });
                    });
                }
            });
        }
    },

    Back: function () {
        window.location = Config.URL + "unstuck";
    }
};