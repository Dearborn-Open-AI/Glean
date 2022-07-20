{-
  Copyright (c) Meta Platforms, Inc. and affiliates.
  All rights reserved.

  This source code is licensed under the BSD-style license found in the
  LICENSE file in the root directory of this source tree.
-}


-- | Well-known 'Style' constants, values similar to Pygments.
--
-- Some context for the styles: <https://pygments.org/docs/tokens/>
module Glean.Pretty.Styles
  ( module Glean.Pretty.Styles
  ) where

import Glean.Pretty.Style (Style)

path_style :: Style
path_style = "path"

code_block :: Style
code_block = "code.block"

doxygen :: Style
doxygen = "doxygen"

markdown :: Style
markdown = "markdown"

-- -----------------------------------------------------------------------------

error_style :: Style
error_style = "err"

text_whitespace :: Style
text_whitespace = "w"

operator :: Style
operator = "o"
operator_word :: Style
operator_word = "ow"

comment :: Style
comment = "c"
comment_hashbang :: Style
comment_hashbang = "ch"
comment_multiline :: Style
comment_multiline = "cm"
comment_preproc :: Style
comment_preproc = "cp"
comment_preprocfile :: Style
comment_preprocfile = "cpf"
comment_single :: Style
comment_single = "c1"
comment_special :: Style
comment_special = "cs"

generic_deleted :: Style
generic_deleted = "gd"
generic_emph :: Style
generic_emph = "ge"
generic_error :: Style
generic_error = "gr"
generic_heading :: Style
generic_heading = "gh"
generic_inserted :: Style
generic_inserted = "gi"
generic_output :: Style
generic_output = "go"
generic_prompt :: Style
generic_prompt = "gp"
generic_strong :: Style
generic_strong = "gs"
generic_subheading :: Style
generic_subheading = "gu"
generic_traceback :: Style
generic_traceback = "gt"

keyword :: Style
keyword = "k"
keyword_constant :: Style
keyword_constant = "kc"
keyword_declaration :: Style
keyword_declaration = "kd"
keyword_namespace :: Style
keyword_namespace = "kn"
keyword_pseudo :: Style
keyword_pseudo = "kp"
keyword_reserved :: Style
keyword_reserved = "kr"
keyword_type :: Style
keyword_type = "kt"

name_style :: Style
name_style = "n"          -- Note: not in pygments css but generated by pygments
name_type :: Style
name_type = "ntype"
name_class :: Style
name_class = "nc"
name_attribute :: Style
name_attribute = "na"
name_builtin :: Style
name_builtin = "nb"
name_builtin_pseudo :: Style
name_builtin_pseudo = "bp"
name_constant :: Style
name_constant = "no"
name_decorator :: Style
name_decorator = "nd"
name_entity :: Style
name_entity = "ni"
name_exception :: Style
name_exception = "ne"
name_function :: Style
name_function = "nf"
name_function_magic :: Style
name_function_magic = "fm"
name_label :: Style
name_label = "nl"
name_module :: Style
name_module = "nm"
name_namespace :: Style
name_namespace = "nn"
name_tag :: Style
name_tag = "nt"
name_variable :: Style
name_variable = "nv"
name_variable_class :: Style
name_variable_class = "vc"
name_variable_global :: Style
name_variable_global = "vg"
name_variable_instance :: Style
name_variable_instance = "vi"
name_variable_magic :: Style
name_variable_magic = "vm"

literal_number :: Style
literal_number = "m"
literal_number_bin :: Style
literal_number_bin = "mb"
literal_number_float :: Style
literal_number_float = "mf"
literal_number_hex :: Style
literal_number_hex = "mh"
literal_number_integer :: Style
literal_number_integer = "mi"
literal_number_integer_long :: Style
literal_number_integer_long = "il"
literal_number_oct :: Style
literal_number_oct = "mo"

literal_string :: Style
literal_string = "s"
literal_string_delimiter :: Style
literal_string_delimiter = "dl"
literal_string_single :: Style
literal_string_single = "s1"
literal_string_double :: Style
literal_string_double = "s2"
literal_string_affix :: Style
literal_string_affix = "sa"
literal_string_backtick :: Style
literal_string_backtick = "sb"
literal_string_char :: Style
literal_string_char = "sc"
literal_string_doc :: Style
literal_string_doc = "sd"
literal_string_escape :: Style
literal_string_escape = "se"
literal_string_heredoc :: Style
literal_string_heredoc = "sh"
literal_string_interpol :: Style
literal_string_interpol = "si"
literal_string_regex :: Style
literal_string_regex = "sr"
literal_string_symbol :: Style
literal_string_symbol = "ss"
literal_string_other :: Style
literal_string_other = "sx"
