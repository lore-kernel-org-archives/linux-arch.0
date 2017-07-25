From: tip-bot for Kees Cook <tipbot@zytor.com>
Subject: [tip:x86/asm] x86/asm: Add suffix macro for GEN_*_RMWcc()
Date: Tue, 25 Jul 2017 06:48:37 -0700
Message-ID: <tip-df3405245a8535d2f20bcbdbb615385671cd0792@git.kernel.org>
References: <1500921349-10803-2-git-send-email-keescook@chromium.org>
Reply-To: ebiggers3@gmail.com, dave@stgolabs.net, keescook@chromium.org,
          linux-kernel@vger.kernel.org, manfred@colorfullife.com,
          hch@infradead.org, riel@redhat.com, peterz@infradead.org,
          tglx@linutronix.de, akpm@linux-foundation.org,
          ebiederm@xmission.com, torvalds@linux-foundation.org,
          jannh@google.com, gregkh@linuxfoundation.org,
          James.Bottomley@hansenpartnership.com, arnd@arndb.de,
          hpa@zytor.com, serge@hallyn.com, mingo@kernel.org,
          davem@davemloft.net, linux-arch@vger.kernel.org,
          ishkamiel@gmail.com, jpoimboe@redhat.com,
          elena.reshetova@intel.com, adobriyan@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([65.50.211.136]:40247 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdGYN5t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2017 09:57:49 -0400
In-Reply-To: <1500921349-10803-2-git-send-email-keescook@chromium.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: gregkh@linuxfoundation.org, torvalds@linux-foundation.org, jannh@google.com, arnd@arndb.de, James.Bottomley@hansenpartnership.com, hch@infradead.org, riel@redhat.com, peterz@infradead.org, dave@stgolabs.net, ebiggers3@gmail.com, linux-kernel@vger.kernel.org, keescook@chromium.org, manfred@colorfullife.com, ebiederm@xmission.com, akpm@linux-foundation.org, tglx@linutronix.de, jpoimboe@redhat.com, elena.reshetova@intel.com, ishkamiel@gmail.com, adobriyan@gmail.com, mingo@kernel.org, serge@hallyn.com, hpa@zytor.com, linux-arch@vger.kernel.org, davem@davemloft.net

Commit-ID:  df3405245a8535d2f20bcbdbb615385671cd0792
Gitweb:     http://git.kernel.org/tip/df3405245a8535d2f20bcbdbb615385671cd0792
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Mon, 24 Jul 2017 11:35:47 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 25 Jul 2017 11:18:09 +0200

x86/asm: Add suffix macro for GEN_*_RMWcc()

The coming x86 refcount protection needs to be able to add trailing
instructions to the GEN_*_RMWcc() operations. This extracts the
difference between the goto/non-goto cases so the helper macros
can be defined outside the #ifdef cases. Additionally adds argument
naming to the resulting asm for referencing from suffixed
instructions, and adds clobbers for "cc", and "cx" to let suffixes
use _ASM_CX, and retain any set flags.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Eric Biggers <ebiggers3@gmail.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Hans Liljestrand <ishkamiel@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jann Horn <jannh@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arozansk@redhat.com
Cc: axboe@kernel.dk
Cc: kernel-hardening@lists.openwall.com
Cc: linux-arch <linux-arch@vger.kernel.org>
Link: http://lkml.kernel.org/r/1500921349-10803-2-git-send-email-keescook@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/rmwcc.h | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/rmwcc.h b/arch/x86/include/asm/rmwcc.h
index 661dd30..045f992 100644
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -1,45 +1,56 @@
 #ifndef _ASM_X86_RMWcc
 #define _ASM_X86_RMWcc
 
+#define __CLOBBERS_MEM		"memory"
+#define __CLOBBERS_MEM_CC_CX	"memory", "cc", "cx"
+
 #if !defined(__GCC_ASM_FLAG_OUTPUTS__) && defined(CC_HAVE_ASM_GOTO)
 
 /* Use asm goto */
 
-#define __GEN_RMWcc(fullop, var, cc, ...)				\
+#define __GEN_RMWcc(fullop, var, cc, clobbers, ...)			\
 do {									\
 	asm_volatile_goto (fullop "; j" #cc " %l[cc_label]"		\
-			: : "m" (var), ## __VA_ARGS__ 			\
-			: "memory" : cc_label);				\
+			: : [counter] "m" (var), ## __VA_ARGS__		\
+			: clobbers : cc_label);				\
 	return 0;							\
 cc_label:								\
 	return 1;							\
 } while (0)
 
-#define GEN_UNARY_RMWcc(op, var, arg0, cc) 				\
-	__GEN_RMWcc(op " " arg0, var, cc)
+#define __BINARY_RMWcc_ARG	" %1, "
 
-#define GEN_BINARY_RMWcc(op, var, vcon, val, arg0, cc)			\
-	__GEN_RMWcc(op " %1, " arg0, var, cc, vcon (val))
 
 #else /* defined(__GCC_ASM_FLAG_OUTPUTS__) || !defined(CC_HAVE_ASM_GOTO) */
 
 /* Use flags output or a set instruction */
 
-#define __GEN_RMWcc(fullop, var, cc, ...)				\
+#define __GEN_RMWcc(fullop, var, cc, clobbers, ...)			\
 do {									\
 	bool c;								\
 	asm volatile (fullop ";" CC_SET(cc)				\
-			: "+m" (var), CC_OUT(cc) (c)			\
-			: __VA_ARGS__ : "memory");			\
+			: [counter] "+m" (var), CC_OUT(cc) (c)		\
+			: __VA_ARGS__ : clobbers);			\
 	return c;							\
 } while (0)
 
+#define __BINARY_RMWcc_ARG	" %2, "
+
+#endif /* defined(__GCC_ASM_FLAG_OUTPUTS__) || !defined(CC_HAVE_ASM_GOTO) */
+
 #define GEN_UNARY_RMWcc(op, var, arg0, cc)				\
-	__GEN_RMWcc(op " " arg0, var, cc)
+	__GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM)
+
+#define GEN_UNARY_SUFFIXED_RMWcc(op, suffix, var, arg0, cc)		\
+	__GEN_RMWcc(op " " arg0 "\n\t" suffix, var, cc,			\
+		    __CLOBBERS_MEM_CC_CX)
 
 #define GEN_BINARY_RMWcc(op, var, vcon, val, arg0, cc)			\
-	__GEN_RMWcc(op " %2, " arg0, var, cc, vcon (val))
+	__GEN_RMWcc(op __BINARY_RMWcc_ARG arg0, var, cc,		\
+		    __CLOBBERS_MEM, vcon (val))
 
-#endif /* defined(__GCC_ASM_FLAG_OUTPUTS__) || !defined(CC_HAVE_ASM_GOTO) */
+#define GEN_BINARY_SUFFIXED_RMWcc(op, suffix, var, vcon, val, arg0, cc)	\
+	__GEN_RMWcc(op __BINARY_RMWcc_ARG arg0 "\n\t" suffix, var, cc,	\
+		    __CLOBBERS_MEM_CC_CX, vcon (val))
 
 #endif /* _ASM_X86_RMWcc */
