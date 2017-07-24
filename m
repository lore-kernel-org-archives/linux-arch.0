From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v7 2/3] x86/asm: add ASM_UNREACHABLE
Date: Sun, 23 Jul 2017 17:20:19 -0700
Message-ID: <1500855620-73004-3-git-send-email-keescook@chromium.org>
References: <1500855620-73004-1-git-send-email-keescook@chromium.org>
Return-path: <kernel-hardening-return-9102-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <1500855620-73004-1-git-send-email-keescook@chromium.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.orglinu
List-Id: linux-arch.vger.kernel.org

This creates an unreachable annotation in asm for CONFIG_STACK_VALIDATION.
While here, adjust earlier uses of \t\n into \n\t.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler-gcc.h | 13 +++++++++----
 include/linux/compiler.h     |  3 +++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index cd4bbe8242bd..179375b2d862 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -203,11 +203,16 @@
 
 #ifdef CONFIG_STACK_VALIDATION
 #define annotate_unreachable() ({					\
-	asm("%c0:\t\n"							\
-	    ".pushsection .discard.unreachable\t\n"			\
-	    ".long %c0b - .\t\n"					\
-	    ".popsection\t\n" : : "i" (__LINE__));			\
+	asm("%c0:\n\t"							\
+	    ".pushsection .discard.unreachable\n\t"			\
+	    ".long %c0b - .\n\t"					\
+	    ".popsection\n\t" : : "i" (__LINE__));			\
 })
+#define ASM_UNREACHABLE							\
+	"999:\n\t"							\
+	".pushsection .discard.unreachable\n\t"				\
+	".long 999b - .\n\t"						\
+	".popsection\n\t"
 #else
 #define annotate_unreachable()
 #endif
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 219f82f3ec1a..641f5912d75f 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -185,6 +185,9 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #endif
 
 /* Unreachable code */
+#ifndef ASM_UNREACHABLE
+# define ASM_UNREACHABLE
+#endif
 #ifndef unreachable
 # define unreachable() do { } while (1)
 #endif
-- 
2.7.4
