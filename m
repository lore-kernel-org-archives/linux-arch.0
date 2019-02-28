Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:48941 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfB1L72 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Feb 2019 06:59:28 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] vdso: add clock_gettime64
Date: Thu, 28 Feb 2019 12:58:55 +0100
Message-ID: <20190228115855.610027-2-arnd@arndb.de>
In-Reply-To: <20190228115855.610027-1-arnd@arndb.de>
References: <CAK8P3a2D44CDXbcKB-WtphYY9E74ovFPs+e4Ti3fUqRL77AYhw@mail.gmail.com>
 <20190228115855.610027-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190228115855.X9sg0_VqcnkwI_veLeNSOhcCBygxeT4YNkRrYjlLyGU@z>

Adding a clock_gettime64() vdso call on all32-bit machines is now trivial.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/vdso/vdso.lds.S                | 1 +
 arch/arm/vdso/vgettimeofday.c           | 6 ++++++
 arch/arm64/kernel/vdso32/vdso.lds.S     | 1 +
 arch/mips/vdso/vdso.lds.S               | 3 +++
 arch/mips/vdso/vgettimeofday.c          | 6 ++++++
 arch/x86/entry/vdso/vclock_gettime.c    | 6 ++++++
 arch/x86/entry/vdso/vdso32/vdso32.lds.S | 1 +
 7 files changed, 24 insertions(+)

diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 1d81e8c3acf6..05581140fd12 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -83,6 +83,7 @@ VERSION
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_clock_getres;
+		__vdso_clock_gettime64;
 	local: *;
 	};
 }
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index b4607a5ecf31..6762f800a8ea 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -14,6 +14,12 @@ notrace int __vdso_clock_gettime(clockid_t clock,
 	return __cvdso_clock_gettime32(clock, ts);
 }
 
+notrace int __vdso_clock_gettime64(clockid_t clock,
+				 struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
 notrace int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 				struct timezone *tz)
 {
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
index 4fd3093ea78c..a3944927eaeb 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -68,6 +68,7 @@ VERSION
 		__kernel_sigreturn_thumb;
 		__kernel_rt_sigreturn_arm;
 		__kernel_rt_sigreturn_thumb;
+		__vdso_clock_gettime64;
 	local: *;
 	};
 }
diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index 90b2c2785e32..659fe0c3750a 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -100,6 +100,9 @@ VERSION
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_clock_getres;
+#if _MIPS_SIM != _MIPS_SIM_ABI64
+		__vdso_clock_gettime64;
+#endif
 #endif
 	local: *;
 	};
diff --git a/arch/mips/vdso/vgettimeofday.c b/arch/mips/vdso/vgettimeofday.c
index 7a3320faa29a..0b4fea088f89 100644
--- a/arch/mips/vdso/vgettimeofday.c
+++ b/arch/mips/vdso/vgettimeofday.c
@@ -27,6 +27,12 @@ notrace int __vdso_clock_getres(clockid_t clock_id,
 	return __cvdso_clock_getres_time32(clock_id, res);
 }
 
+notrace int __vdso_clock_gettime_time64(clockid_t clock,
+				 struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
 #else
 
 notrace int __vdso_clock_gettime(clockid_t clock,
diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index c9512c114ac1..0a7d4bdeadc9 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -54,6 +54,7 @@ int clock_getres(clockid_t, struct __kernel_timespec *)
 #else
 /* i386 only */
 extern int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts);
+extern int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts);
 extern int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res);
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
@@ -64,6 +65,11 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 int clock_gettime(clockid_t, struct old_timespec32 *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
+notrace int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
 notrace int __vdso_clock_getres(clockid_t clock,
 				struct old_timespec32 *res)
 {
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
index 991b26cc855b..c7720995ab1a 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -27,6 +27,7 @@ VERSION
 		__vdso_gettimeofday;
 		__vdso_time;
 		__vdso_clock_getres;
+		__vdso_clock_gettime64;
 	};
 
 	LINUX_2.5 {
-- 
2.20.0
