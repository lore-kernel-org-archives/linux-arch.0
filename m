From: =?UTF-8?B?dGlwLWJvdCBmb3IgS2VlcyBDb29rIDx0aXBib3RAenl0b3IuY29tPg==?=@zytor.com
Subject: =?UTF-8?B?W3RpcDptbS9yZWFkb25seV0gYXNtLWdlbmVyaWM6IENvbnNvbGlkYXRlIG1hcms=?=
 =?UTF-8?B?X3JvZGF0YV9ybygp?=
Date: Mon, 22 Feb 2016 04:18:06 -0800
Message-ID: <tip-e267d97b83d9cecc16c54825f9f3ac7f72dc1e1e@git.kernel.org>
References: <1455748879-21872-2-git-send-email-keescook@chromium.org>
Reply-To: linux@arm.linux.org.uk, re.emese@gmail.com,
	  jejb@parisc-linux.org, nicolas.pitre@linaro.org,
	  linux-arch@vger.kernel.org, dan.j.williams@intel.com,
	  akpm@linux-foundation.org, ashoks@broadcom.com,
	  torvalds@linux-foundation.org, marc.zyngier@arm.com,
	  ard.biesheuvel@linaro.org, arnd@arndb.de, tglx@linutronix.de,
	  catalin.marinas@arm.com, dvlasenk@redhat.com,
	  will.deacon@arm.com, deller@gmx.de, paul.gortmaker@windriver.com,
	  agross@codeaurora.org, rusty@rustcorp.com.au, mpe@ellerman.id.au,
	  mingo@kernel.org, brgerst@gmail.com, peterz@infradead.org,
	  hpa@zytor.com, mark.rutland@arm.com, dahi@linux.vnet.ibm.com,
	  minipli@googlemail.com, pageexec@freemail.hu,
	  luto@amacapital.net, mcgrof@suse.com, keescook@chromium.org,
	  ross.zwisler@linux.intel.com, david.brown@linaro.org, bp@suse.de,
	  toshi.kani@hp.com, sboyd@codeaurora.org,
	  linux-kernel@vger.kern
Mime-Version: =?UTF-8?B?MS4w?=
Content-Type: =?UTF-8?B?dGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOA==?=
Content-Transfer-Encoding: =?UTF-8?B?OGJpdA==?=
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455748879-21872-2-git-send-email-keescook@chromium.org>
Content-Disposition: =?UTF-8?B?aW5saW5l?=
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?bGludXgtdGlwLWNvbW1pdHNAdmdlci5rZXJuZWwub3Jn?=@zytor.com
Cc: dvlasenk@redhat.com, tglx@linutronix.de, catalin.marinas@arm.com, arnd@arndb.de, ard.biesheuvel@linaro.org, will.deacon@arm.com, mpe@ellerman.id.au, agross@codeaurora.org, rusty@rustcorp.com.au, paul.gortmaker@windriver.com, deller@gmx.de, brgerst@gmail.com, mingo@kernel.org, jejb@parisc-linux.org, re.emese@gmail.com, linux@arm.linux.org.uk, dan.j.williams@intel.com, linux-arch@vger.kernel.org, nicolas.pitre@linaro.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, ashoks@broadcom.com, marc.zyngier@arm.com, sboyd@codeaurora.org, toshi.kani@hp.com, bp@suse.de, bp@alien8.de, linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org, mark.rutland@arm.com, pageexec@freemail.hu, dahi@linux.vnet.ibm.com, minipli@googlemail.com, david.brown@linaro.org, keescook@chromium.org, ross.zwisler@linux.intel.com, mcgrof@suse.com, luto@amacapital.net
List-Id: linux-arch.vger.kernel.org

Commit-ID:  e267d97b83d9cecc16c54825f9f3ac7f72dc1e1e
Gitweb:     http://git.kernel.org/tip/e267d97b83d9cecc16c54825f9f3ac7f72dc1e1e
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Wed, 17 Feb 2016 14:41:12 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 22 Feb 2016 08:51:37 +0100

asm-generic: Consolidate mark_rodata_ro()

Instead of defining mark_rodata_ro() in each architecture, consolidate it.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Gross <agross@codeaurora.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ashok Kumar <ashoks@broadcom.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Brown <david.brown@linaro.org>
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Emese Revfy <re.emese@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <jejb@parisc-linux.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathias Krause <minipli@googlemail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: PaX Team <pageexec@freemail.hu>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Toshi Kani <toshi.kani@hp.com>
Cc: kernel-hardening@lists.openwall.com
Cc: linux-arch <linux-arch@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Link: http://lkml.kernel.org/r/1455748879-21872-2-git-send-email-keescook@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/include/asm/cacheflush.h    | 1 -
 arch/arm64/include/asm/cacheflush.h  | 4 ----
 arch/parisc/include/asm/cacheflush.h | 4 ----
 arch/x86/include/asm/cacheflush.h    | 1 -
 include/linux/init.h                 | 4 ++++
 5 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index d5525bf..9156fc3 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -491,7 +491,6 @@ static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
 #ifdef CONFIG_DEBUG_RODATA
-void mark_rodata_ro(void);
 void set_kernel_text_rw(void);
 void set_kernel_text_ro(void);
 #else
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 7fc294c..22dda61 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -156,8 +156,4 @@ int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
 
-#ifdef CONFIG_DEBUG_RODATA
-void mark_rodata_ro(void);
-#endif
-
 #endif
diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index 845272c..7bd69bd 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -121,10 +121,6 @@ flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned long vma
 	}
 }
 
-#ifdef CONFIG_DEBUG_RODATA
-void mark_rodata_ro(void);
-#endif
-
 #include <asm/kmap_types.h>
 
 #define ARCH_HAS_KMAP
diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index e63aa38..c8cff75 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -92,7 +92,6 @@ void clflush_cache_range(void *addr, unsigned int size);
 #define mmio_flush_range(addr, size) clflush_cache_range(addr, size)
 
 #ifdef CONFIG_DEBUG_RODATA
-void mark_rodata_ro(void);
 extern const int rodata_test_data;
 extern int kernel_set_to_readonly;
 void set_kernel_text_rw(void);
diff --git a/include/linux/init.h b/include/linux/init.h
index b449f37..aedb254 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -142,6 +142,10 @@ void prepare_namespace(void);
 void __init load_default_modules(void);
 int __init init_rootfs(void);
 
+#ifdef CONFIG_DEBUG_RODATA
+void mark_rodata_ro(void);
+#endif
+
 extern void (*late_time_init)(void);
 
 extern bool initcall_debug;
