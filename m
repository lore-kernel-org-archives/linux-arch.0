Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39658 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732312AbfHFKBD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Aug 2019 06:01:03 -0400
Received: by mail-yb1-f196.google.com with SMTP id s142so445127ybc.6
        for <linux-arch@vger.kernel.org>; Tue, 06 Aug 2019 03:01:02 -0700 (PDT)
From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/3] error-injection: Consolidate override function definition
Date: Tue,  6 Aug 2019 18:00:13 +0800
Message-ID: <20190806100015.11256-2-leo.yan@linaro.org>
In-Reply-To: <20190806100015.11256-1-leo.yan@linaro.org>
References: <20190806100015.11256-1-leo.yan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <linux@armlinux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, clang-built-linux@googlegroups.com, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Message-ID: <20190806100013.rGu5ju376IVBQvCP4Pe9N03oezAu7IwJqWFlZPBiNEQ@z>

The function override_function_with_return() is defined separately for
each architecture and every architecture's definition is almost same
with each other.  E.g. x86 and powerpc both define function in its own
asm/error-injection.h header and override_function_with_return() has
the same definition, the only difference is that x86 defines an extra
function just_return_func() but it is specific for x86 and is only used
by x86's override_function_with_return(), so don't need to export this
function.

This patch consolidates override_function_with_return() definition into
asm-generic/error-injection.h header, thus all architectures can use the
common definition.  As result, the architecture specific headers are
removed; the include/linux/error-injection.h header also changes to
include asm-generic/error-injection.h header rather than architecture
header, furthermore, it includes linux/compiler.h for successful
compilation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/powerpc/include/asm/error-injection.h | 13 -------------
 arch/x86/include/asm/error-injection.h     | 13 -------------
 include/asm-generic/error-injection.h      |  6 ++++++
 include/linux/error-injection.h            |  6 +++---
 4 files changed, 9 insertions(+), 29 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/error-injection.h
 delete mode 100644 arch/x86/include/asm/error-injection.h

diff --git a/arch/powerpc/include/asm/error-injection.h b/arch/powerpc/include/asm/error-injection.h
deleted file mode 100644
index 62fd24739852..000000000000
--- a/arch/powerpc/include/asm/error-injection.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-
-#ifndef _ASM_ERROR_INJECTION_H
-#define _ASM_ERROR_INJECTION_H
-
-#include <linux/compiler.h>
-#include <linux/linkage.h>
-#include <asm/ptrace.h>
-#include <asm-generic/error-injection.h>
-
-void override_function_with_return(struct pt_regs *regs);
-
-#endif /* _ASM_ERROR_INJECTION_H */
diff --git a/arch/x86/include/asm/error-injection.h b/arch/x86/include/asm/error-injection.h
deleted file mode 100644
index 47b7a1296245..000000000000
--- a/arch/x86/include/asm/error-injection.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_ERROR_INJECTION_H
-#define _ASM_ERROR_INJECTION_H
-
-#include <linux/compiler.h>
-#include <linux/linkage.h>
-#include <asm/ptrace.h>
-#include <asm-generic/error-injection.h>
-
-asmlinkage void just_return_func(void);
-void override_function_with_return(struct pt_regs *regs);
-
-#endif /* _ASM_ERROR_INJECTION_H */
diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index 95a159a4137f..80ca61058dd2 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -16,6 +16,8 @@ struct error_injection_entry {
 	int		etype;
 };
 
+struct pt_regs;
+
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 /*
  * Whitelist ganerating macro. Specify functions which can be
@@ -28,8 +30,12 @@ static struct error_injection_entry __used				\
 		.addr = (unsigned long)fname,				\
 		.etype = EI_ETYPE_##_etype,				\
 	};
+
+void override_function_with_return(struct pt_regs *regs);
 #else
 #define ALLOW_ERROR_INJECTION(fname, _etype)
+
+static inline void override_function_with_return(struct pt_regs *regs) { }
 #endif
 #endif
 
diff --git a/include/linux/error-injection.h b/include/linux/error-injection.h
index 280c61ecbf20..635a95caf29f 100644
--- a/include/linux/error-injection.h
+++ b/include/linux/error-injection.h
@@ -2,16 +2,16 @@
 #ifndef _LINUX_ERROR_INJECTION_H
 #define _LINUX_ERROR_INJECTION_H
 
-#ifdef CONFIG_FUNCTION_ERROR_INJECTION
+#include <linux/compiler.h>
+#include <asm-generic/error-injection.h>
 
-#include <asm/error-injection.h>
+#ifdef CONFIG_FUNCTION_ERROR_INJECTION
 
 extern bool within_error_injection_list(unsigned long addr);
 extern int get_injectable_error_type(unsigned long addr);
 
 #else /* !CONFIG_FUNCTION_ERROR_INJECTION */
 
-#include <asm-generic/error-injection.h>
 static inline bool within_error_injection_list(unsigned long addr)
 {
 	return false;
-- 
2.17.1
