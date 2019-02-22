Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59090 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfBVMZr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 07:25:47 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v5 03/23] arm64: Build vDSO with -ffixed-x18
Date: Fri, 22 Feb 2019 12:24:10 +0000
Message-ID: <20190222122430.21180-4-vincenzo.frascino@arm.com>
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Mark Salyzyn <salyzyn@google.com>
Message-ID: <20190222122410.hoZYOhYROrohAh5gGHIeKK6DTv33KGeYr4LgtKpQ_0g@z>

From: Peter Collingbourne <pcc@google.com>

The vDSO needs to be build with x18 reserved in order to accommodate
userspace platform ABIs built on top of Linux that use the register
to carry inter-procedural state, as provided for by the AAPCS.
An example of such a platform ABI is the one that will be used by an
upcoming version of Android.

Although this change is currently a no-op due to the fact that the vDSO
is currently implemented in pure assembly on arm64, it is necessary
in order to prepare for another change [1] that will add C code to
the vDSO.

[1] https://patchwork.kernel.org/patch/10044501/

Signed-off-by: Peter Collingbourne <pcc@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Mark Salyzyn <salyzyn@google.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index b215c712d897..8cd4707f832a 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -12,7 +12,7 @@ obj-vdso := gettimeofday.o note.o sigreturn.o
 targets := $(obj-vdso) vdso.so vdso.so.dbg
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
-ccflags-y := -shared -fno-common -fno-builtin
+ccflags-y := -shared -fno-common -fno-builtin -ffixed-x18
 ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
 		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
 
-- 
2.20.1
