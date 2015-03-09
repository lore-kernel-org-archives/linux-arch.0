From: Chung-Lin Tang <cltang@codesourcery.com>
Subject: Re: nios2: is the ptrace ABI correct?
Date: Tue, 10 Mar 2015 00:54:25 +0800
Message-ID: <54FDD041.3080500@codesourcery.com>
References: <CAAEAJfDjDYY-Z6cPyrddCXiFJzrjNx8jkSAJZuokeEM9NU6WWg@mail.gmail.com> <10088870.tldQegtTla@wuerfel> <54EDB2FC.4050901@vanguardiasur.com.ar> <10841724.NbdcAaCe1a@wuerfel> <54F03184.7080600@codesourcery.com> <54F052B1.4070300@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------040506000007000701070100"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:56658 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbbCIQyf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2015 12:54:35 -0400
In-Reply-To: <54F052B1.4070300@vanguardiasur.com.ar>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Arnd Bergmann <arnd@arndb.de>, Tobias Klauser <tklauser@distanz.ch>, Ley Foon Tan <lftan@altera.com>
Cc: Walter Goossens <waltergoossens@home.nl>, linux-arch@vger.kernel.org, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--------------040506000007000701070100
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 2015/2/27 07:19 PM, Ezequiel Garcia wrote:
> Right now, my biggest problem is how to remove the pt_regs from being
> exported to userspace, without breaking things. The struct is defined
> and used in a few UAPI headers:
> 
> arch/nios2/include/uapi/asm/ptrace.h
> arch/nios2/include/uapi/asm/sigcontext.h
> arch/nios2/include/uapi/asm/elf.h
> 
> For ucontext, we would need to remove
> arch/nios2/include/uapi/asm/sigcontext.h and avoid using
> asm-generic/ucontext.h.
> 
> For ptrace, we could move pt_regs from the UAPI header to some internal
> header. That way userspace is not exposed the wrong struct.
> 
> For the elf coredump, I have no idea yet :)

It appears that some of the ways nios2 has organized the
ucontext/pt_regs/etc. are remnants of the pre-generic code, some
basically because the port was based off m68k.

I've re-organized the headers a bit: nios2/include/asm/ucontext.h is
deleted, and re-definition of struct sigcontext now allows use of
uapi/asm-generic/ucontext.h directly.  Note that the reorg, despite
effectively renaming some fields, is still binary compatible. I'll
probably update the corresponding glibc definitions later.

struct pt_regs is now not exported, and all exported register sets are
now supposed to follow the 49 register set defined as in GDB now.

Tobias, Ley Foon, how do you think this looks?

Thanks,
Chung-Lin


--------------040506000007000701070100
Content-Type: text/plain; charset="Big5"; name="x.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="x.diff"

Index: gcc/config/nios2/nios2-protos.h
===================================================================
--- gcc/config/nios2/nios2-protos.h	(revision 446123)
+++ gcc/config/nios2/nios2-protos.h	(working copy)
@@ -32,7 +32,7 @@ extern void nios2_function_profiler (FILE *, int);
 #ifdef RTX_CODE
 extern bool nios2_emit_move_sequence (rtx *, enum machine_mode);
 extern void nios2_emit_expensive_div (rtx *, enum machine_mode);
-extern void nios2_adjust_call_address (rtx *);
+extern void nios2_adjust_call_address (rtx *, rtx);
 
 extern rtx nios2_get_return_address (int);
 extern void nios2_set_return_address (rtx, rtx);
Index: gcc/config/nios2/nios2.c
===================================================================
--- gcc/config/nios2/nios2.c	(revision 446123)
+++ gcc/config/nios2/nios2.c	(working copy)
@@ -1511,12 +1511,12 @@ nios2_unspec_offset (rtx loc, int unspec)
 
 /* Generate GOT pointer based address with large offset.  */
 static rtx
-nios2_large_got_address (rtx offset)
+nios2_large_got_address (rtx offset, rtx tmp)
 {
-  rtx addr = gen_reg_rtx (Pmode);
-  emit_insn (gen_add3_insn (addr, pic_offset_table_rtx,
-			    force_reg (Pmode, offset)));
-  return addr;
+  if (!tmp)
+    tmp = gen_reg_rtx (Pmode);
+  emit_move_insn (tmp, offset);
+  return gen_rtx_PLUS (Pmode, tmp, pic_offset_table_rtx);
 }
 
 /* Generate a GOT pointer based address.  */
@@ -1527,7 +1527,7 @@ nios2_got_address (rtx loc, int unspec)
   crtl->uses_pic_offset_table = 1;
 
   if (nios2_large_offset_p (unspec))
-    return nios2_large_got_address (offset);
+    return force_reg (Pmode, nios2_large_got_address (offset, NULL_RTX));
 
   return gen_rtx_PLUS (Pmode, pic_offset_table_rtx, offset);
 }
@@ -2080,13 +2080,17 @@ nios2_load_pic_register (void)
 
 /* Generate a PIC address as a MEM rtx.  */
 static rtx
