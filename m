From: tip-bot for Kees Cook <tipbot@zytor.com>
Subject: [tip:x86/asm] x86/asm: Add ASM_UNREACHABLE
Date: Tue, 25 Jul 2017 06:49:02 -0700
Message-ID: <tip-aa5d1b81500e6059190f18fe25a7617682321910@git.kernel.org>
References: <1500921349-10803-3-git-send-email-keescook@chromium.org>
Reply-To: arnd@arndb.de, riel@redhat.com, linux-kernel@vger.kernel.org,
          hch@infradead.org, mingo@kernel.org,
          James.Bottomley@hansenpartnership.com, tglx@linutronix.de,
          hpa@zytor.com, ishkamiel@gmail.com, keescook@chromium.org,
          davem@davemloft.net, linux-arch@vger.kernel.org,
          torvalds@linux-foundation.org, jannh@google.com,
          jpoimboe@redhat.com, serge@hallyn.com, manfred@colorfullife.com,
          peterz@infradead.org, ebiederm@xmission.com,
          gregkh@linuxfoundation.org, akpm@linux-foundation.org,
          elena.reshetova@intel.com, adobriyan@gmail.com,
          dave@stgolabs.net, ebiggers3@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500921349-10803-3-git-send-email-keescook@chromium.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Cc: elena.reshetova@intel.com, akpm@linux-foundation.org, dave@stgolabs.net, adobriyan@gmail.com, ebiggers3@gmail.com, jannh@google.com, torvalds@linux-foundation.org, jpoimboe@redhat.com, manfred@colorfullife.com, peterz@infradead.org, serge@hallyn.com, ebiederm@xmission.com, gregkh@linuxfoundation.org, hpa@zytor.com, tglx@linutronix.de, ishkamiel@gmail.com, keescook@chromium.org, davem@davemloft.net, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, riel@redhat.com, arnd@arndb.de, mingo@kernel.org, hch@infradead.org, James.Bottomley@hansenpartnership.com
List-Id: linux-arch.vger.kernel.org

Commit-ID:  aa5d1b81500e6059190f18fe25a7617682321910
Gitweb:     http://git.kernel.org/tip/aa5d1b81500e6059190f18fe25a7617682321910
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Mon, 24 Jul 2017 11:35:48 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 25 Jul 2017 11:18:09 +0200

x86/asm: Add ASM_UNREACHABLE

This creates an unreachable annotation in asm for CONFIG_STACK_VALIDATION=y.
While here, adjust earlier uses of \t\n into \n\t.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
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
Link: http://lkml.kernel.org/r/1500921349-10803-3-git-send-email-keescook@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/compiler-gcc.h | 13 +++++++++----
 include/linux/compiler.h     |  3 +++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index cd4bbe8..179375b 100644
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
index 219f82f..641f591 100644
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
