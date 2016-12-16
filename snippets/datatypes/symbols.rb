# Symbols are literals stored in the symbol table

:symbol # A symbol literal

:"symbol" # Identical symbol literal

:"another longer symbol" # Quotes are used with symbols with spaces

# Can be constructed through string interpolation
s = "string"
sym = :"#{s}" # the symbol :string

# Alternative syntax
%s["] # -> :'"'

# Converting string to symbol
str = "string"
sym = str.intern # -> :string
sym = str.to_sym # -> :string
str = sym.to_s # -> "string"
str = sym.id2name # -> "string"

