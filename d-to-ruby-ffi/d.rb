 require 'rubygems'
 require 'ffi'
 
 module DInterface
   extend FFI::Library
   ffi_lib './i.so'
   attach_function :rt_init, :rt_init, [], :int
   attach_function :rt_term, :rt_term, [], :int
   # now taking a string
   attach_function :hello, :hello, [:string], :void
 end
 
 # call init right here for the user
 DInterface::rt_init
 
 # terminate automatically
 at_exit do
   DInterface::rt_term
 end
