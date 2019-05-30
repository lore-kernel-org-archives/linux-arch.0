Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfE3OQC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:16:02 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v6 05/19] arm64: Build vDSO with -ffixed-x18
Date: Thu, 30 May 2019 15:15:17 +0100
Message-ID: <20190530141531.43462-6-vincenzo.frascino@arm.com>
In-Reply-To: <20190530141531.43462-1-vincenzo.frascino@arm.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Mark Salyzyn <salyzyn@google.com>
Message-ID: <20190530141517.UbtDV6KloVw665rTm-q0vLNyclRbyB8uC9HF5l_f5KA@z>

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
index 00bcfd2672cf..d98230f70caf 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -20,7 +20,7 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
 		--build-id -n -T
 
-ccflags-y := -fno-common -fno-builtin -fno-stack-protector
+ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
 VDSO_LDFLAGS := -Bsymbolic
-- 
2.21.0
