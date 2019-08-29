Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728602AbfH2PvK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 11:51:10 -0400
From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Subject: [PATCH v2 1/2] powerpc: Add PowerPC Capabilities ELF note
Date: Thu, 29 Aug 2019 12:50:20 -0300
Message-ID: <20190829155021.2915-2-maxiwell@linux.ibm.com>
In-Reply-To: <20190829155021.2915-1-maxiwell@linux.ibm.com>
References: <20190829155021.2915-1-maxiwell@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, paulus@ozlabs.org, mpe@ellerman.id.au, andmike@linux.ibm.com, linuxram@us.ibm.com, bauerman@linux.ibm.com, cclaudio@linux.ibm.com, "Maxiwell S . Garcia" <maxiwell@linux.ibm.com>
Message-ID: <20190829155020.Kkb30Lnys0BZou1CwEYtlUZfTb2rOBznPyRjayopBeE@z>

From: Claudio Carvalho <cclaudio@linux.ibm.com>

Add the PowerPC name and the PPC_ELFNOTE_CAPABILITIES type in the
kernel binary ELF note. This type is a bitmap that can be used to
advertise kernel capabilities to userland.

This patch also defines PPCCAP_ULTRAVISOR_BIT as being the bit zero.

Suggested-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
[ maxiwell: Define the 'PowerPC' type in the elfnote.h ]
Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
---
 arch/powerpc/include/asm/elfnote.h | 24 ++++++++++++++++++
 arch/powerpc/kernel/Makefile       |  2 +-
 arch/powerpc/kernel/note.S         | 40 ++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/elfnote.h
 create mode 100644 arch/powerpc/kernel/note.S

diff --git a/arch/powerpc/include/asm/elfnote.h b/arch/powerpc/include/asm/elfnote.h
new file mode 100644
index 000000000000..a201b6e9ae44
--- /dev/null
+++ b/arch/powerpc/include/asm/elfnote.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PowerPC ELF notes.
+ *
+ * Copyright 2019, IBM Corporation
+ */
+
+#ifndef __ASM_POWERPC_ELFNOTE_H__
+#define __ASM_POWERPC_ELFNOTE_H__
+
+/*
+ * These note types should live in a SHT_NOTE segment and have
+ * "PowerPC" in the name field.
+ */
+
+/*
+ * The capabilities supported/required by this kernel (bitmap).
+ *
+ * This type uses a bitmap as "desc" field. Each bit is described
+ * in arch/powerpc/kernel/note.S
+ */
+#define PPC_ELFNOTE_CAPABILITIES 1
+
+#endif /* __ASM_POWERPC_ELFNOTE_H__ */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 56dfa7a2a6f2..0fcd3045284f 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -52,7 +52,7 @@ obj-y				:= cputable.o ptrace.o syscalls.o \
 				   of_platform.o prom_parse.o
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
-				   paca.o nvram_64.o firmware.o
+				   paca.o nvram_64.o firmware.o note.o
 obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
diff --git a/arch/powerpc/kernel/note.S b/arch/powerpc/kernel/note.S
new file mode 100644
index 000000000000..bcdad15395dd
--- /dev/null
+++ b/arch/powerpc/kernel/note.S
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PowerPC ELF notes.
+ *
+ * Copyright 2019, IBM Corporation
+ */
+
+#include <linux/elfnote.h>
+#include <asm/elfnote.h>
+
+/*
+ * Ultravisor-capable bit (PowerNV only).
+ *
+ * Bit 0 indicates that the powerpc kernel binary knows how to run in an
+ * ultravisor-enabled system.
+ *
+ * In an ultravisor-enabled system, some machine resources are now controlled
+ * by the ultravisor. If the kernel is not ultravisor-capable, but it ends up
+ * being run on a machine with ultravisor, the kernel will probably crash
+ * trying to access ultravisor resources. For instance, it may crash in early
+ * boot trying to set the partition table entry 0.
+ *
+ * In an ultravisor-enabled system, a bootloader could warn the user or prevent
+ * the kernel from being run if the PowerPC ultravisor capability doesn't exist
+ * or the Ultravisor-capable bit is not set.
+ */
+#ifdef CONFIG_PPC_POWERNV
+#define PPCCAP_ULTRAVISOR_BIT		(1 << 0)
+#else
+#define PPCCAP_ULTRAVISOR_BIT		0
+#endif
+
+/*
+ * Add the PowerPC Capabilities in the binary ELF note. It is a bitmap that
+ * can be used to advertise kernel capabilities to userland.
+ */
+#define PPC_CAPABILITIES_BITMAP (PPCCAP_ULTRAVISOR_BIT)
+
+ELFNOTE(PowerPC, PPC_ELFNOTE_CAPABILITIES,
+	.long PPC_CAPABILITIES_BITMAP)
-- 
2.20.1
