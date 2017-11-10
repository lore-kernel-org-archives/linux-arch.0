Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:39942 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdKJVNK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Nov 2017 16:13:10 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 1/2] x86: Introduce sync_core_before_usermode
Date: Fri, 10 Nov 2017 16:12:48 -0500
Message-ID: <20171110211249.10742-2-mathieu.desnoyers@efficios.com>
In-Reply-To: <20171110211249.10742-1-mathieu.desnoyers@efficios.com>
References: <20171110211249.10742-1-mathieu.desnoyers@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, Maged Michael <maged.michael@gmail.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Andrea Parri <parri.andrea@gmail.com>, Russell King <linux@armlinux.org.uk>, Greg Hackmann <ghackmann@google.com>, Will Deacon <will.deacon@arm.com>, David Sehr <sehr@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-arch@vger.kernel.org
Message-ID: <20171110211248.zFQl0-l3eOfgwkCSw3VPD-a85eIXACSzIuL1VftL0ig@z>

Introduce an architecture function that ensures the current CPU
issues a core serializing instruction before returning to usermode.

This is needed to fix an existing core serialization bug on
thread migration, and also needed by the membarrier "sync_core" command.

Architectures defining the sync_core_before_usermode() static inline
need to define ARCH_HAS_SYNC_CORE_BEFORE_USERMODE.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Andy Lutomirski <luto@kernel.org>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Andrew Hunter <ahh@google.com>
CC: Maged Michael <maged.michael@gmail.com>
CC: Avi Kivity <avi@scylladb.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Dave Watson <davejwatson@fb.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Andrea Parri <parri.andrea@gmail.com>
CC: Russell King <linux@armlinux.org.uk>
CC: Greg Hackmann <ghackmann@google.com>
CC: Will Deacon <will.deacon@arm.com>
CC: David Sehr <sehr@google.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: x86@kernel.org
CC: linux-arch@vger.kernel.org
---
 arch/x86/Kconfig                 |  1 +
 arch/x86/include/asm/processor.h | 10 ++++++++++
 include/linux/processor.h        |  6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 01f78c1d40b5..54fbb8960d94 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -62,6 +62,7 @@ config X86
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
+	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_ZONE_DEVICE		if X86_64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index bdac19ab2488..6ce996a7c730 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -706,6 +706,16 @@ static inline void sync_core(void)
 #endif
 }
 
+/*
+ * Ensure that a core serializing instruction is issued before returning
+ * to user-mode. x86 implements return to user-space through sysexit and
+ * sysretq, which are not core serializing.
+ */
+static inline void sync_core_before_usermode(void)
+{
+	sync_core();
+}
+
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 extern void amd_e400_c1e_apic_setup(void);
 
diff --git a/include/linux/processor.h b/include/linux/processor.h
index dbc952eec869..7d12e6fa050e 100644
--- a/include/linux/processor.h
+++ b/include/linux/processor.h
@@ -68,4 +68,10 @@ do {								\
 
 #endif
 
+#ifndef ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
+static inline sync_core_before_usermode(void)
+{
+}
+#endif
+
 #endif /* _LINUX_PROCESSOR_H */
-- 
2.11.0
