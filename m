From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 1/3] arm: clocksource: Add VDSO default clockmode
Date: Fri, 21 Feb 2020 18:18:47 +0000
Message-ID: <20200221181849.40351-2-vincenzo.frascino@arm.com>
References: <20200221181849.40351-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200221181849.40351-1-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, linux@armlinux.org.uk, tglx@linutronix.de, luto@kernel.org, m.szyprowski@samsung.com, Mark.Rutland@arm.com, maz@kernel.org, vincenzo.frascino@arm.com
List-Id: linux-arch.vger.kernel.org

The arm_arch_timer requires that VDSO_CLOCKMODE_ARCHTIMER to be
defined to compile correctly. On arm the vDSO can be disabled and when
this is the case the compilation ends prematurely with an error.

Define VDSO_CLOCKMODE_ARCH_DEFAULT to represent the default vDSO
clockmode for arm_arch_timer.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm/Kconfig                   |  1 +
 arch/arm/include/asm/clocksource.h | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 03bbfc312fe7..97864aabc2a6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -3,6 +3,7 @@ config ARM
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
+	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/arch/arm/include/asm/clocksource.h b/arch/arm/include/asm/clocksource.h
index 73beb7f131de..3f7812d5764f 100644
--- a/arch/arm/include/asm/clocksource.h
+++ b/arch/arm/include/asm/clocksource.h
@@ -1,7 +1,17 @@
 #ifndef _ASM_CLOCKSOURCE_H
 #define _ASM_CLOCKSOURCE_H
 
+struct arch_clocksource_data {
+	/* Empty on purpose */
+};
+
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 #define VDSO_ARCH_CLOCKMODES	\
 	VDSO_CLOCKMODE_ARCHTIMER
+#define VDSO_CLOCKMODE_ARCH_DEFAULT	VDSO_CLOCKMODE_ARCHTIMER
+#else
+/* The define below is required because on arm the VDSOs can be disabled */
+#define VDSO_CLOCKMODE_ARCH_DEFAULT	VDSO_CLOCKMODE_NONE
+#endif
 
 #endif
-- 
2.25.0
