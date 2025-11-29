module NoiseHistoryHelper
  def measurement_level_class(level)
    case level
    when 0..50
      'low'
    when 51..70
      'medium'
    when 71..85
      'high'
    else
      'extreme'
    end
  end
end
