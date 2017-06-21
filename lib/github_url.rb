class GithubUrl
  attr_accessor :url, :default_branch

  GITHUB_HOST = "github.com"

  class Invalid < StandardError
  end

  def initialize(url, default_branch = "master")
    @default_branch = default_branch
    @url = url

    validate_url
  end

  def organization
    url_path[0]
  end

  def repository
    url_path[1]
  end

  def branch
    default_branch? ? @default_branch : url_path[3]
  end

  def path
    default_branch? ? File.join(url_path[2..-1]) : File.join(url_path[4..-1].to_a)
  end

  private

  def default_branch?
    (["blob", "tree", "raw"] & url_path).empty?
  end

  def validate_url
    raise(Invalid, "Must contain #{GITHUB_HOST}") unless url.split("/").any? { |e| e.include?(GITHUB_HOST) }
    raise(Invalid, "Missing organization") if organization.nil?
    raise(Invalid, "Missing repository") if repository.nil?
    raise(Invalid, "Missing branch") if !default_branch? && url_path[3].nil?
  end

  def url_path
    url_arr = url.split("/")
    github_index = url_arr.index { |e| e.include?(GITHUB_HOST) }
    url_arr[github_index + 1..-1]
  end
end
