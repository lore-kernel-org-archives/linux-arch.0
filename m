From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH] lib: vdso: Fix sparse warning
Date: Thu, 28 Nov 2019 11:17:19 +0000
Message-ID: <20191128111719.8282-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, luto@kernel.org, marc.w.gonzalez@free.fr
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Fix the following sparse warning in the generic vDSO library:

linux/lib/vdso/gettimeofday.c:224:5: warning: symbol
'__cvdso_clock_getres' was
not declared. Should it be static?

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Lutomirski <luto@kernel.org>
Reported-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Link: https://www.spinics.net/lists/arm-kernel/msg770849.html
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 lib/vdso/gettimeofday.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 45f57fd2db64..1d47b34a8ad9 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -221,6 +221,7 @@ int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
 	return 0;
 }
 
+static __maybe_unused
 int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 {
 	int ret = __cvdso_clock_getres_common(clock, res);
-- 
2.24.0
