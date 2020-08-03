class Bowling
  def initialize
    @total_score = 0
    # 全体のスコアを格納する配列
    @scores = []
    # 一時保存用の配列
    @temp = []
  end

  def total_score
    @total_score
  end

  def add_score(pins)
    @temp << pins
    if @temp.size == 2 || strike?(@temp)
      @scores << @temp
      @temp = []
    end
  end
  
  def calc_score
    @scores.each.with_index(1) do |score, index|
      # 最終フレーム以外でのスペアなら、スコアにボーナスを含めて合計する
      
      if strike?(score) && not_last_frame?(index)
        #次のフレームもストライクで、なおかつ最終フレーム以外なら、もう一つの次のフレームの一等眼をボーナスの対象にする
        if strike?(@scores[index]) && not_last_frame?(index + 1)
          @total_score += 20 + @scores[index + 1].first
        else
          @total_score += 10 + @scores[index].inject(:+)
        end
      elsif spare?(score) && not_last_frame?(index)
        @total_score += calc_spare_bonus(index)
      else
        @total_score += score.inject(:+)
      end
    end
  end

  private

  def spare?(score)
    score.inject(:+) == 10
  end

  # 最終フレーム以外かを判定する
  def not_last_frame?(index)
    index < 10
  end

  # スペアボーナスを含んだ値でスコアを計算する
  def calc_spare_bonus(index)
    10 + @scores[index].first
  end
  
  def strike?(score)
    score.first == 10
  end
end
