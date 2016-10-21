Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2nam02on0069.outbound.protection.outlook.com ([104.47.38.69]:13760
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932372AbcJUVHV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Oct 2016 17:07:21 -0400
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 04/18] arm64: ensure the kernel is compiled for LP64
Date: Fri, 21 Oct 2016 23:33:03 +0300
Message-ID: <1477081997-4770-5-git-send-email-ynorov@caviumnetworks.com>
In-Reply-To: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Message-ID: <20161021203303.SOCyFiZHu734RIIbpVtmJKKPb40RNA7FrL81crPWlDI@z>

From: Andrew Pinski <apinski@cavium.com>

The kernel needs to be compiled as a LP64 binary for ARM64, even when
using a compiler that defaults to code-generation for the ILP32 ABI.
Consequently, we need to explicitly pass '-mabi=lp64' (supported on
gcc-4.9 and newer).

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index ab51aed..80eb000 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -42,15 +42,20 @@ KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-option, -mpc-relative-literal-loads)
 KBUILD_AFLAGS	+= $(lseinstr)
 
+KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
+KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 AS		+= -EB
 LD		+= -EB
+LDFLAGS		+= -maarch64linuxb
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 AS		+= -EL
 LD		+= -EL
+LDFLAGS		+= -maarch64linux
 UTS_MACHINE	:= aarch64
 endif
 
-- 
2.7.4

