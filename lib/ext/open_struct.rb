require 'ostruct'
class OpenStruct
  
  # For some reason, the standard table doesn't return the table
  def table
    instance_eval {@table}
  end
  
  def merge(other)
    case other
    when Hash
      merge_hash(other)
    when OpenStruct
      merge_open_struct(other)
    else
      raise ArgumentError, "Cannot merge type #{other.class.to_s} into an OpenStruct."
    end
  end
  
  private
    def merge_open_struct(other)
      merge_hash(other.table)
    end
  
    def merge_hash(other)
      table.merge!(other)
      # other.each do |k, v|
      #   new_ostruct_member(k.to_sym)
      #   instance_eval {}
      # end
    end
    
end
