From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 05/18] arm64:uapi: set __BITS_PER_LONG correctly for ILP32 and LP64
Date: Wed, 17 Aug 2016 14:46:30 +0300
Message-ID: <1471434403-25291-6-git-send-email-ynorov@caviumnetworks.com>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0069.outbound.protection.outlook.com ([104.47.33.69]:34656
	"EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752523AbcHQLrt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Aug 2016 07:47:49 -0400
In-Reply-To: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com, Andrew Pinski <apinski@cavium.com>

From: Andrew Pinski <apinski@cavium.com>

Define __BITS_PER_LONG depending on the ABI used (i.e. check whether
__ILP32__ or __LP64__ is defined).  This is necessary for glibc to
determine the appropriate type definitions for the system call interface.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/include/uapi/asm/bitsperlong.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/bitsperlong.h b/arch/arm64/include/uapi/asm/bitsperlong.h
index fce9c29..4265243 100644
--- a/arch/arm64/include/uapi/asm/bitsperlong.h
+++ b/arch/arm64/include/uapi/asm/bitsperlong.h
@@ -16,7 +16,14 @@
 #ifndef __ASM_BITSPERLONG_H
 #define __ASM_BITSPERLONG_H
 
-#define __BITS_PER_LONG 64
+#if defined(__LP64__)
+/* Assuming __LP64__ will be defined for native ELF64's and not for ILP32. */
+#  define __BITS_PER_LONG 64
+#elif defined(__ILP32__)
+#  define __BITS_PER_LONG 32
+#else
+#  error "Neither LP64 nor ILP32: unsupported ABI in asm/bitsperlong.h"
+#endif
 
 #include <asm-generic/bitsperlong.h>
 
-- 
2.7.4
