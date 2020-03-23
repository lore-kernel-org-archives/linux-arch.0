From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH] um: Fix header inclusion
Date: Mon, 23 Mar 2020 12:41:09 +0000
Message-ID: <20200323124109.7104-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, kbuild test robot <lkp@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
List-Id: linux-arch.vger.kernel.org

User Mode is a flavor of x86 that from the vDSO prospective always falls
back on system calls. This implies that it does not require any of the
unified vDSO definitions and their inclusion causes side effects like
the one reported below:

In file included from include/vdso/processor.h:10:0,
                    from include/vdso/datapage.h:17,
                    from arch/x86/include/asm/vgtod.h:7,
                    from arch/x86/um/../kernel/sys_ia32.c:49:
>> arch/x86/include/asm/vdso/processor.h:11:29: error: redefinition of 'rep_nop'
    static __always_inline void rep_nop(void)
                                ^~~~~~~
   In file included from include/linux/rcupdate.h:30:0,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/x86/um/../kernel/sys_ia32.c:25:
   arch/x86/um/asm/processor.h:24:20: note: previous definition of 'rep_nop' was here
    static inline void rep_nop(void)

Make sure that the unnecessary headers are not included when um is built
to address the problem.

Fixes: abc22418db02 ("x86/vdso: Enable x86 to use common headers")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Rebased on tip/master

 arch/x86/include/asm/vgtod.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index fc8e4cd342cc..7aa38b2ad8a9 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -2,6 +2,11 @@
 #ifndef _ASM_X86_VGTOD_H
 #define _ASM_X86_VGTOD_H
 
+/*
+ * This check is required to prevent ARCH=um to include
+ * unwanted headers.
+ */
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 #include <linux/compiler.h>
 #include <asm/clocksource.h>
 #include <vdso/datapage.h>
@@ -14,5 +19,6 @@ typedef u64 gtod_long_t;
 #else
 typedef unsigned long gtod_long_t;
 #endif
+#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 #endif /* _ASM_X86_VGTOD_H */
-- 
2.25.2
