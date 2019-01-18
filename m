Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:57485 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbfARQVX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2019 11:21:23 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 20/29] time: fix sys_timer_settime prototype
Date: Fri, 18 Jan 2019 17:18:26 +0100
Message-ID: <20190118161835.2259170-21-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com, deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org, davem@davemloft.net, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jcmvbkbc@gmail.com, akpm@linux-foundation.org, deepa.kernel@gmail.com, ebiederm@xmission.com, firoz.khan@linaro.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <20190118161826.uaA4QyeBBjsxZF0aCU8xDjBPzgShFpDScAZsuG6tgl4@z>

A small typo has crept into the y2038 conversion of the timer_settime
system call. So far this was completely harmless, but once we start
using the new version, this has to be fixed.

Fixes: 6ff847350702 ("time: Change types to new y2038 safe __kernel_itimerspec")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 938d8908b9e0..baa4b70b02d3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -591,7 +591,7 @@ asmlinkage long sys_timer_gettime(timer_t timer_id,
 asmlinkage long sys_timer_getoverrun(timer_t timer_id);
 asmlinkage long sys_timer_settime(timer_t timer_id, int flags,
 				const struct __kernel_itimerspec __user *new_setting,
-				struct itimerspec __user *old_setting);
+				struct __kernel_itimerspec __user *old_setting);
 asmlinkage long sys_timer_delete(timer_t timer_id);
 asmlinkage long sys_clock_settime(clockid_t which_clock,
 				const struct __kernel_timespec __user *tp);
-- 
2.20.0
