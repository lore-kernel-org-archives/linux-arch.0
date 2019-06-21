Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfFUMJa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jun 2019 08:09:30 -0400
Date: Fri, 21 Jun 2019 14:09:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Message-ID: <20190621120923.GT3463@hirez.programming.kicks-ass.net>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
 <20190620070120.GU3402@hirez.programming.kicks-ass.net>
 <a0a1aa81-d46e-71db-ff7b-207bc468068d@synopsys.com>
 <20190620212256.GC3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620212256.GC3436@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Jason Baron <jbaron@akamai.com>, Paolo Bonzini <pbonzini@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, namit@vmware.com
Message-ID: <20190621120923.1E1PYtDMwGGPqb6vlhjH1ZjwC7uK4K2SMTeg16JfTug@z>

On Thu, Jun 20, 2019 at 11:22:56PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 20, 2019 at 11:48:17AM -0700, Vineet Gupta wrote:

> > I do worry about the occasional alignment induced extra NOP_S instruction (2 byte)
> > but there doesn't seem to be an easy solution. Heck if we could use the NOP_S /
> > B_S in first place. While not a clean solution by any standards, could anything be
> > done to reduce the code path of DO_ONCE() so that unlikely code is not too far off.
> 
> if one could somehow get the arch_static_branch*() things to
> conditionally emit either the 2 or 4 byte jump, depending on the offset
> (which is known there, since we stick it in the __jump_table), then we
> can have arch_jump_label_transform() use that same condition to switch
> between 2 and 4 bytes too.
> 
> I just don't know if it's possible :-/

So I had to try; but GAS macro .if directives don't like labels as
arguments, not constant enough for them.

../arch/x86/include/asm/jump_label.h:26: Error: non-constant expression in ".if" statement

Damn!

---
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -12,24 +12,19 @@
 # define STATIC_KEY_INIT_NOP GENERIC_NOP5_ATOMIC
 #endif
 
-#include <asm/asm.h>
-#include <asm/nops.h>
+asm(".include \"asm/jump_label_asm.h\"");
 
 #ifndef __ASSEMBLY__
 
 #include <linux/stringify.h>
 #include <linux/types.h>
+#include <asm/asm.h>
+#include <asm/nops.h>
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:"
-		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
-		".popsection \n\t"
-		: :  "i" (key), "i" (branch) : : l_yes);
+	asm_volatile_goto("STATIC_BRANCH_NOP l_yes=\"%l[l_yes]\", key=\"%c0\", branch=\"%c1\""
+			  : : "i" (key), "i" (branch) : : l_yes);
 
 	return false;
 l_yes:
@@ -38,57 +33,13 @@ static __always_inline bool arch_static_
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:"
-		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
-		"2:\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
-		".popsection \n\t"
-		: :  "i" (key), "i" (branch) : : l_yes);
+	asm_volatile_goto("STATIC_BRANCH_JMP l_yes=\"%l[l_yes]\", key=\"%c0\", branch=\"%c1\""
+			  : : "i" (key), "i" (branch) : : l_yes);
 
 	return false;
 l_yes:
 	return true;
 }
 
-#else	/* __ASSEMBLY__ */
-
-.macro STATIC_JUMP_IF_TRUE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.else
-	.byte		STATIC_KEY_INIT_NOP
-	.endif
-	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	.long		.Lstatic_jump_\@ - ., \target - .
-	_ASM_PTR	\key - .
-	.popsection
-.endm
-
-.macro STATIC_JUMP_IF_FALSE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	.byte		STATIC_KEY_INIT_NOP
-	.else
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.endif
-	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	.long		.Lstatic_jump_\@ - ., \target - .
-	_ASM_PTR	\key + 1 - .
-	.popsection
-.endm
-
-#endif	/* __ASSEMBLY__ */
-
-#endif
+#endif /* __ASSEMBLY__ */
+#endif /* _ASM_X86_JUMP_LABEL_H */
--- /dev/null
+++ b/arch/x86/include/asm/jump_label_asm.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_JUMP_LABEL_ASM_H
+#define _ASM_X86_JUMP_LABEL_ASM_H
+
+#include <asm/asm.h>
+#include <asm/nops.h>
+
+#ifdef __ASSEMBLY__
+
+.macro STATIC_BRANCH_ENTRY l_target:req l_yes:req key:req branch:req
+	.pushsection __jump_table, "aw"
+	.long		\l_target - ., \l_yes - .
+#ifdef __X86_64__
+	.quad		(\key - .) + \branch
+#else
+	.long		(\key - .) + \branch
+#endif
+	.popsection
+.endm
+
+.macro STATIC_BRANCH_NOP l_yes:req key:req branch:req
+.Lstatic_branch_nop_\@:
+.iflt 127 - .
+	.byte 0x66, 0x90
+.else
+	.byte STATIC_KEY_INIT_NOP
+.endif
+	STATIC_BRANCH_ENTRY l_target=.Lstatic_branch_nop_\@, l_yes=\l_yes, key=\key, branch=\branch
+.endm
+
+.macro STATIC_BRANCH_JMP l_yes:req key:req branch:req
+.Lstatic_branch_jmp_\@:
+.if \l_yes - . < 127
+	.byte 0xeb
+	.byte \l_yes - (. + 1)
+.else
+	.byte 0xe9
+	.long \l_yes - (. + 4)
+.endif
+	STATIC_BRANCH_ENTRY l_target=.Lstatic_branch_jmp_\@, l_yes=\l_yes, key=\key, branch=\branch
+.endm
+
+#endif /* __ASSEMBLY__ */
+#endif /* _ASM_X86_JUMP_LABEL_ASM_H */
