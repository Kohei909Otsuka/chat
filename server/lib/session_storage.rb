module SessionStorage
  def set(key, value)
    con = ActiveRecord::Base.connection
    pg_result = con.execute("
      INSERT INTO sessions(session_id, value) VALUES ('#{key}', '#{value}')
    ")
    if pg_result.error_message == ""
      return Result.new([], nil)
    end
    return Result.new([pg_result.error_message], nil)
  end

  def get(key)
    con = ActiveRecord::Base.connection
    r = con.select_one("
      SELECT session_id, value FROM sessions WHERE session_id = '#{key}'
    ")
    if r.nil?
      return Result.new([], nil)
    end
    return Result.new([], r["value"])
  end

  def rm(key)
    con = ActiveRecord::Base.connection
    pg_result = con.execute("
      DELETE FROM sessions WHERE session_id = '#{key}'
    ")
    if pg_result.error_message == ""
      return Result.new([], nil)
    end
    return Result.new([pg_result.error_message], nil)
  end

  module_function :set, :get, :rm
end
