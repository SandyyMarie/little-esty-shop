class Holiday
  attr_reader :name, :Date

  def initialize(repo_data)
    @name = repo_data[:date]
    @date = repo_data[:date]
  end
end
