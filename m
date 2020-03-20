From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v5 21/26] arm64: vdso32: Include common headers in the vdso library
Date: Fri, 20 Mar 2020 14:53:46 +0000
Message-ID: <20200320145351.32292-22-vincenzo.frascino@arm.com>
References: <20200320145351.32292-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200320145351.32292-1-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, linux-mips@vger.kernel.org, x86@kernel.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>
List-Id: linux-arch.vger.kernel.org

The vDSO library should only include the necessary headers required for
a userspace library (UAPI and a minimal set of kernel headers). To make
this possible it is necessary to isolate from the kernel headers the
common parts that are strictly necessary to build the library.

Refactor the vdso32 implementation to include common headers.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 2 +-
 arch/arm64/kernel/vdso32/vgettimeofday.c          | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index 401df2bcd741..b6907ae78e53 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -8,7 +8,7 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/unistd.h>
-#include <uapi/linux/time.h>
+#include <asm/errno.h>
 
 #include <asm/vdso/compat_barrier.h>
 
diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
index ddbad47efaa4..5acff29c5991 100644
--- a/arch/arm64/kernel/vdso32/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2018 ARM Limited
  *
  */
-#include <linux/time.h>
-#include <linux/types.h>
 
 int __vdso_clock_gettime(clockid_t clock,
 			 struct old_timespec32 *ts)
-- 
2.25.1
