From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] arm: add an option for erratum 657417
Date: Fri, 12 Aug 2016 18:19:17 +1000
Message-ID: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nicolas.pitre@linaro.org>, Julian Brown <julian@codesourcery.com>, Alan Modra <amodra@gmail.com>, Segher Boessenkool <segher@kernel.crashing.org>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

Erratum 657417 is worked around by the linker by inserting additional
branch trampolines to avoid problematic branch target locations. This
results in much higher linking time and presumably slower and larger
generated code. The workaround also seems to only be required when
linking thumb2 code, but the linker applies it for non-thumb2 code as
well.

The workaround today is left to the linker to apply, which is overly
conservative.

https://sourceware.org/ml/binutils/2009-05/msg00297.html

This patch adds an option which defaults to "y" in cases where we
could possibly be running Cortex A8 and using Thumb2 instructions.
In reality the workaround might not be required at all for the kernel
if virtual instruction memory is linear in physical memory. However it
is more conservative to keep the workaround, and it may be the case
that the TLB lookup would be required in order to catch branches to
unmapped or no-execute pages.

In an allyesconfig build, this workaround causes a large load on
the linker's branch stub hash and slows down the final link by a
factor of 5.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm/Kconfig  | 14 ++++++++++++++
 arch/arm/Makefile |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 90542db..3c7dde1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1033,6 +1033,20 @@ config ARM_ERRATA_460075
 	  ACTLR register. Note that setting specific bits in the ACTLR register
 	  may not be available in non-secure mode.
 
+config ARM_ERRATA_657417
+	bool "ARM errata: A 32-bit branch instruction that spans two 4K regions can result in an incorrect operation"
+	depends on CPU_V7
+	depends on THUMB2_KERNEL
+	default y
+	help
+	  This option enables the workaround for the 657417 Cortex-A8 erratum.
+	  If, while executing code in Thumb or ThumbEE state, a 32-bit Thumb-2
+	  branch instruction is executed that spans two 4KB regions, and the
+	  target address of the branch falls within the first region, it is
+	  possible for the processor to behave incorrectly. This workaround
+	  enables a linker workaround that adds branch trampolines that bounce
+	  offending branches via a safe location.
+
 config ARM_ERRATA_742230
 	bool "ARM errata: DMB operation may be faulty"
 	depends on CPU_V7 && SMP
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 274e8a6..b49a2e0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -43,6 +43,13 @@ ifeq ($(CONFIG_FRAME_POINTER),y)
 KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
 endif
 
+ifneq ($(CONFIG_ARM_ERRATA_657417),y)
+# ld-option has to run before we override LD otherwise it fails on
+# cross compile with mismatched endian (C compiler outputs one endian,
+# LD accepts another)
+LDFLAGS		+=$(call ld-option, --no-fix-cortex-a8,)
+endif
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 AS		+= -EB
-- 
2.8.1

