Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:44019 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731609AbfIEPXo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Sep 2019 11:23:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] ipc: fix semtimedop for generic 32-bit architectures
Date: Thu,  5 Sep 2019 17:21:24 +0200
Message-ID: <20190905152155.1392871-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, y2038@lists.linaro.org, Manfred Spraul <manfred@colorfullife.com>, Davidlohr Bueso <dave@stgolabs.net>, Dominik Brodowski <linux@dominikbrodowski.net>, "Eric W . Biederman" <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>, Vincent Chen <deanbo422@gmail.com>, stable@vger.kernel.org, Greentime Hu <green.hu@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Guan Xuetao <gxt@pku.edu.cn>, Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Ley Foon Tan <lftan@altera.com>, Richard Kuo <rkuo@codeaurora.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Guo Ren <guoren@kernel.org>, Christian Brauner <christian@brauner.io>
Message-ID: <20190905152124.DfG1V2oEcM4pVDY1Ppf3xFnglUW86_nd6mlF8u1hiKc@z>

As Vincent noticed, the y2038 conversion of semtimedop in linux-5.1
broke when commit 00bf25d693e7 ("y2038: use time32 syscall names on
32-bit") changed all system calls on all architectures that take
a 32-bit time_t to point to the _time32 implementation, but left out
semtimedop in the asm-generic header.

This affects all 32-bit architectures using asm-generic/unistd.h:
h8300, unicore32, openrisc, nios2, hexagon, c6x, arc, nds32 and csky.

The notable exception is riscv32, which has dropped support for the
time32 system calls entirely.

Reported-by: Vincent Chen <deanbo422@gmail.com>
Cc: stable@vger.kernel.org
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Guan Xuetao <gxt@pku.edu.cn>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: Guo Ren <guoren@kernel.org>
Fixes: 00bf25d693e7 ("y2038: use time32 syscall names on 32-bit")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Hi Vincent,

Sorry for the delay since your report. Does this address your
problem?

Anyone else, please note that this patch is required since
5.1 to make sysvipc work on the listed architectures.
---
 include/uapi/asm-generic/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1be0e798e362..1fc8faa6e973 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -569,7 +569,7 @@ __SYSCALL(__NR_semget, sys_semget)
 __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_semtimedop 192
-__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
+__SC_3264(__NR_semtimedop, sys_semtimedop_time32, sys_semtimedop)
 #endif
 #define __NR_semop 193
 __SYSCALL(__NR_semop, sys_semop)
-- 
2.20.0
