From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v5 08/26] linux/clocksource.h: Extract common header for vDSO
Date: Fri, 20 Mar 2020 14:53:33 +0000
Message-ID: <20200320145351.32292-9-vincenzo.frascino@arm.com>
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

Split clocksource.h into linux and common headers to make the latter
suitable for inclusion in the vDSO library.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/linux/clocksource.h | 11 +----------
 include/vdso/clocksource.h  | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 10 deletions(-)
 create mode 100644 include/vdso/clocksource.h

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 02e3282719bd..86d143db6523 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -28,16 +28,7 @@ struct module;
 #include <asm/clocksource.h>
 #endif
 
-enum vdso_clock_mode {
-	VDSO_CLOCKMODE_NONE,
-#ifdef CONFIG_GENERIC_GETTIMEOFDAY
-	VDSO_ARCH_CLOCKMODES,
-#endif
-	VDSO_CLOCKMODE_MAX,
-
-	/* Indicator for time namespace VDSO */
-	VDSO_CLOCKMODE_TIMENS = INT_MAX
-};
+#include <vdso/clocksource.h>
 
 /**
  * struct clocksource - hardware abstraction for a free running counter
diff --git a/include/vdso/clocksource.h b/include/vdso/clocksource.h
new file mode 100644
index 000000000000..ab58330e4e5d
--- /dev/null
+++ b/include/vdso/clocksource.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_CLOCKSOURCE_H
+#define __VDSO_CLOCKSOURCE_H
+
+#include <vdso/limits.h>
+
+#if defined(CONFIG_ARCH_CLOCKSOURCE_DATA) || \
+	defined(CONFIG_GENERIC_GETTIMEOFDAY)
+#include <asm/vdso/clocksource.h>
+#endif /* CONFIG_ARCH_CLOCKSOURCE_DATA || CONFIG_GENERIC_GETTIMEOFDAY */
+
+enum vdso_clock_mode {
+	VDSO_CLOCKMODE_NONE,
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
+	VDSO_ARCH_CLOCKMODES,
+#endif
+	VDSO_CLOCKMODE_MAX,
+
+	/* Indicator for time namespace VDSO */
+	VDSO_CLOCKMODE_TIMENS = INT_MAX
+};
+
+#endif /* __VDSO_CLOCKSOURCE_H */
-- 
2.25.1
