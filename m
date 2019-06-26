From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2] arm64: vdso: Fix compilation with clang older then 8
Date: Wed, 26 Jun 2019 12:36:32 +0100
Message-ID: <20190626113632.9295-1-vincenzo.frascino@arm.com>
References: <20190621095252.32307-5-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621095252.32307-5-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com, daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com, pcc@google.com, shuah@kernel.org, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk, huw@codeweavers.com, sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org, Qian Cai <cai@lca.pw>
List-Id: linux-arch.vger.kernel.org

clang versions older then 8 do not support -mcmodel=tiny.

Add a check to the vDSO Makefile for arm64 to remove the flag when
these versions of the compiler are detected.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reported-by: Qian Cai <cai@lca.pw>
Tested-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/kernel/vdso/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index ec81d28aeb5d..4ab863045188 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -38,6 +38,13 @@ else
 CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -include $(c-gettimeofday-y)
 endif
 
+# Clang versions less than 8 do not support -mcmodel=tiny
+ifeq ($(CONFIG_CC_IS_CLANG), y)
+  ifeq ($(shell test $(CONFIG_CLANG_VERSION) -lt 80000; echo $$?),0)
+    CFLAGS_REMOVE_vgettimeofday.o += -mcmodel=tiny
+  endif
+endif
+
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
-- 
2.22.0
