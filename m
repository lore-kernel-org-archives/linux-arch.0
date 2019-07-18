Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:57362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfGRLlf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Jul 2019 07:41:35 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH] arm64: vdso: Cleanup Makefiles.
Date: Thu, 18 Jul 2019 12:41:21 +0100
Message-ID: <20190718114121.33024-1-vincenzo.frascino@arm.com>
In-Reply-To: <20190712153746.5dwwptgrle3z25m7@willie-the-truck>
References: <20190712153746.5dwwptgrle3z25m7@willie-the-truck>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk, huw@codeweavers.com, sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org, john.stultz@linaro.org, naohiro.aota@wdc.com, yamada.masahiro@socionext.com, Will Deacon <will@kernel.org>
Message-ID: <20190718114121.cZ1pV211_TO85A4nXC3HrbicYLZebPD3pt6ZyUh1i1Q@z>

The recent changes to the vdso library for arm64 and the introduction of
the compat vdso library have generated some misalignment in the
Makefiles.

Cleanup the Makefiles for vdso and vdso32 libraries:
  * Removing unused rules.
  * Unifying the displayed compilation messages.
  * Simplifying the generic library inclusion path for
    arm64 vdso.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/vdso/Makefile   | 11 ++++-------
 arch/arm64/kernel/vdso32/Makefile | 10 +++++-----
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 75d25679d879..aa5a12325a3c 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -32,10 +32,10 @@ UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 KCOV_INSTRUMENT			:= n
 
-ifeq ($(c-gettimeofday-y),)
 CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny
-else
-CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -include $(c-gettimeofday-y)
+
+ifneq ($(c-gettimeofday-y),)
+  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
 endif
 
 # Clang versions less than 8 do not support -mcmodel=tiny
@@ -73,10 +73,7 @@ include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 	$(call if_changed,vdsosym)
 
 # Actual build commands
-quiet_cmd_vdsocc = VDSOCC   $@
-      cmd_vdsocc = $(CC) $(a_flags) $(c_flags) -c -o $@ $<
-
-quiet_cmd_vdsold_and_vdso_check = LD      $@
+quiet_cmd_vdsold_and_vdso_check = VDSOLIB $@
       cmd_vdsold_and_vdso_check = $(cmd_ld); $(cmd_vdso_check)
 
 # Install commands for the unstripped file
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 21009ed5a755..6c4e496309c4 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -155,17 +155,17 @@ $(asm-obj-vdso): %.o: %.S FORCE
 	$(call if_changed_dep,vdsoas)
 
 # Actual build commands
-quiet_cmd_vdsold_and_vdso_check = LD      $@
+quiet_cmd_vdsold_and_vdso_check = VDSOLIB $@
       cmd_vdsold_and_vdso_check = $(cmd_vdsold); $(cmd_vdso_check)
 
-quiet_cmd_vdsold = VDSOL   $@
+quiet_cmd_vdsold = VDSOLD  $@
       cmd_vdsold = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_LDFLAGS) \
                    -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) -o $@
-quiet_cmd_vdsocc = VDSOC   $@
+quiet_cmd_vdsocc = CC      $@
       cmd_vdsocc = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_CFLAGS) -c -o $@ $<
-quiet_cmd_vdsocc_gettimeofday = VDSOC_GTD   $@
+quiet_cmd_vdsocc_gettimeofday = CC      $@
       cmd_vdsocc_gettimeofday = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_CFLAGS) $(VDSO_CFLAGS_gettimeofday_o) -c -o $@ $<
-quiet_cmd_vdsoas = VDSOA   $@
+quiet_cmd_vdsoas = AS      $@
       cmd_vdsoas = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_AFLAGS) -c -o $@ $<
 
 quiet_cmd_vdsomunge = MUNGE   $@
-- 
2.22.0
