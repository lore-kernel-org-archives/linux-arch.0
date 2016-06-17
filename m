Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1on0086.outbound.protection.outlook.com ([157.56.110.86]:63328
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751095AbcFQXyo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Jun 2016 19:54:44 -0400
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 01/19] compat ABI: use non-compat openat and open_by_handle_at variants
Date: Sat, 18 Jun 2016 02:54:10 +0300
Message-ID: <1466207668-10549-2-git-send-email-ynorov@caviumnetworks.com>
In-Reply-To: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net
Message-ID: <20160617235410.feKUYu4Xh1UYSGLAywY6Xmgcy-TNhgOl3GxS6BX2Ju4@z>

The only difference is that non-compat version forces O_LARGEFILE,
and it should be the default behaviour for all architectures, as
we don't support 32-bit off_t. The only exception is tile32, that
continues with compat version of syscalls.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Chris Metcalf <cmetcalf@ezchip.com> [for tile]
---
 arch/tile/kernel/compat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/tile/kernel/compat.c b/arch/tile/kernel/compat.c
index 4912084..489ae19 100644
--- a/arch/tile/kernel/compat.c
+++ b/arch/tile/kernel/compat.c
@@ -94,6 +94,9 @@ COMPAT_SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned int, offset_high,
 #define compat_sys_readahead sys32_readahead
 #define sys_llseek compat_sys_llseek
 
+#define sys_openat		compat_sys_openat
+#define sys_open_by_handle_at	compat_sys_open_by_handle_at
+
 /* Call the assembly trampolines where necessary. */
 #define compat_sys_rt_sigreturn _compat_sys_rt_sigreturn
 #define sys_clone _sys_clone
-- 
2.7.4

