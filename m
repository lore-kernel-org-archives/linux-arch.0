Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:46381 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754150AbeAQQ40 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jan 2018 11:56:26 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH for 4.16 06/11] Introduce sync_core_before_usermode
Date: Wed, 17 Jan 2018 11:54:53 -0500
Message-ID: <20180117165458.13330-7-mathieu.desnoyers@efficios.com>
In-Reply-To: <20180117165458.13330-1-mathieu.desnoyers@efficios.com>
References: <20180117165458.13330-1-mathieu.desnoyers@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, Maged Michael <maged.michael@gmail.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, "H . Peter Anvin" <hpa@zytor.com>, Andrea Parri <parri.andrea@gmail.com>, Russell King <linux@armlinux.org.uk>, Greg Hackmann <ghackmann@google.com>, Will Deacon <will.deacon@arm.com>, David Sehr <sehr@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-arch@vger.kernel.org
Message-ID: <20180117165453.lmD9tmnKYs4Qjnftw242XiI0S8oZi7wd0I3Jk4K1c4c@z>

Introduce an architecture function that ensures the current CPU
issues a core serializing instruction before returning to usermode.

This is needed for the membarrier "sync_core" command.

Architectures defining the sync_core_before_usermode() static inline
need to select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Thomas Gleixner <tglx@linutronix.de>
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
 include/linux/processor.h | 6 ++++++
 init/Kconfig              | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/processor.h b/include/linux/processor.h
index dbc952eec869..866de5326d34 100644
--- a/include/linux/processor.h
+++ b/include/linux/processor.h
@@ -68,4 +68,10 @@ do {								\
 
 #endif
 
+#ifndef CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
+static inline void sync_core_before_usermode(void)
+{
+}
+#endif
+
 #endif /* _LINUX_PROCESSOR_H */
diff --git a/init/Kconfig b/init/Kconfig
index 2d118b6adee2..30208da2221f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1918,3 +1918,6 @@ config ASN1
 	  functions to call on what tags.
 
 source "kernel/Kconfig.locks"
+
+config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
+	bool
-- 
2.11.0
