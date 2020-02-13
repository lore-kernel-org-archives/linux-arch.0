Return-Path: <SRS0=hmIl=4B=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:50282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbgBMQRf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 11:17:35 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 19/19] arm64: vdso32: Enable Clang Compilation
Date: Thu, 13 Feb 2020 16:16:14 +0000
Message-ID: <20200213161614.23246-20-vincenzo.frascino@arm.com>
In-Reply-To: <20200213161614.23246-1-vincenzo.frascino@arm.com>
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, paul.burton@mips.com, tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, bp@alien8.de, sboyd@kernel.org, salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com, ndesaulniers@google.com, avagin@openvz.org
Message-ID: <20200213161614.x6Nd-nGNVQ5vceL8aW0GL2ICf21XKamU4A7SFWuzdZ8@z>

Enable Clang Compilation for the vdso32 library.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/vdso32/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 04df57b43cb1..209639101044 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -11,8 +11,10 @@ include $(srctree)/lib/vdso/Makefile
 # Same as cc-*option, but using CC_COMPAT instead of CC
 ifeq ($(CONFIG_CC_IS_CLANG), y)
 CC_COMPAT ?= $(CC)
+LD_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
 else
 CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
+LD_COMPAT ?= $(CC_COMPAT)
 endif
 
 cc32-option = $(call try-run,\
@@ -171,7 +173,7 @@ quiet_cmd_vdsold_and_vdso_check = LD32    $@
       cmd_vdsold_and_vdso_check = $(cmd_vdsold); $(cmd_vdso_check)
 
 quiet_cmd_vdsold = LD32    $@
-      cmd_vdsold = $(CC_COMPAT) -Wp,-MD,$(depfile) $(VDSO_LDFLAGS) \
+      cmd_vdsold = $(LD_COMPAT) -Wp,-MD,$(depfile) $(VDSO_LDFLAGS) \
                    -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) -o $@
 quiet_cmd_vdsocc = CC32    $@
       cmd_vdsocc = $(CC_COMPAT) -Wp,-MD,$(depfile) $(VDSO_CFLAGS) -c -o $@ $<
-- 
2.25.0
