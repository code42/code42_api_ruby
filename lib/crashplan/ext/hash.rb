class Hash
  def rubyify_keys
    new_hash = {}
    map do |k, v|
      new_key = k.to_s.underscore
      new_hash[new_key] = v
      v.rubyify_keys if v.is_a?(Hash)
      v.each { |p| p.rubyify_keys if p.is_a?(Hash) } if v.is_a?(Array)
    end
    new_hash
  end
end
