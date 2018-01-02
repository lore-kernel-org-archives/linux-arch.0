From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] microblaze: fix endian handling
Date: Tue,  2 Jan 2018 12:47:19 +0100
Message-ID: <20180102114720.3408356-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Babu Moger <babu.moger@oracle.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

Building an allmodconfig kernel fails horribly because of
endian mismatch. It turns out that the -mlittle-endian
switch was not honored at all as we were using the wrong
Kconfig symbol and failing to apply CPUFLAGS to the CFLAGS.
Finally, the linker flags did not get set right.

This addresses all three of those issues, which now lets
me build both big-endian and little-endian kernels for
testing.

Fixes: 428dbf156cc5 ("arch: change default endian for microblaze")
Fixes: 206d3642d8ee ("arch/microblaze: add choice for endianness and update Makefile")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/microblaze/Makefile | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 830ee7d42fa0..d269dd4b8279 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -36,16 +36,21 @@ endif
 CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_DIV) += -mno-xl-soft-div
 CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_BARREL) += -mxl-barrel-shift
 CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR) += -mxl-pattern-compare
-CPUFLAGS-$(CONFIG_BIG_ENDIAN) += -mbig-endian
-CPUFLAGS-$(CONFIG_LITTLE_ENDIAN) += -mlittle-endian
+
+ifdef CONFIG_CPU_BIG_ENDIAN
+KBUILD_CFLAGS += -mbig-endian
+KBUILD_AFLAGS += -mbig-endian
+LD += -EB
+else
+KBUILD_CFLAGS += -mlittle-endian
+KBUILD_AFLAGS += -mlittle-endian
+LD += -EL
+endif
 
 CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
 
 # r31 holds current when in kernel mode
-KBUILD_CFLAGS += -ffixed-r31 $(CPUFLAGS-1) $(CPUFLAGS-2)
-
-LDFLAGS		:=
-LDFLAGS_vmlinux	:=
+KBUILD_CFLAGS += -ffixed-r31 $(CPUFLAGS-y) $(CPUFLAGS-1) $(CPUFLAGS-2)
 
 head-y := arch/microblaze/kernel/head.o
 libs-y += arch/microblaze/lib/
-- 
2.9.0
