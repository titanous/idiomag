class Object #:nodoc:
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
end

class NilClass #:nodoc:
  def blank?
    true
  end
end

class FalseClass #:nodoc:
  def blank?
    true
  end
end

class TrueClass #:nodoc:
  def blank?
    false
  end
end

class Array #:nodoc:
  alias_method :blank?, :empty?
end

class Hash #:nodoc:
  alias_method :blank?, :empty?
  
  def keys_to_sym!
    return Hash.keys_to_sym(self)
  end

  def rename_key!(old_key, new_key)
    return Hash.rename_key(self, old_key, new_key)
  end

  private
    def self.keys_to_sym(hsh)
      hsh.each_key {|k| hsh[k.to_s.downcase.gsub(/ /, '_').to_sym] = hsh.delete(k)}
      return hsh
    end
    
    def self.rename_key(hsh, old_key, new_key)
      hsh[new_key.to_s] = hsh.delete(old_key.to_s)
      return hsh
    end
end

class String #:nodoc:
  def blank?
    self !~ /\S/
  end
end

class Numeric #:nodoc:
  def blank?
    false
  end
end
