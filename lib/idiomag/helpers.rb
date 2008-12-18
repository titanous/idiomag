class Hash #:nodoc:  
  def keys_to_sym!
    return Hash.keys_to_sym(self)
  end

  def rename_key!(old_key, new_key)
    return Hash.rename_key(self, old_key, new_key)
  end

  private
    def self.keys_to_sym(hsh)
      hsh.each_key do |k|
        if k =~ /-/
          hsh[k.to_s.downcase] = hsh.delete(k)
        else
          hsh[k.to_s.downcase.gsub(/ /, '_').to_sym] = hsh.delete(k)
        end
      end
      return hsh
    end
    
    def self.rename_key(hsh, old_key, new_key)
      hsh[new_key.to_s] = hsh.delete(old_key.to_s)
      return hsh
    end
end