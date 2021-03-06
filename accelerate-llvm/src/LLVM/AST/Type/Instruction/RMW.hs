{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_HADDOCK hide #-}
-- |
-- Module      : LLVM.AST.Type.Instruction.RMW
-- Copyright   : [2016..2017] Trevor L. McDonell
-- License     : BSD3
--
-- Maintainer  : Trevor L. McDonell <tmcdonell@cse.unsw.edu.au>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--

module LLVM.AST.Type.Instruction.RMW
  where

import LLVM.AST.Type.Downcast
import LLVM.AST.Type.Representation

import qualified LLVM.AST.RMWOperation                              as LLVM


-- | Operations for the 'AtomicRMW' instruction.
--
-- <http://llvm.org/docs/LangRef.html#atomicrmw-instruction>
--
data RMWOperation
    = Exchange
    | Add
    | Sub
    | And
    | Nand
    | Or
    | Xor
    | Min
    | Max


-- | Convert to llvm-hs
--
instance Downcast (IntegralType a, RMWOperation) LLVM.RMWOperation where
  downcast (t, rmw) =
    case rmw of
      Exchange        -> LLVM.Xchg
      Add             -> LLVM.Add
      Sub             -> LLVM.Sub
      And             -> LLVM.And
      Or              -> LLVM.Or
      Xor             -> LLVM.Xor
      Nand            -> LLVM.Nand
      Min | signed t  -> LLVM.Min
          | otherwise -> LLVM.UMin
      Max | signed t  -> LLVM.Max
          | otherwise -> LLVM.UMax

