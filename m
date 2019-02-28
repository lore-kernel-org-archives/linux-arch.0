Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:38763 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732421AbfB1L7c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Feb 2019 06:59:32 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] vdso: use fixed-size time types
Date: Thu, 28 Feb 2019 12:58:54 +0100
Message-ID: <20190228115855.610027-1-arnd@arndb.de>
In-Reply-To: <CAK8P3a2D44CDXbcKB-WtphYY9E74ovFPs+e4Ti3fUqRL77AYhw@mail.gmail.com>
References: <CAK8P3a2D44CDXbcKB-WtphYY9E74ovFPs+e4Ti3fUqRL77AYhw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190228115854.BNUFT12HdK3EUKl5NhzoimvplhpwIHzfw3u1-yKaZTc@z>

Hi Vincento,

I've implemented now what I tried to explain earlier.  This moves the
implementation of clock_gettime() and clock_getres() over to 64-bit
__kernel_timespec, with a conversion in the end for architectures that
actually use the 32-bit calls.

The vdso/types.h file is now obsolete, but we do need to duplicate
a few functions on mips32 and x86-32. It may be possible to fold those
into the generic lib/vdso/gettimeofday.c file as another step.

If there are no objections, please fold these changes into your
series.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/vdso/gettimeofday.h      | 16 +++---
 arch/arm/vdso/vgettimeofday.c                 | 10 ++--
 .../include/asm/vdso/compat_gettimeofday.h    | 16 +++---
 arch/arm64/include/asm/vdso/gettimeofday.h    | 12 ++--
 arch/arm64/kernel/vdso/vgettimeofday.c        |  6 +-
 arch/arm64/kernel/vdso32/vgettimeofday.c      | 14 +++--
 arch/mips/include/asm/vdso/gettimeofday.h     | 22 ++++---
 arch/mips/vdso/vgettimeofday.c                | 28 ++++++++-
 arch/x86/entry/vdso/vclock_gettime.c          | 57 +++++++++++++------
 arch/x86/include/asm/vdso/gettimeofday.h      | 16 +++---
 include/vdso/datapage.h                       |  1 -
 include/vdso/types.h                          | 39 -------------
 lib/vdso/gettimeofday.c                       | 48 +++++++++++-----
 13 files changed, 164 insertions(+), 121 deletions(-)
 delete mode 100644 include/vdso/types.h

diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
index e7aeda0b255f..112df50920b0 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -14,11 +14,11 @@
 extern struct vdso_data *__get_datapage(void);
 
 static __always_inline notrace int gettimeofday_fallback(
-					struct __vdso_timeval *_tv,
+					struct __kernel_old_timeval *_tv,
 					struct timezone *_tz)
 {
 	register struct timezone *tz asm("r1") = _tz;
-	register struct __vdso_timeval *tv asm("r0") = _tv;
+	register struct __kernel_old_timeval *tv asm("r0") = _tv;
 	register long ret asm ("r0");
 	register long nr asm("r7") = __NR_gettimeofday;
 
@@ -33,12 +33,12 @@ static __always_inline notrace int gettimeofday_fallback(
 
 static __always_inline notrace long clock_gettime_fallback(
 						clockid_t _clkid,
-						struct __vdso_timespec *_ts)
+						struct __kernel_timespec *_ts)
 {
-	register struct __vdso_timespec *ts asm("r1") = _ts;
+	register struct __kernel_timespec *ts asm("r1") = _ts;
 	register clockid_t clkid asm("r0") = _clkid;
 	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_clock_gettime;
+	register long nr asm("r7") = __NR_clock_gettime64;
 
 	asm volatile(
 	"	swi #0\n"
@@ -51,12 +51,12 @@ static __always_inline notrace long clock_gettime_fallback(
 
 static __always_inline notrace int clock_getres_fallback(
 						clockid_t _clkid,
-						struct __vdso_timespec *_ts)
+						struct __kernel_timespec *_ts)
 {
-	register struct __vdso_timespec *ts asm("r1") = _ts;
+	register struct __kernel_timespec *ts asm("r1") = _ts;
 	register clockid_t clkid asm("r0") = _clkid;
 	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_clock_getres;
+	register long nr asm("r7") = __NR_clock_getres_time64;
 
 	asm volatile(
 	"       swi #0\n"
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index b470a8ed35a7..b4607a5ecf31 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -9,21 +9,21 @@
 #include <linux/types.h>
 
 notrace int __vdso_clock_gettime(clockid_t clock,
-				 struct __vdso_timespec *ts)
+				 struct old_timespec32 *ts)
 {
-	return __cvdso_clock_gettime(clock, ts);
+	return __cvdso_clock_gettime32(clock, ts);
 }
 
-notrace int __vdso_gettimeofday(struct __vdso_timeval *tv,
+notrace int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 				struct timezone *tz)
 {
 	return __cvdso_gettimeofday(tv, tz);
 }
 
 notrace int __vdso_clock_getres(clockid_t clock_id,
-				struct __vdso_timespec *res)
+				struct old_timespec32 *res)
 {
-	return __cvdso_clock_getres(clock_id, res);
+	return __cvdso_clock_getres_time32(clock_id, res);
 }
 
 /* Avoid unresolved references emitted by GCC */
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index 888c70c24f71..b41d8f01a20c 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -24,11 +24,11 @@
 extern struct vdso_data _vdso_data __attribute__((visibility("hidden")));
 
 static __always_inline notrace int gettimeofday_fallback(
-					struct __vdso_timeval *_tv,
+					struct __kernel_old_timeval *_tv,
 					struct timezone *_tz)
 {
 	register struct timezone *tz asm("r1") = _tz;
-	register struct __vdso_timeval *tv asm("r0") = _tv;
+	register struct __kernel_old_timeval *tv asm("r0") = _tv;
 	register long ret asm ("r0");
 	register long nr asm("r7") = __NR_compat_gettimeofday;
 
@@ -43,12 +43,12 @@ static __always_inline notrace int gettimeofday_fallback(
 
 static __always_inline notrace long clock_gettime_fallback(
 					clockid_t _clkid,
-					struct __vdso_timespec *_ts)
+					struct __kernel_timespec *_ts)
 {
-	register struct __vdso_timespec *ts asm("r1") = _ts;
+	register struct __kernel_timespec *ts asm("r1") = _ts;
 	register clockid_t clkid asm("r0") = _clkid;
 	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_compat_clock_gettime;
+	register long nr asm("r7") = __NR_compat_clock_gettime64;
 
 	asm volatile(
 	"	swi #0\n"
@@ -61,12 +61,12 @@ static __always_inline notrace long clock_gettime_fallback(
 
 static __always_inline notrace int clock_getres_fallback(
 					clockid_t _clkid,
-					struct __vdso_timespec *_ts)
+					struct __kernel_timespec *_ts)
 {
-	register struct __vdso_timespec *ts asm("r1") = _ts;
+	register struct __kernel_timespec *ts asm("r1") = _ts;
 	register clockid_t clkid asm("r0") = _clkid;
 	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_compat_clock_getres;
+	register long nr asm("r7") = __NR_compat_clock_getres_time64;
 
 	/* The checks below are required for ABI consistency with arm */
 	if ((_clkid >= MAX_CLOCKS) || (_ts == NULL))
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index 0aff6362533f..126fc6f4f7cf 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -13,11 +13,11 @@
 extern struct vdso_data _vdso_data;
 
 static __always_inline notrace int gettimeofday_fallback(
-					struct __vdso_timeval *_tv,
+					struct __kernel_old_timeval *_tv,
 					struct timezone *_tz)
 {
 	register struct timezone *tz asm("x1") = _tz;
-	register struct __vdso_timeval *tv asm("x0") = _tv;
+	register struct __kernel_old_timeval *tv asm("x0") = _tv;
 	register long ret asm ("x0");
 	register long nr asm("x8") = __NR_gettimeofday;
 
@@ -32,9 +32,9 @@ static __always_inline notrace int gettimeofday_fallback(
 
 static __always_inline notrace long clock_gettime_fallback(
 						clockid_t _clkid,
-						struct __vdso_timespec *_ts)
+						struct __kernel_timespec *_ts)
 {
-	register struct __vdso_timespec *ts asm("x1") = _ts;
+	register struct __kernel_timespec *ts asm("x1") = _ts;
 	register clockid_t clkid asm("x0") = _clkid;
 	register long ret asm ("x0");
 	register long nr asm("x8") = __NR_clock_gettime;
@@ -50,9 +50,9 @@ static __always_inline notrace long clock_gettime_fallback(
 
 static __always_inline notrace int clock_getres_fallback(
 						clockid_t _clkid,
-						struct __vdso_timespec *_ts)
+						struct __kernel_timespec *_ts)
 {
-	register struct __vdso_timespec *ts asm("x1") = _ts;
+	register struct __kernel_timespec *ts asm("x1") = _ts;
 	register clockid_t clkid asm("x0") = _clkid;
 	register long ret asm ("x0");
 	register long nr asm("x8") = __NR_clock_getres;
diff --git a/arch/arm64/kernel/vdso/vgettimeofday.c b/arch/arm64/kernel/vdso/vgettimeofday.c
index 160e68196339..bbc83b6e2b1a 100644
--- a/arch/arm64/kernel/vdso/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso/vgettimeofday.c
@@ -9,19 +9,19 @@
 #include <linux/types.h>
 
 notrace int __kernel_clock_gettime(clockid_t clock,
-				   struct __vdso_timespec *ts)
+				   struct __kernel_timespec *ts)
 {
 	return __cvdso_clock_gettime(clock, ts);
 }
 
-notrace int __kernel_gettimeofday(struct __vdso_timeval *tv,
+notrace int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
 				  struct timezone *tz)
 {
 	return __cvdso_gettimeofday(tv, tz);
 }
 
 notrace int __kernel_clock_getres(clockid_t clock_id,
-				  struct __vdso_timespec *res)
+				  struct __kernel_timespec *res)
 {
 	return __cvdso_clock_getres(clock_id, res);
 }
diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
index b470a8ed35a7..6762f800a8ea 100644
--- a/arch/arm64/kernel/vdso32/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
@@ -9,21 +9,27 @@
 #include <linux/types.h>
 
 notrace int __vdso_clock_gettime(clockid_t clock,
-				 struct __vdso_timespec *ts)
+				 struct old_timespec32 *ts)
+{
+	return __cvdso_clock_gettime32(clock, ts);
+}
+
+notrace int __vdso_clock_gettime64(clockid_t clock,
+				 struct __kernel_timespec *ts)
 {
 	return __cvdso_clock_gettime(clock, ts);
 }
 
-notrace int __vdso_gettimeofday(struct __vdso_timeval *tv,
+notrace int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 				struct timezone *tz)
 {
 	return __cvdso_gettimeofday(tv, tz);
 }
 
 notrace int __vdso_clock_getres(clockid_t clock_id,
-				struct __vdso_timespec *res)
+				struct old_timespec32 *res)
 {
-	return __cvdso_clock_getres(clock_id, res);
+	return __cvdso_clock_getres_time32(clock_id, res);
 }
 
 /* Avoid unresolved references emitted by GCC */
diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
index b275392f6b1b..ed6dafda5fc2 100644
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -25,11 +25,11 @@
 #ifdef CONFIG_MIPS_CLOCK_VSYSCALL
 
 static __always_inline notrace long gettimeofday_fallback(
-					struct __vdso_timeval *_tv,
+					struct __kernel_old_timeval *_tv,
 					struct timezone *_tz)
 {
 	register struct timezone *tz asm("a1") = _tz;
-	register struct __vdso_timeval *tv asm("a0") = _tv;
+	register struct __kernel_old_timeval *tv asm("a0") = _tv;
 	register long ret asm("v0");
 	register long nr asm("v0") = __NR_gettimeofday;
 	register long error asm("a3");
@@ -47,7 +47,7 @@ static __always_inline notrace long gettimeofday_fallback(
 #else
 
 static __always_inline notrace long gettimeofday_fallback(
-					struct __vdso_timeval *_tv,
+					struct __kernel_old_timeval *_tv,
 					struct timezone *_tz)
 {
 	return -1;
@@ -57,12 +57,16 @@ static __always_inline notrace long gettimeofday_fallback(
 
 static __always_inline notrace long clock_gettime_fallback(
 						clockid_t _clkid,
-						struct __vdso_timespec *_ts)
+						struct __kernel_timespec *_ts)
 {
-	register struct __vdso_timespec *ts asm("a1") = _ts;
+	register struct __kernel_timespec *ts asm("a1") = _ts;
 	register clockid_t clkid asm("a0") = _clkid;
 	register long ret asm("v0");
+#if _MIPS_SIM == _MIPS_SIM_ABI64
 	register long nr asm("v0") = __NR_clock_gettime;
+#else
+	register long nr asm("v0") = __NR_clock_gettime64
+#endif
 	register long error asm("a3");
 
 	asm volatile(
@@ -77,12 +81,16 @@ static __always_inline notrace long clock_gettime_fallback(
 
 static __always_inline notrace int clock_getres_fallback(
 						clockid_t _clkid,
-						struct __vdso_timespec *_ts)
+						struct __kernel_timespec *_ts)
 {
-	register struct __vdso_timespec *ts asm("a1") = _ts;
+	register struct __kernel_timespec *ts asm("a1") = _ts;
 	register clockid_t clkid asm("a0") = _clkid;
 	register long ret asm("v0");
+#if _MIPS_SIM == _MIPS_SIM_ABI64
 	register long nr asm("v0") = __NR_clock_getres;
+#else
+	register long nr asm("v0") = __NR_clock_getres64
+#endif
 	register long error asm("a3");
 
 	asm volatile(
diff --git a/arch/mips/vdso/vgettimeofday.c b/arch/mips/vdso/vgettimeofday.c
index 8da361d919f0..7a3320faa29a 100644
--- a/arch/mips/vdso/vgettimeofday.c
+++ b/arch/mips/vdso/vgettimeofday.c
@@ -8,21 +8,43 @@
 #include <linux/time.h>
 #include <linux/types.h>
 
+#if _MIPS_SIM != _MIPS_SIM_ABI64
 notrace int __vdso_clock_gettime(clockid_t clock,
-				 struct __vdso_timespec *ts)
+				 struct old_timespec32 *ts)
+{
+	return __cvdso_clock_gettime32(clock, ts);
+}
+
+notrace int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
+				struct timezone *tz)
+{
+	return __cvdso_gettimeofday_time32(tv, tz);
+}
+
+notrace int __vdso_clock_getres(clockid_t clock_id,
+				struct old_timespec32 *res)
+{
+	return __cvdso_clock_getres_time32(clock_id, res);
+}
+
+#else
+
+notrace int __vdso_clock_gettime(clockid_t clock,
+				 struct __kernel_timespec *ts)
 {
 	return __cvdso_clock_gettime(clock, ts);
 }
 
-notrace int __vdso_gettimeofday(struct __vdso_timeval *tv,
+notrace int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 				struct timezone *tz)
 {
 	return __cvdso_gettimeofday(tv, tz);
 }
 
 notrace int __vdso_clock_getres(clockid_t clock_id,
-				struct __vdso_timespec *res)
+				struct __kernel_timespec *res)
 {
 	return __cvdso_clock_getres(clock_id, res);
 }
 
+#endif
diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 6ff8cabf4c3e..c9512c114ac1 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -12,25 +12,14 @@
 
 #include "../../../../lib/vdso/gettimeofday.c"
 
-extern int __vdso_clock_gettime(clockid_t clock, struct __vdso_timespec *ts);
-extern int __vdso_gettimeofday(struct __vdso_timeval *tv, struct timezone *tz);
+extern int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 extern time_t __vdso_time(time_t *t);
-extern int __vdso_clock_getres(clockid_t clock, struct __vdso_timespec *res);
-
-notrace int __vdso_clock_gettime(clockid_t clock, struct __vdso_timespec *ts)
-{
-	return __cvdso_clock_gettime(clock, ts);
-}
-
-int clock_gettime(clockid_t, struct __vdso_timespec *)
-	__attribute__((weak, alias("__vdso_clock_gettime")));
-
-notrace int __vdso_gettimeofday(struct __vdso_timeval *tv,
+notrace int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 				struct timezone *tz)
 {
 	return __cvdso_gettimeofday(tv, tz);
 }
-int gettimeofday(struct __vdso_timeval *, struct timezone *)
+int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
 	__attribute__((weak, alias("__vdso_gettimeofday")));
 
 notrace time_t __vdso_time(time_t *t)
@@ -40,10 +29,46 @@ notrace time_t __vdso_time(time_t *t)
 time_t time(time_t *t)
 	__attribute__((weak, alias("__vdso_time")));
 
+
+#ifdef __x86_64__
+/* both 64-bit and x32 use these */
+extern int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
+extern int __vdso_clock_getres(clockid_t clock, struct __kernel_timespec *res);
+
+notrace int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int clock_gettime(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_gettime")));
+
 notrace int __vdso_clock_getres(clockid_t clock,
-				struct __vdso_timespec *res)
+				struct __kernel_timespec *res)
 {
 	return __cvdso_clock_getres(clock, res);
 }
-int clock_getres(clockid_t, struct __vdso_timespec *)
+int clock_getres(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_getres")));
+
+#else
+/* i386 only */
+extern int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts);
+extern int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res);
+
+notrace int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
+{
+	return __cvdso_clock_gettime32(clock, ts);
+}
+
+int clock_gettime(clockid_t, struct old_timespec32 *)
+	__attribute__((weak, alias("__vdso_clock_gettime")));
+
+notrace int __vdso_clock_getres(clockid_t clock,
+				struct old_timespec32 *res)
+{
+	return __cvdso_clock_getres_time32(clock, res);
+}
+int clock_getres(clockid_t, struct old_timespec32 *)
 	__attribute__((weak, alias("__vdso_clock_getres")));
+#endif
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 1a86fdc1e400..510a0ebd5748 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -38,7 +38,7 @@ extern u8 hvclock_page
 
 static __always_inline notrace long clock_gettime_fallback(
 						clockid_t _clkid,
-						struct __vdso_timespec *_ts)
+						struct __kernel_timespec *_ts)
 {
 	long ret;
 	asm ("syscall" : "=a" (ret), "=m" (*_ts) :
@@ -48,7 +48,7 @@ static __always_inline notrace long clock_gettime_fallback(
 }
 
 static __always_inline notrace long gettimeofday_fallback(
-						struct __vdso_timeval *_tv,
+						struct __kernel_old_timeval *_tv,
 						struct timezone *_tz)
 {
 	long ret;
@@ -59,7 +59,7 @@ static __always_inline notrace long gettimeofday_fallback(
 
 static __always_inline notrace long clock_getres_fallback(
 						clockid_t _clkid,
-						struct __vdso_timespec *_ts)
+						struct __kernel_timespec *_ts)
 {
 	long ret;
 	asm ("syscall" : "=a" (ret), "=m" (*_ts) :
@@ -72,7 +72,7 @@ static __always_inline notrace long clock_getres_fallback(
 
 static __always_inline notrace long clock_gettime_fallback(
 						clockid_t _clkid,
-						struct __vdso_timespec *_ts)
+						struct __kernel_timespec *_ts)
 {
 	long ret;
 
@@ -82,13 +82,13 @@ static __always_inline notrace long clock_gettime_fallback(
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
 		: "=a" (ret), "=m" (*_ts)
-		: "0" (__NR_clock_gettime), [clock] "g" (_clkid), "c" (_ts)
+		: "0" (__NR_clock_gettime64), [clock] "g" (_clkid), "c" (_ts)
 		: "edx");
 	return ret;
 }
 
 static __always_inline notrace long gettimeofday_fallback(
-						struct __vdso_timeval *_tv,
+						struct __kernel_old_timeval *_tv,
 						struct timezone *_tz)
 {
 	long ret;
@@ -105,7 +105,7 @@ static __always_inline notrace long gettimeofday_fallback(
 
 static __always_inline notrace long clock_getres_fallback(
 						clockid_t _clkid,
-						struct __vdso_timespec *_ts)
+						struct __kernel_timespec *_ts)
 {
 	long ret;
 
@@ -115,7 +115,7 @@ static __always_inline notrace long clock_getres_fallback(
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
 		: "=a" (ret), "=m" (*_ts)
-		: "0" (__NR_clock_getres), [clock] "g" (_clkid), "c" (_ts)
+		: "0" (__NR_clock_getres_time64), [clock] "g" (_clkid), "c" (_ts)
 		: "edx");
 	return ret;
 }
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index ff332fcba73c..da346ad02b03 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -9,7 +9,6 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/time.h>
-#include <vdso/types.h>
 
 #define VDSO_BASES	(CLOCK_TAI + 1)
 #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
diff --git a/include/vdso/types.h b/include/vdso/types.h
deleted file mode 100644
index f456a0a6a2e1..000000000000
--- a/include/vdso/types.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __VDSO_TYPES_H
-#define __VDSO_TYPES_H
-
-#ifdef __KERNEL__
-
-#ifndef __ASSEMBLY__
-
-#include <linux/types.h>
-#include <linux/time.h>
-
-/*
- * The definitions below are required to overcome the limitations
- * of time_t on 32 bit architectures, which overflows in 2038.
- * The new code should use the replacements based on time64_t and
- * timespec64.
- *
- * The abstraction below will be updated once the migration to
- * time64_t is complete.
- */
-#ifdef CONFIG_GENERIC_VDSO_32
-#define __vdso_timespec		old_timespec32
-#define __vdso_timeval		old_timeval32
-#else
-#ifdef ENABLE_COMPAT_VDSO
-#define __vdso_timespec		old_timespec32
-#define __vdso_timeval		old_timeval32
-#else
-#define __vdso_timespec		__kernel_timespec
-#define __vdso_timeval		__kernel_old_timeval
-#endif /* CONFIG_COMPAT_VDSO */
-#endif /* CONFIG_GENERIC_VDSO_32 */
-
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
-#endif /* __VDSO_TYPES_H */
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 466d0c68fa80..f10e3703abaa 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -28,7 +28,7 @@
 
 static notrace int do_hres(const struct vdso_data *vd,
 			   clockid_t clk,
-			   struct __vdso_timespec *ts)
+			   struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
 	u64 cycles, last, sec, ns;
@@ -63,7 +63,7 @@ static notrace int do_hres(const struct vdso_data *vd,
 
 static notrace void do_coarse(const struct vdso_data *vd,
 			      clockid_t clk,
-			      struct __vdso_timespec *ts)
+			      struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
 	u32 seq;
@@ -75,8 +75,8 @@ static notrace void do_coarse(const struct vdso_data *vd,
 	} while (unlikely(vdso_read_retry(vd, seq)));
 }
 
-static notrace int __cvdso_clock_gettime(clockid_t clock,
-					 struct __vdso_timespec *ts)
+static notrace __maybe_unused int
+__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 {
 	const struct vdso_data *vd = __arch_get_vdso_data();
 	u32 msk;
@@ -100,19 +100,31 @@ static notrace int __cvdso_clock_gettime(clockid_t clock,
 	return clock_gettime_fallback(clock, ts);
 }
 
-static notrace int __cvdso_gettimeofday(struct __vdso_timeval *tv,
-					struct timezone *tz)
+static notrace __maybe_unused int
+__cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
+{
+	struct __kernel_timespec ts;
+	int ret = __cvdso_clock_gettime(clock, &ts);
+
+	res->tv_sec = ts.tv_sec;
+	res->tv_nsec = ts.tv_nsec;
+
+	return ret;
+}
+
+static notrace __maybe_unused int
+__cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	const struct vdso_data *vd = __arch_get_vdso_data();
 
 	if (likely(tv != NULL)) {
-		struct __vdso_timespec ts;
+		struct __kernel_timespec ts;
 
 		if (do_hres(vd, CLOCK_REALTIME, &ts))
 			return gettimeofday_fallback(tv, tz);
 
 		tv->tv_sec = ts.tv_sec;
-		tv->tv_usec = ts.tv_nsec / NSEC_PER_USEC;
+		tv->tv_usec = (u32)ts.tv_nsec / NSEC_PER_USEC;
 	}
 
 	if (unlikely(tz != NULL)) {
@@ -123,8 +135,7 @@ static notrace int __cvdso_gettimeofday(struct __vdso_timeval *tv,
 	return 0;
 }
 
-#ifdef VDSO_HAS_TIME
-static notrace time_t __cvdso_time(time_t *time)
+static notrace __maybe_unused time_t __cvdso_time(time_t *time)
 {
 	const struct vdso_data *vd = __arch_get_vdso_data();
 	time_t t = READ_ONCE(vd->basetime[CLOCK_REALTIME].sec);
@@ -134,10 +145,9 @@ static notrace time_t __cvdso_time(time_t *time)
 
 	return t;
 }
-#endif /* VDSO_HAS_TIME */
 
-static notrace int __cvdso_clock_getres(clockid_t clock,
-					struct __vdso_timespec *res)
+static notrace __maybe_unused
+int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 {
 	u64 sec, ns;
 	u32 msk;
@@ -177,3 +187,15 @@ static notrace int __cvdso_clock_getres(clockid_t clock,
 fallback:
 	return clock_getres_fallback(clock, res);
 }
+
+static notrace __maybe_unused int
+__cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
+{
+	struct __kernel_timespec ts;
+	int ret = __cvdso_clock_getres(clock, &ts);
+
+	res->tv_sec = ts.tv_sec;
+	res->tv_nsec = ts.tv_nsec;
+
+	return ret;
+}
-- 
2.20.0
