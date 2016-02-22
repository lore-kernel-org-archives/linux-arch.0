From: =?UTF-8?B?dGlwLWJvdCBmb3IgS2VlcyBDb29rIDx0aXBib3RAenl0b3IuY29tPg==?=@zytor.com
Subject: =?UTF-8?B?W3RpcDptbS9yZWFkb25seV0gYXJjaDogSW50cm9kdWNlIHBvc3QtaW5pdCByZWE=?=
 =?UTF-8?B?ZC1vbmx5IG1lbW9yeQ==?=
Date: Mon, 22 Feb 2016 04:19:33 -0800
Message-ID: <tip-c74ba8b3480da6ddaea17df2263ec09b869ac496@git.kernel.org>
References: <1455748879-21872-5-git-send-email-keescook@chromium.org>
Reply-To: arnd@arndb.de, bp@alien8.de, tglx@linutronix.de,
	  brgerst@gmail.com, torvalds@linux-foundation.org,
	  dvlasenk@redhat.com, mpe@ellerman.id.au, luto@amacapital.net,
	  peterz@infradead.org, pageexec@freemail.hu,
	  keescook@chromium.org, minipli@googlemail.com,
	  re.emese@gmail.com, david.brown@linaro.org, hpa@zytor.com,
	  linux-arch@vger.kernel.org, mingo@kernel.org,
	  linux-kernel@vger.kernel.org, spender@grsecurity.net
Mime-Version: =?UTF-8?B?MS4w?=
Content-Type: =?UTF-8?B?dGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOA==?=
Content-Transfer-Encoding: =?UTF-8?B?OGJpdA==?=
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455748879-21872-5-git-send-email-keescook@chromium.org>
Content-Disposition: =?UTF-8?B?aW5saW5l?=
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?bGludXgtdGlwLWNvbW1pdHNAdmdlci5rZXJuZWwub3Jn?=@zytor.com
Cc: peterz@infradead.org, minipli@googlemail.com, keescook@chromium.org, pageexec@freemail.hu, re.emese@gmail.com, linux-arch@vger.kernel.org, hpa@zytor.com, david.brown@linaro.org, mingo@kernel.org, linux-kernel@vger.kernel.org, spender@grsecurity.net, arnd@arndb.de, tglx@linutronix.de, bp@alien8.de, dvlasenk@redhat.com, torvalds@linux-foundation.org, brgerst@gmail.com, mpe@ellerman.id.au, luto@amacapital.net
List-Id: linux-arch.vger.kernel.org

Commit-ID:  c74ba8b3480da6ddaea17df2263ec09b869ac496
Gitweb:     http://git.kernel.org/tip/c74ba8b3480da6ddaea17df2263ec09b869ac496
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Wed, 17 Feb 2016 14:41:15 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 22 Feb 2016 08:51:38 +0100

arch: Introduce post-init read-only memory

One of the easiest ways to protect the kernel from attack is to reduce
the internal attack surface exposed when a "write" flaw is available. By
making as much of the kernel read-only as possible, we reduce the
attack surface.

Many things are written to only during __init, and never changed
again. These cannot be made "const" since the compiler will do the wrong
thing (we do actually need to write to them). Instead, move these items
into a memory region that will be made read-only during mark_rodata_ro()
which happens after all kernel __init code has finished.

This introduces __ro_after_init as a way to mark such memory, and adds
some documentation about the existing __read_mostly marking.

This improves the security of the Linux kernel by marking formerly
read-write memory regions as read-only on a fully booted up system.

Based on work by PaX Team and Brad Spengler.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brad Spengler <spender@grsecurity.net>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Brown <david.brown@linaro.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Emese Revfy <re.emese@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathias Krause <minipli@googlemail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: PaX Team <pageexec@freemail.hu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-hardening@lists.openwall.com
Cc: linux-arch <linux-arch@vger.kernel.org>
Link: http://lkml.kernel.org/r/1455748879-21872-5-git-send-email-keescook@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/parisc/include/asm/cache.h   |  3 +++
 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/cache.h             | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/parisc/include/asm/cache.h b/arch/parisc/include/asm/cache.h
index 3d0e17b..df0f52b 100644
--- a/arch/parisc/include/asm/cache.h
+++ b/arch/parisc/include/asm/cache.h
@@ -22,6 +22,9 @@
 
 #define __read_mostly __attribute__((__section__(".data..read_mostly")))
 
+/* Read-only memory is marked before mark_rodata_ro() is called. */
+#define __ro_after_init	__read_mostly
+
 void parisc_cache_init(void);	/* initializes cache-flushing */
 void disable_sr_hashing_asm(int); /* low level support for above */
 void disable_sr_hashing(void);   /* turns off space register hashing */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c4bd0e2..772c784 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -256,6 +256,7 @@
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		VMLINUX_SYMBOL(__start_rodata) = .;			\
 		*(.rodata) *(.rodata.*)					\
+		*(.data..ro_after_init)	/* Read only after init */	\
 		*(__vermagic)		/* Kernel version magic */	\
 		. = ALIGN(8);						\
 		VMLINUX_SYMBOL(__start___tracepoints_ptrs) = .;		\
diff --git a/include/linux/cache.h b/include/linux/cache.h
index 17e7e82..1be04f8 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -12,10 +12,24 @@
 #define SMP_CACHE_BYTES L1_CACHE_BYTES
 #endif
 
+/*
+ * __read_mostly is used to keep rarely changing variables out of frequently
+ * updated cachelines. If an architecture doesn't support it, ignore the
+ * hint.
+ */
 #ifndef __read_mostly
 #define __read_mostly
 #endif
 
+/*
+ * __ro_after_init is used to mark things that are read-only after init (i.e.
+ * after mark_rodata_ro() has been called). These are effectively read-only,
+ * but may get written to during init, so can't live in .rodata (via "const").
+ */
+#ifndef __ro_after_init
+#define __ro_after_init __attribute__((__section__(".data..ro_after_init")))
+#endif
+
 #ifndef ____cacheline_aligned
 #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
 #endif
