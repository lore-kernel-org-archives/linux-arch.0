From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 4/6] openrisc: header file cleanups
Date: Tue,  8 May 2012 11:54:03 +0200
Message-ID: <1336470845-13859-5-git-send-email-jonas@southpole.se>
References: <1336470845-13859-1-git-send-email-jonas@southpole.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1336470845-13859-1-git-send-email-jonas@southpole.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Jonas Bonn <jonas@southpole.se>
List-Id: linux-arch.vger.kernel.org


elf.h: We can export some of these symbols to userspace.  libc needs them
and we just as well provide them as asm/elf.h as copying them into separate
libc headers.

ptrace.h: Having padding in the user_regs_struct isn't of any particular
value and just confuses GDB.  spr_defs isn't needed in userspace; libc
has its own copy anyway.

Signed-off-by: Jonas Bonn <jonas@southpole.se>
---
 arch/openrisc/include/asm/Kbuild   |    3 ++-
 arch/openrisc/include/asm/elf.h    |   12 ++++++++++--
 arch/openrisc/include/asm/ptrace.h |    6 ++----
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index dcea5a0..c936483 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,6 +1,7 @@
 include include/asm-generic/Kbuild.asm
 
-header-y += spr_defs.h
+header-y += elf.h
+header-y += ucontext.h
 
 generic-y += atomic.h
 generic-y += auxvec.h
diff --git a/arch/openrisc/include/asm/elf.h b/arch/openrisc/include/asm/elf.h
index 2ce603b..a8fe2c5 100644
--- a/arch/openrisc/include/asm/elf.h
+++ b/arch/openrisc/include/asm/elf.h
@@ -20,11 +20,17 @@
 #define __ASM_OPENRISC_ELF_H
 
 /*
+ * This files is partially exported to userspace.  This allows us to keep
+ * the ELF bits in one place which should assist in keeping the kernel and
+ * userspace in sync.
+ */
+
+/*
  * ELF register definitions..
  */
-#include <linux/types.h>
-#include <linux/ptrace.h>
 
+/* for struct user_regs_struct definition */
+#include <asm/ptrace.h>
 
 /* The OR1K relocation types... not all relevant for module loader */
 #define R_OR32_NONE	0
@@ -62,6 +68,8 @@ typedef unsigned long elf_fpregset_t;
 
 #ifdef __KERNEL__
 
+#include <linux/types.h>
+
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
diff --git a/arch/openrisc/include/asm/ptrace.h b/arch/openrisc/include/asm/ptrace.h
index 4651a73..8555c0c 100644
--- a/arch/openrisc/include/asm/ptrace.h
+++ b/arch/openrisc/include/asm/ptrace.h
@@ -19,8 +19,6 @@
 #ifndef __ASM_OPENRISC_PTRACE_H
 #define __ASM_OPENRISC_PTRACE_H
 
-#include <asm/spr_defs.h>
-
 #ifndef __ASSEMBLY__
 /*
  * This is the layout of the regset returned by the GETREGSET ptrace call
@@ -30,13 +28,13 @@ struct user_regs_struct {
 	unsigned long gpr[32];
 	unsigned long pc;
 	unsigned long sr;
-	unsigned long pad1;
-	unsigned long pad2;
 };
 #endif
 
 #ifdef __KERNEL__
 
+#include <asm/spr_defs.h>
+
 /*
  * Make kernel PTrace/register structures opaque to userspace... userspace can
  * access thread state via the regset mechanism.  This allows us a bit of
-- 
1.7.0.4
