<?php

class Unstuck_model extends CI_Model {

    public function setLocation( $x, $y, $z, $o, $mapId, $characterGuid, $realmConnection ) {
        $realmConnection->query("UPDATE " . table("characters") . " SET " . column("characters", "position_x") . " = ?, " . column("characters", "position_y") . " = ?, " . column("characters", "position_z") . " = ?, " . column("characters", "orientation") . " = ?, " . column("characters", "map") . " = ? WHERE " . column("characters", "guid") . " = ?", [$x, $y, $z, $o, $mapId, $characterGuid]);
    }

    public function getcharacter_homebind( $realmId, $guid ) {

        $character_database = $this->realms->getRealm( $realmId )->getCharacters();
        $character_database->connect();

        $query = $character_database->getConnection()->query( "SELECT * FROM character_homebind WHERE guid = ?", [$guid]);

        if ($query->getNumRows() > 0) {
            return $query->getResultArray();
        } else {
            return false;
        }
    }

    public function getmoneyCharacter ($realmid,$guid)
    {
        $gold = $this->config->item("gold");

        $money  = $gold * 10000;

        $character_database = $this->realms->getRealm($realmid)->getCharacters();
        $character_database->connect();
        $query = $character_database->getConnection()->query("SELECT * FROM characters WHERE guid = ?", [$guid]);
        if($query->getNumRows() > 0)
        {
            $result=$query->getResultArray();
            if($result[0]['money'] < $money)
            {
                return true;
            }
            else
                return false;
        }
        else
            return false;
    }


    public function ChangeGoldCharacter ($realmid,$guid , $characterName)
    {

        $gold = $this->config->item("gold");
        $money  = $gold * 10000;
        $character_database = $this->realms->getRealm($realmid)->getCharacters();
        $character_database->connect();
        $character_database->getConnection()->query("UPDATE characters SET money = money - ".$money."  WHERE guid = ?", [$guid]);
        return true;

    }

}

?>
