class Array
  def extract_options!
    if last.instance_of?(Hash)
      pop
    else
      {}
    end
  end
end
