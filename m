Return-Path: <SRS0=fQTO=6M=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:44196 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgD1NQz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 09:16:55 -0400
Message-ID: <1ab6a62c356c3bec35d1623563ef9c636205bcda.1588079622.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1588079622.git.christophe.leroy@c-s.fr>
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 7/8] lib/vdso: force inlining of
 __cvdso_clock_gettime_common()
Date: Tue, 28 Apr 2020 13:16:53 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com, luto@kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200428131653.M7L1KXmk6bdDrbSW98Cw9YjK4f63a6Zulh8DMKJcMZo@z>

When adding gettime64() to a 32 bit architecture (namely powerpc/32)
it has been noticed that GCC doesn't inline anymore
__cvdso_clock_gettime_common() because it is called twice
(Once by __cvdso_clock_gettime() and once by
__cvdso_clock_gettime32).

This has the effect of seriously degrading the performance:

Before the implementation of gettime64(), gettime() runs in:

	clock-gettime-monotonic-raw:    vdso: 1003 nsec/call
	clock-gettime-monotonic-coarse:    vdso: 592 nsec/call
	clock-gettime-monotonic:    vdso: 942 nsec/call

When adding a gettime64() entry point, the standard gettime()
performance is degraded by 30% to 50%:

	clock-gettime-monotonic-raw:    vdso: 1300 nsec/call
	clock-gettime-monotonic-coarse:    vdso: 900 nsec/call
	clock-gettime-monotonic:    vdso: 1232 nsec/call

Adding __always_inline() to __cvdso_clock_gettime_common()
regains the original performance.

In terms of code size, the inlining increases the code size
by only 176 bytes. This is in the noise for a kernel image.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 lib/vdso/gettimeofday.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index a2909af4b924..7938d3c4901d 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -210,7 +210,7 @@ static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t clk,
 	return 0;
 }
 
-static __maybe_unused int
+static __always_inline int
 __cvdso_clock_gettime_common(const struct vdso_data *vd, clockid_t clock,
 			     struct __kernel_timespec *ts)
 {
-- 
2.25.0
