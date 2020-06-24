From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 9/9] arm64/build: Warn on orphan section placement
Date: Tue, 23 Jun 2020 18:49:40 -0700
Message-ID: <20200624014940.1204448-10-keescook@chromium.org>
References: <20200624014940.1204448-1-keescook@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388603AbgFXBt5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 21:49:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9164FC0617BB
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 18:49:55 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i4so386785pjd.0
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 18:49:55 -0700 (PDT)
In-Reply-To: <20200624014940.1204448-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly named in the linker
script.

Avoid .eh_frame* by making sure both -fno-asychronous-unwind-tables and
-fno-unwind-tables are present in both CFLAGS and AFLAGS. Remove one
last instance of .eh_frame by removing the needless Call Frame Information
annotations from arch/arm64/kernel/smccc-call.S.

Add .plt, .data.rel.ro, .igot.*, and .iplt to discards as they are not
actually used. While .got.plt is also not used, it must be included
otherwise ld.bfd will fail to link with the error:

    aarch64-linux-gnu-ld: discarded output section: `.got.plt'

However, as it'd be better to validate that it stays effectively empty,
add an assert.

Explicitly include debug sections when they're present.

Fix a case of needless quotes in __section(), which Clang doesn't like.

Finally, enable orphan section warnings.

Thanks to Ard Biesheuvel for many hints on correct ways to handle
mysterious sections. :)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Makefile             |  9 ++++++++-
 arch/arm64/kernel/smccc-call.S  |  2 --
 arch/arm64/kernel/vmlinux.lds.S | 11 ++++++++++-
 arch/arm64/mm/mmu.c             |  2 +-
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index a0d94d063fa8..fb3aa2d7de4d 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -29,6 +29,10 @@ LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
   endif
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 ifeq ($(CONFIG_ARM64_USE_LSE_ATOMICS), y)
   ifneq ($(CONFIG_ARM64_LSE_ATOMICS), y)
 $(warning LSE atomics not supported by binutils)
@@ -47,13 +51,16 @@ endif
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only	\
 		   $(compat_vdso) $(cc_has_k_constraint)
-KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(compat_vdso)
 
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
+# Avoid generating .eh_frame* sections.
+KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
+KBUILD_AFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
+
 ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
 prepare: stack_protector_prepare
 stack_protector_prepare: prepare0
diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index 1f93809528a4..d62447964ed9 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -9,7 +9,6 @@
 #include <asm/assembler.h>
 
 	.macro SMCCC instr
-	.cfi_startproc
 	\instr	#0
 	ldr	x4, [sp]
 	stp	x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
@@ -21,7 +20,6 @@
 	b.ne	1f
 	str	x6, [x4, ARM_SMCCC_QUIRK_STATE_OFFS]
 1:	ret
-	.cfi_endproc
 	.endm
 
 /*
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5427f502c3a6..f6c781768f83 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -94,7 +94,8 @@ SECTIONS
 	/DISCARD/ : {
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
-		*(.eh_frame)
+		*(.plt) *(.data.rel.ro)
+		*(.igot.*) *(.iplt)
 	}
 
 	. = KIMAGE_VADDR + TEXT_OFFSET;
@@ -244,8 +245,16 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 
 	HEAD_SYMBOLS
+
+	/*
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the lazy dispatch entries.
+	 */
+	.got.plt (INFO) : { *(.got.plt) }
+	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, ".got.plt not empty")
 }
 
 #include "image-vars.h"
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1df25f26571d..dce024ea6084 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -42,7 +42,7 @@
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
-u64 __section(".mmuoff.data.write") vabits_actual;
+u64 __section(.mmuoff.data.write) vabits_actual;
 EXPORT_SYMBOL(vabits_actual);
 
 u64 kimage_voffset __ro_after_init;
-- 
2.25.1
