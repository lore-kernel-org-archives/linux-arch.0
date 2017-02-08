From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH] arm64: armv8_deprecated: add missing arm/kprobes.h header
Date: Wed,  8 Feb 2017 09:33:41 -0800
Message-ID: <20170208173341.14326-1-mcgrof@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932227AbdBHRom (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Feb 2017 12:44:42 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, arnd@arndb.de, mhiramat@kernel.org, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, luto@kernel.org, broonie@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org
Cc: bp@suse.de, bp@alien8.de, linux@armlinux.org.uk, dhowells@redhat.com, benh@kernel.crashing.org, ralf@linux-mips.org, jpoimboe@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org, kernel-build-reports@lists.linaro.org, "Luis R. Rodriguez" <mcgrof@kernel.org>

0-day caught a compile issue after the commit titled (kprobes: move
kprobe declarations to asm-generic/kprobes.h) was applied. This fixes
that.

Reported-by: 0-day
Cc: Mark Brown <broonie@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---

As seen on linux-next tag next-20170208.

 arch/arm64/kernel/armv8_deprecated.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 86032a012388..657977e77ec8 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -19,6 +19,7 @@
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
 #include <asm/traps.h>
+#include <asm/kprobes.h>
 #include <linux/uaccess.h>
 #include <asm/cpufeature.h>
 
-- 
2.11.0
