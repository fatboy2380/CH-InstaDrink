bind(player_interact, null, array(item: 373, button: 'RIGHT'), @e) {
        @player = @e['player']
        @effect = array(
                # Regeneration
                8193: array(id: 10, strength: 0, duration: 45, name: 'Regular Regeneration'),
                8225: array(id: 10, strength: 1, duration: 22, name: 'Regeneration Level 2'),
                8257: array(id: 10, strength: 0, duration: 120, name: 'Extended Regeneration'),
 
                # Swiftness
                8194: array(id: 1, strength: 0, duration: 180, name: 'Regular Swiftness'),
                8226: array(id: 1, strength: 1, duration: 90, name: 'Swiftness Level 2'),
                8258: array(id: 1, strength: 0, duration: 480, name: 'Extended Swiftness'),
 
                # Fire Resistance
                8195: array(id: 12, strength: 0, duration: 180, name: 'Regular Fire Resistance'),
                8227: array(id: 12, strength: 0, duration: 180, name: 'Reverted Fire Resistance'), # Reverted = Back To Regular
                8259: array(id: 12, strength: 0, duration: 480, name: 'Extended Fire Resistance'),
 
                # Poison
                8196: array(id: 19, strength: 0, duration: 45, name: 'Regular Poison'),
                8228: array(id: 19, strength: 1, duration: 22, name: 'Poison Level 2'),
                8260: array(id: 19, strength: 0, duration: 120, name: 'Extended Poison'),
 
                # Instant Health
                8197: array(id: 6, strength: 0, duration: 0, name: 'Regular Instant Health'),
                8229: array(id: 6, strength: 1, duration: 0, name: 'Instant Health Level 2'),
                8261: array(id: 6, strength: 0, duration: 0, name: 'Reverted Instant Health'),
 
                # Night Vision
                8198: array(id: 16, strength: 0, duration: 180, name: 'Regular Night Vision'),
                8230: array(id: 16, strength: 0, duration: 180, name: 'Reverted Night Vision'),
                8262: array(id: 16, strength: 0, duration: 480, name: 'Extended Night Vision'),
 
                # Weakness
                8200: array(id: 18, strength: 0, duration: 90, name: 'Regular Weakness'),
                8232: array(id: 18, strength: 0, duration: 90, name: 'Reverted Weakness'),
                8264: array(id: 18, strength: 0, duration: 240, name: 'Extended Weakness'),
 
                # Strength
                8201: array(id: 5, strength: 0, duration: 180, name: 'Regular Strength'),
                8233: array(id: 5, strength: 1, duration: 90, name: 'Strength Level 2'),
                8265: array(id: 5, strength: 0, duration: 480, name: 'Extended Strength'),
 
                # Slowness
                8202: array(id: 2, strength: 0, duration: 90, name: 'Regular Weakness'),
                8234: array(id: 2, strength: 0, duration: 90, name: 'Reverted Weakness'),
                8266: array(id: 2, strength: 0, duration: 240, name: 'Extended Weakness'),
 
                # Leaping (1.8)
                8203: array(id: 8, strength: 0, duration: 180, name: 'Regular Leaping'),
                8235: array(id: 8, strength: 1, duration: 90, name: 'Extended Leaping'),
                8267: array(id: 8, strength: 0, duration: 180, name: 'Reverted Leaping'),
 
                # Harming
                8204: array(id: 7, strength: 0, duration: 0, name: 'Regular Harming'),
                8236: array(id: 7, strength: 1, duration: 0, name: 'Harming Level 2'),
                8268: array(id: 7, strength: 0, duration: 0, name: 'Reverted Harming'),
 
                # Water Breathing
                8205: array(id: 13, strength: 0, duration: 180, name: 'Regular Water Breathing'),
                8237: array(id: 13, strength: 0, duration: 180, name: 'Reverted Water Breathing'),
                8269: array(id: 13, strength: 0, duration: 480, name: 'Extended Water Breathing'),
 
                # Invisibility
                8206: array(id: 14, strength: 0, duration: 180, name: 'Regular Invisibility'),
                8238: array(id: 14, strength: 0, duration: 180, name: 'Reverted Invisibility'),
                8270: array(id: 14, strength: 0, duration: 480, name: 'Extended Invisibility'),
        );
        @id = split(':', @e['item'])[1];
        if(array_index_exists(@effect, @id)) {
                @inv = pinv(@player, null);
                @slot = pinfo(@player, 15);
                @inv['qty'] = @inv['qty'] - 1;
                if(@inv['qty'] >= 0) {
                        @inv = null;
                }
                @array = array();
                @array[@slot] = @inv;
                set_pinv(@player, @array);
                if(@effect[@id]['id'] == 6 || @effect[@id]['id'] == 7) {
                        if(@effect[@id]['id'] == 6) {
                                @health = pinfo(@player, 5) + ((@effect[@id]['strength'] + 1) * 4);
                                if(@health > get_max_health(pinfo(@player, 13))){
                                        @health = get_max_health(pinfo(@player, 13));
                                }
                        } else {
                                @health = pinfo(@player, 5) - ((@effect[@id]['strength'] + 1) * 6);
                                if(@health < 0) {
                                        pkill(@player);
                                        die();
                                }
                        }
                        set_phealth(@player, double(@health));
                } else {
                        set_peffect(@player, @effect[@id]['id'], @effect[@id]['strength'], @effect[@id]['duration']);
                }
        }
}