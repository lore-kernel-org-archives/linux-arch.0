From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 2/3] arm64: clocksource: Add VDSO default clockmode
Date: Fri, 21 Feb 2020 18:18:48 +0000
Message-ID: <20200221181849.40351-3-vincenzo.frascino@arm.com>
References: <20200221181849.40351-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200221181849.40351-1-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, linux@armlinux.org.uk, tglx@linutronix.de, luto@kernel.org, m.szyprowski@samsung.com, Mark.Rutland@arm.com, maz@kernel.org, vincenzo.frascino@arm.com
List-Id: linux-arch.vger.kernel.org

Define VDSO_CLOCKMODE_ARCH_DEFAULT to represent the default vDSO
clockmode for arm_arch_timer.

The change to arm_arch_timer will be in the next patch of this
series.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/clocksource.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/clocksource.h b/arch/arm64/include/asm/clocksource.h
index eb82e9d95c5d..36a2cca213ae 100644
--- a/arch/arm64/include/asm/clocksource.h
+++ b/arch/arm64/include/asm/clocksource.h
@@ -4,5 +4,6 @@
 
 #define VDSO_ARCH_CLOCKMODES	\
 	VDSO_CLOCKMODE_ARCHTIMER
+#define VDSO_CLOCKMODE_ARCH_DEFAULT	VDSO_CLOCKMODE_ARCHTIMER
 
 #endif
-- 
2.25.0
