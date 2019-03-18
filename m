Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37392 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfCRQgS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Mar 2019 12:36:18 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 4/4] arm64: elf: Advertise relaxed ABI
Date: Mon, 18 Mar 2019 16:35:33 +0000
Message-ID: <20190318163533.26838-5-vincenzo.frascino@arm.com>
In-Reply-To: <20190318163533.26838-1-vincenzo.frascino@arm.com>
References: <cover.1552679409.git.andreyknvl@google.com>
 <20190318163533.26838-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Branislav Rankov <Branislav.Rankov@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Daniel Borkmann <daniel@iogearbox.net>, Dave Martin <Dave.Martin@arm.com>, "David S. Miller" <davem@davemloft.net>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, Evgeniy Stepanov <eugenis@google.com>, Graeme Barnes <Graeme.Barnes@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Kevin Brodsky <kevin.brodsky@arm.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Kostya Serebryany <kcc@google.com>, Lee Smith <Lee.Smith@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Robin Murphy <robin.murphy@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20190318163533.QVlnX4LO_-Yl3IfE-xuQqL-GH01J-EWVrIPvInstVw4@z>

On arm64 the TCR_EL1.TBI0 bit has been always enabled hence
the userspace (EL0) is allowed to set a non-zero value in the top
byte but the resulting pointers are not allowed at the user-kernel
syscall ABI boundary.

Set ARM64_AT_FLAGS_SYSCALL_TBI (bit[0]) in the AT_FLAGS to advertise
the relaxation of the ABI to the userspace.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
CC: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/atflags.h      | 7 +++++++
 arch/arm64/include/asm/elf.h          | 5 +++++
 arch/arm64/include/uapi/asm/atflags.h | 8 ++++++++
 3 files changed, 20 insertions(+)
 create mode 100644 arch/arm64/include/asm/atflags.h
 create mode 100644 arch/arm64/include/uapi/asm/atflags.h

diff --git a/arch/arm64/include/asm/atflags.h b/arch/arm64/include/asm/atflags.h
new file mode 100644
index 000000000000..b20093d61bf2
--- /dev/null
+++ b/arch/arm64/include/asm/atflags.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_ATFLAGS_H
+#define __ASM_ATFLAGS_H
+
+#include <uapi/asm/atflags.h>
+
+#endif
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 6adc1a90e7e6..73d5184a4dd9 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -16,6 +16,7 @@
 #ifndef __ASM_ELF_H
 #define __ASM_ELF_H
 
+#include <asm/atflags.h>
 #include <asm/hwcap.h>
 
 /*
@@ -167,6 +168,10 @@ do {									\
 		NEW_AUX_ENT(AT_IGNORE, 0);				\
 } while (0)
 
+/* Platform specific AT_FLAGS */
+#define ELF_AT_FLAGS			ARM64_AT_FLAGS_SYSCALL_TBI
+#define COMPAT_ELF_AT_FLAGS		0
+
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
diff --git a/arch/arm64/include/uapi/asm/atflags.h b/arch/arm64/include/uapi/asm/atflags.h
new file mode 100644
index 000000000000..1cf25692ffd6
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/atflags.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UAPI_ASM_ATFLAGS_H
+#define __UAPI_ASM_ATFLAGS_H
+
+/* Platform specific AT_FLAGS */
+#define ARM64_AT_FLAGS_SYSCALL_TBI	(1 << 0)
+
+#endif
-- 
2.21.0
