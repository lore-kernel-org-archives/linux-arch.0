From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [RFC][PATCH 3/3] arm64: elf: Advertise relaxed ABI
Date: Mon, 10 Dec 2018 14:30:44 +0000
Message-ID: <20181210143044.12714-4-vincenzo.frascino@arm.com>
References: <cover.1544445454.git.andreyknvl@google.com>
 <20181210143044.12714-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210143044.12714-1-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>, Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>, Ramana Radhakrishnan <Ramana.Radhakris>
List-Id: linux-arch.vger.kernel.org

On arm64 the TCR_EL1.TBI0 bit has been set since Linux 3.x hence
the userspace (EL0) is allowed to set a non-zero value in the top
byte but the resulting pointers are not allowed at the user-kernel
syscall ABI boundary.

This patch sets ARM64_AT_FLAGS_SYSCALL_TBI (bit[0]) in the AT_FLAGS
to advertise the relaxation of the ABI to the userspace.

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
index 433b9554c6a1..da5a6d310ff4 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -16,6 +16,7 @@
 #ifndef __ASM_ELF_H
 #define __ASM_ELF_H
 
+#include <asm/atflags.h>
 #include <asm/hwcap.h>
 
 /*
@@ -163,6 +164,10 @@ do {									\
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
2.19.2
