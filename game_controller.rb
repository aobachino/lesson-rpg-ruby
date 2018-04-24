# encoding: utf-8
Dir['./model/*.rb'].each { |file| require file }

class GameController
  attr_reader :hero, :monster
  def initialize(hero, monster)
    @hero = hero
    @monster = monster
  end

  def run
    # 全キャラクターを同一配列にを格納
    if @monster.kind_of?(Array)
      players = [@hero]
      i = 0
      while !@monster[i].nil?
        players.push(@monster[i])
        i += 1
      end
    else
      players = [@hero, @monster]
    end

    # 行動順決め(spd順に並び替え)
    # players = players.sort! do |a, b|
    players.sort! do |a, b|
      b.spd <=> a.spd
    end

    ### 残作業用メモ
    ## ・monster側とhero側でチーム分け
    ## ・ゲームセット判定条件の見直し


    # 終了を満たすまで繰り返し
    turn = 0
    until gameset?(players)
      turn += 1
      players.each do |player|
        enemies = players - [player]
        # FIXME: 複数の敵を考慮する
        enemy = enemies[0]
        attack_faith(player, enemy, turn)
        break if enemy.hp <= 0
      end
    end
  end

  private

  def attack_faith(attacker, defencer, turn)
    status = attacker.attack
    def_msg = ""
    if !status[:atk].nil?
      damege = [status[:atk] - defencer.defe, 0].max
      def_msg = defencer.defence(damege)
    end
    broadcastingan(status[:msg], def_msg, turn)
  end

  def gameset?(players)
    players.each do |player|
      return true if player.hp <= 0
    end
    false
  end

  def broadcastingan(atk_msg, def_msg, turn)
    p "#-----#{turn}ターン-----#"
    p atk_msg
    p def_msg if !def_msg.empty?
  end
end
