Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:2138 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab2JMC34 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2012 22:29:56 -0400
Message-ID: <20121013022955.307620438@goodmis.org>
Date: Fri, 12 Oct 2012 22:26:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 20/25] sparc: Use Kbuild infrastructure to handle asm-generic headers
References: <20121013022632.024527228@goodmis.org>
Content-Disposition: inline; filename=0020-sparc-Use-Kbuild-infrastructure-to-handle-asm-generi.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20121013022652.o756pkCJ_zQknjNHcRhCjiLeImaZX_uu_XbuRcwEEEc@z>

From: Steven Rostedt <srostedt@redhat.com>

Use Kbuild infrastructure to handle the asm-generic headers
and remove the wrapper headers that call them.

This only affects headers that do nothing but include the generic
equivalent. It does not touch any header that does a little more.

Cc: linux-kbuild@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/sparc/include/asm/Kbuild              |    5 +++++
 arch/sparc/include/asm/cputime.h           |    6 ------
 arch/sparc/include/asm/emergency-restart.h |    6 ------
 arch/sparc/include/asm/kmap_types.h        |   10 ----------
 arch/sparc/include/uapi/asm/kvm_para.h     |    1 -
 arch/sparc/include/uapi/asm/statfs.h       |    6 ------
 6 files changed, 5 insertions(+), 29 deletions(-)
 delete mode 100644 arch/sparc/include/asm/cputime.h
 delete mode 100644 arch/sparc/include/asm/emergency-restart.h
 delete mode 100644 arch/sparc/include/asm/kmap_types.h
 delete mode 100644 arch/sparc/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/sparc/include/uapi/asm/statfs.h

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 10d54e5..22a0d45 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -1,10 +1,15 @@
 # User exported sparc header files
 
 
+generic-y += cputime.h
 generic-y += clkdev.h
+generic-y += emergency-restart.h
 generic-y += div64.h
 generic-y += exec.h
 generic-y += local64.h
 generic-y += irq_regs.h
+generic-y += kmap_types.h
+generic-y += kvm_para.h
 generic-y += local.h
+generic-y += statfs.h
 generic-y += word-at-a-time.h
diff --git a/arch/sparc/include/asm/cputime.h b/arch/sparc/include/asm/cputime.h
deleted file mode 100644
index 1a642b8..0000000
--- a/arch/sparc/include/asm/cputime.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __SPARC_CPUTIME_H
-#define __SPARC_CPUTIME_H
-
-#include <asm-generic/cputime.h>
-
-#endif /* __SPARC_CPUTIME_H */
diff --git a/arch/sparc/include/asm/emergency-restart.h b/arch/sparc/include/asm/emergency-restart.h
deleted file mode 100644
index 108d8c4..0000000
--- a/arch/sparc/include/asm/emergency-restart.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_EMERGENCY_RESTART_H
-#define _ASM_EMERGENCY_RESTART_H
-
-#include <asm-generic/emergency-restart.h>
-
-#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/arch/sparc/include/asm/kmap_types.h b/arch/sparc/include/asm/kmap_types.h
deleted file mode 100644
index aad2174..0000000
--- a/arch/sparc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-/* Dummy header just to define km_type.  None of this
- * is actually used on sparc.  -DaveM
- */
-
-#include <asm-generic/kmap_types.h>
-
-#endif
diff --git a/arch/sparc/include/uapi/asm/kvm_para.h b/arch/sparc/include/uapi/asm/kvm_para.h
deleted file mode 100644
index 14fab8f..0000000
--- a/arch/sparc/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/kvm_para.h>
diff --git a/arch/sparc/include/uapi/asm/statfs.h b/arch/sparc/include/uapi/asm/statfs.h
deleted file mode 100644
index 55e607a..0000000
--- a/arch/sparc/include/uapi/asm/statfs.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef ___ASM_SPARC_STATFS_H
-#define ___ASM_SPARC_STATFS_H
-
-#include <asm-generic/statfs.h>
-
-#endif
-- 
1.7.10.4


