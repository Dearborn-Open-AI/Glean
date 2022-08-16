# @generated
# To regenerate this file run fbcode//glean/schema/gen/sync
from typing import Tuple, Union
import json
from glean.schema.py.glean_schema_predicate import GleanSchemaPredicate


class RustEnumDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.EnumDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustEnumDef":
    raise Exception("this function can only be called from @angle_query")

class RustDefinitionUses(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.DefinitionUses.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustDefinitionUses":
    raise Exception("this function can only be called from @angle_query")

class RustTraitDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.TraitDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustTraitDef":
    raise Exception("this function can only be called from @angle_query")

class RustImplLocation(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.ImplLocation.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustImplLocation":
    raise Exception("this function can only be called from @angle_query")

class RustModuleDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.ModuleDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustModuleDef":
    raise Exception("this function can only be called from @angle_query")

class RustStaticDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.StaticDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustStaticDef":
    raise Exception("this function can only be called from @angle_query")

class RustName(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.Name.1 { json.dumps(key) }"

  @staticmethod
  def angle_query(*, name: str) -> "RustName":
    raise Exception("this function can only be called from @angle_query")

class RustImpl(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.Impl.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustImpl":
    raise Exception("this function can only be called from @angle_query")

class RustNameLowerCase(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.NameLowerCase.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustNameLowerCase":
    raise Exception("this function can only be called from @angle_query")

class RustStructDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.StructDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustStructDef":
    raise Exception("this function can only be called from @angle_query")

class RustTupleVariantDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.TupleVariantDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustTupleVariantDef":
    raise Exception("this function can only be called from @angle_query")

class RustForeignStaticDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.ForeignStaticDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustForeignStaticDef":
    raise Exception("this function can only be called from @angle_query")

class RustDefLocation(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.DefLocation.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustDefLocation":
    raise Exception("this function can only be called from @angle_query")

class RustConstDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.ConstDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustConstDef":
    raise Exception("this function can only be called from @angle_query")

class RustDefinitionName(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.DefinitionName.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustDefinitionName":
    raise Exception("this function can only be called from @angle_query")

class RustSearchByName(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.SearchByName.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustSearchByName":
    raise Exception("this function can only be called from @angle_query")

class RustFileDefinition(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.FileDefinition.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustFileDefinition":
    raise Exception("this function can only be called from @angle_query")

class RustFileXRefs(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.FileXRefs.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustFileXRefs":
    raise Exception("this function can only be called from @angle_query")

class RustUnionDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.UnionDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustUnionDef":
    raise Exception("this function can only be called from @angle_query")

class RustFieldDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.FieldDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustFieldDef":
    raise Exception("this function can only be called from @angle_query")

class RustFunctionDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.FunctionDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustFunctionDef":
    raise Exception("this function can only be called from @angle_query")

class RustQName(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.QName.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustQName":
    raise Exception("this function can only be called from @angle_query")

class RustTypeDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.TypeDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustTypeDef":
    raise Exception("this function can only be called from @angle_query")

class RustStructVariantDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.StructVariantDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustStructVariantDef":
    raise Exception("this function can only be called from @angle_query")

class RustType(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.Type.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustType":
    raise Exception("this function can only be called from @angle_query")

class RustMethodDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.MethodDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustMethodDef":
    raise Exception("this function can only be called from @angle_query")

class RustXRef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.XRef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustXRef":
    raise Exception("this function can only be called from @angle_query")

class RustLocalDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.LocalDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustLocalDef":
    raise Exception("this function can only be called from @angle_query")

class RustForeignFunctionDef(GleanSchemaPredicate):
  @staticmethod
  def build_angle(key: Union[int, bool, str, Tuple[()]]) -> str:
    return f"rust.ForeignFunctionDef.1 { { } }"

  @staticmethod
  def angle_query(*, name: Tuple[()]) -> "RustForeignFunctionDef":
    raise Exception("this function can only be called from @angle_query")

