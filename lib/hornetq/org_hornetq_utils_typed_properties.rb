################################################################################
#  Copyright 2011 J. Reid Morrison. Clarity Services, Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
################################################################################

# Used by HornetQ to move around HashMap messages
# Ruby methods added to make it behave like a Ruby Hash
class Java::org.hornetq.utils::TypedProperties 
  # Get a property
  def [](key)
    value = getProperty(key)
    (value.class == Java::org.hornetq.api.core::SimpleString) ? value.to_s : value
  end

  # Set a property
  #   Currently supports Long, Double, Boolean
  # TODO: Not supported Byte, Bytes, Short, Int, FLoat, Char
  def []=(key,val)
    case
    when val.class == Fixnum # 1
      putLongProperty(key,val)
    when val.class == Float #1.1
      putDoubleProperty(key,val)
    when val.class == Bignum # 11111111111111111
      putLongProperty(key,val)
    when (val.class == TrueClass) || (val.class == FalseClass)
      putBooleanProperty(key,val)
    when val.class == NilClass
      setSimpleStringProperty(key,null)
    when val.class == Java::org.hornetq.api.core::SimpleString
      setSimpleStringProperty(key,val)
    else
      putSimpleStringProperty(key,val.to_s)
    end
  end
  
  # Iterate through each key,value pair
  def each_pair(&proc)
    it = property_names.iterator
    while it.has_next
      key = it.next
      proc.call(key.to_string, self[key])
    end
  end
  
  # Convert Properties to a Ruby Hash
  def to_h
    h = {}
    each_pair do |key, value| 
      h[key] = value
    end
    h
  end
  
  # Write Hash values into this TyedProperties instance
  def from_h(hash)
    hash.each_pair do |key,value|
      self[key] = value
    end
  end
  
  def inspect
    "#{self.class.name}: #{to_h.inspect}"
  end
end