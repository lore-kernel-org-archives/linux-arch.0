From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 8/8] powerpc/vdso: Provide __kernel_clock_gettime64() on
 vdso32
Date: Tue, 28 Apr 2020 13:16:54 +0000 (UTC)
Message-ID: <e78344d3fcc1d33bfb1782e430b7f0529f6c612f.1588079622.git.christophe.leroy@c-s.fr>
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:3827 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgD1NQ5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 09:16:57 -0400
In-Reply-To: <cover.1588079622.git.christophe.leroy@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com, luto@kernel.org, linux-arch@vger.kernel.org

Provides __kernel_clock_gettime64() on vdso32. This is the
64 bits version of __kernel_clock_gettime() which is
y2038 compliant.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/vdso32/gettimeofday.S  | 9 +++++++++
 arch/powerpc/kernel/vdso32/vdso32.lds.S    | 1 +
 arch/powerpc/kernel/vdso32/vgettimeofday.c | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index fd7b01c51281..a6e29f880e0e 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -35,6 +35,15 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	cvdso_call __c_kernel_clock_gettime
 V_FUNCTION_END(__kernel_clock_gettime)
 
+/*
+ * Exact prototype of clock_gettime64()
+ *
+ * int __kernel_clock_gettime64(clockid_t clock_id, struct __timespec64 *ts);
+ *
+ */
+V_FUNCTION_BEGIN(__kernel_clock_gettime64)
+	cvdso_call __c_kernel_clock_gettime64
+V_FUNCTION_END(__kernel_clock_gettime64)
 
 /*
  * Exact prototype of clock_getres()
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index 6cf729612268..05b462143238 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -144,6 +144,7 @@ VERSION
 #ifndef CONFIG_PPC_BOOK3S_601
 		__kernel_gettimeofday;
 		__kernel_clock_gettime;
+		__kernel_clock_gettime64;
 		__kernel_clock_getres;
 		__kernel_time;
 		__kernel_get_tbfreq;
diff --git a/arch/powerpc/kernel/vdso32/vgettimeofday.c b/arch/powerpc/kernel/vdso32/vgettimeofday.c
index 0b9ab4c22ef2..f7f71fecf4ed 100644
--- a/arch/powerpc/kernel/vdso32/vgettimeofday.c
+++ b/arch/powerpc/kernel/vdso32/vgettimeofday.c
@@ -11,6 +11,12 @@ int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
 	return __cvdso_clock_gettime32_data(vd, clock, ts);
 }
 
+int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
+			       const struct vdso_data *vd)
+{
+	return __cvdso_clock_gettime_data(vd, clock, ts);
+}
+
 int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz,
 			    const struct vdso_data *vd)
 {
-- 
2.25.0