-nios2_load_pic_address (rtx sym, int unspec)
+nios2_load_pic_address (rtx sym, int unspec, rtx tmp)
 {
   if (flag_pic == 2
       && GET_CODE (sym) == SYMBOL_REF
       && nios2_symbol_binds_local_p (sym))
     /* Under -fPIC, generate a GOTOFF address for local symbols.  */
-    return nios2_got_address (sym, UNSPEC_PIC_GOTOFF_SYM);
+    {
+      rtx offset = nios2_unspec_offset (sym, UNSPEC_PIC_GOTOFF_SYM);
+      crtl->uses_pic_offset_table = 1;
+      return nios2_large_got_address (offset, tmp);
+    }
 
   return gen_const_mem (Pmode, nios2_got_address (sym, unspec));
 }
@@ -2122,7 +2126,7 @@ nios2_legitimize_constant_address (rtx addr)
   if (nios2_tls_symbol_p (base))
     base = nios2_legitimize_tls_address (base);
   else if (flag_pic)
-    base = nios2_load_pic_address (base, UNSPEC_PIC_SYM);
+    base = nios2_load_pic_address (base, UNSPEC_PIC_SYM, NULL_RTX);
   else
     return addr;
 
@@ -2266,18 +2270,24 @@ nios2_emit_move_sequence (rtx *operands, enum mach
 
 /* The function with address *ADDR is being called.  If the address
    needs to be loaded from the GOT, emit the instruction to do so and
-   update *ADDR to point to the rtx for the loaded value.  */
+   update *ADDR to point to the rtx for the loaded value.
+   If REG != NULL_RTX, it is used as the target/scratch register in the
+   GOT address calculation.  */
 void
-nios2_adjust_call_address (rtx *call_op)
+nios2_adjust_call_address (rtx *call_op, rtx reg)
 {
-  rtx addr;
-  gcc_assert (MEM_P (*call_op));
-  addr = XEXP (*call_op, 0);
+  if (MEM_P (*call_op))
+    call_op = &XEXP (*call_op, 0);
+
+  rtx addr = *call_op;
   if (flag_pic && CONSTANT_P (addr))
     {
-      rtx reg = gen_reg_rtx (Pmode);
-      emit_move_insn (reg, nios2_load_pic_address (addr, UNSPEC_PIC_CALL_SYM));
-      XEXP (*call_op, 0) = reg;
+      rtx tmp = reg ? reg : NULL_RTX;
+      if (!reg)
+	reg = gen_reg_rtx (Pmode);
+      addr = nios2_load_pic_address (addr, UNSPEC_PIC_CALL_SYM, tmp);
+      emit_insn (gen_rtx_SET (VOIDmode, reg, addr));
+      *call_op = reg;
     }
 }
 
@@ -4980,8 +4990,10 @@ nios2_asm_output_mi_thunk (FILE *file, tree thunk_
       TREE_USED (function) = 1;
     }
   funexp = XEXP (DECL_RTL (function), 0);
-  funexp = gen_rtx_MEM (FUNCTION_MODE, funexp);
-  insn = emit_call_insn (gen_sibcall (funexp, const0_rtx));
+  /* Function address needs to be constructed under PIC,
+     provide r2 to use here.  */
+  nios2_adjust_call_address (&funexp, gen_rtx_REG (Pmode, 2));
+  insn = emit_call_insn (gen_sibcall_internal (funexp, const0_rtx));
   SIBLING_CALL_P (insn) = 1;
 
   /* Run just enough of rest_of_compilation to get the insns emitted.
Index: gcc/config/nios2/nios2.md
===================================================================
--- gcc/config/nios2/nios2.md	(revision 446123)
+++ gcc/config/nios2/nios2.md	(working copy)
@@ -818,7 +818,7 @@
                     (match_operand 1 "" ""))
               (clobber (reg:SI RA_REGNO))])]
   ""
-  "nios2_adjust_call_address (&operands[0]);")
+  "nios2_adjust_call_address (&operands[0], NULL_RTX);")
 
 (define_expand "call_value"
   [(parallel [(set (match_operand 0 "" "")
@@ -826,7 +826,7 @@
                          (match_operand 2 "" "")))
               (clobber (reg:SI RA_REGNO))])]
   ""
-  "nios2_adjust_call_address (&operands[1]);")
+  "nios2_adjust_call_address (&operands[1], NULL_RTX);")
 
 (define_insn "*call"
   [(call (mem:QI (match_operand:SI 0 "call_operand" "i,r"))
@@ -854,7 +854,7 @@
                     (match_operand 1 "" ""))
               (return)])]
   ""
-  "nios2_adjust_call_address (&operands[0]);")
+  "nios2_adjust_call_address (&operands[0], NULL_RTX);")
 
 (define_expand "sibcall_value"
   [(parallel [(set (match_operand 0 "" "")
@@ -862,9 +862,9 @@
                          (match_operand 2 "" "")))
               (return)])]
   ""
-  "nios2_adjust_call_address (&operands[1]);")
+  "nios2_adjust_call_address (&operands[1], NULL_RTX);")
 
-(define_insn "*sibcall"
+(define_insn "sibcall_internal"
  [(call (mem:QI (match_operand:SI 0 "call_operand" "i,j"))
         (match_operand 1 "" ""))
   (return)]
@@ -874,7 +874,7 @@
    jmp.r\\t%0"
   [(set_attr "type" "control")])
 
-(define_insn "*sibcall_value"
+(define_insn "sibcall_value_internal"
  [(set (match_operand 0 "register_operand" "")
        (call (mem:QI (match_operand:SI 1 "call_operand" "i,j"))
              (match_operand 2 "" "")))

--------------040506000007000701070100--
