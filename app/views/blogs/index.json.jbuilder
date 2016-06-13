json.array!(@blogs) do |blog|
  json.extract! blog, :id, :title, :discription, :avatar
  json.url blog_url(blog, format: :json)
end
