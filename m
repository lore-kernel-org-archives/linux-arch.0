Return-Path: <arnd@arndb.de>
Received: from natnoddy.rzone.de ([81.169.145.166]:32164 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S263748AbUECPmh
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 May 2004 11:42:37 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: static DEFINE_PER_CPU vs. modules
Date: Mon, 3 May 2004 17:41:50 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405031741.52504.arnd@arndb.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

I got a bug report about loading some modules on s390 (for the
privileged, see http://bugzilla.suse.de/show_bug.cgi?id=38820).

The problem is that modules are loaded to a virtual address 
that is far away (roughly main memory size) from the percpu
kernel section, but s390x-gcc generates only 32-bit relocations
for static variables.
My suspicion is that there are some more architectures where
a relocation for static variables is not sufficient for per-cpu
data. Can anyone confirm this?

Fortunately, this currently occurs only in scsi.ko and ipv6.ko
even for allmodconfig, so these are trivial to work around by
changing the scope of the percpu variables.

The idea I had for preventing the same bug from happening
in the future is to provoke a compile error for modules using
'static DEFINE_PER_CPU', see patch below.
Alternatively, we could introduce a 'STATIC_DEFINE_PER_CPU'
that replaces 'static DEFINE_PER_CPU' for non-module builds,
or redefine 'DEFINE_PER_CPU' in include/asm-s390 in a way that
the 'static' get silently ignored for modules.

	Arnd <><

===== drivers/scsi/scsi.c 1.142 vs edited =====
--- 1.142/drivers/scsi/scsi.c	Sun Apr  4 17:01:05 2004
+++ edited/drivers/scsi/scsi.c	Thu Apr 29 17:59:34 2004
@@ -672,7 +672,7 @@
 /*
  * Per-CPU I/O completion queue.
  */
-static DEFINE_PER_CPU(struct list_head, scsi_done_q);
+DEFINE_PER_CPU(struct list_head, scsi_done_q);
 
 /**
  * scsi_done - Enqueue the finished SCSI command into the done queue.
===== include/asm-generic/percpu.h 1.10 vs edited =====
--- 1.10/include/asm-generic/percpu.h	Mon Jan 19 07:28:34 2004
+++ edited/include/asm-generic/percpu.h	Thu Apr 29 17:54:03 2004
@@ -7,8 +7,18 @@
 
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
+/* modules must not use "static DEFINE_PER_CPU", so add an
+ * extern declaration that causes a compile error if somebody
+ * attempts */
+#ifndef MODULE
+#define __PER_CPU_NOSTATIC(decl)
+#else
+#define __PER_CPU_NOSTATIC(decl) extern decl;
+#endif
+
 /* Separate out the type, so (int[3], foo) works. */
 #define DEFINE_PER_CPU(type, name) \
+    __PER_CPU_NOSTATIC(__typeof__(type) per_cpu__##name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
 
 /* var is in discarded region: offset to particular copy we want */
@@ -27,6 +37,7 @@
 #else /* ! SMP */
 
 #define DEFINE_PER_CPU(type, name) \
+    __PER_CPU_NOSTATIC(__typeof__(type) per_cpu__##name) \
     __typeof__(type) per_cpu__##name
 
 #define per_cpu(var, cpu)			(*((void)cpu, &per_cpu__##var))
===== net/ipv6/icmp.c 1.49 vs edited =====
--- 1.49/net/ipv6/icmp.c	Fri Apr 16 22:54:44 2004
+++ edited/net/ipv6/icmp.c	Thu Apr 29 17:59:58 2004
@@ -76,7 +76,7 @@
  *
  *	On SMP we have one ICMP socket per-cpu.
  */
-static DEFINE_PER_CPU(struct socket *, __icmpv6_socket) = NULL;
+DEFINE_PER_CPU(struct socket *, __icmpv6_socket) = NULL;
 #define icmpv6_socket	__get_cpu_var(__icmpv6_socket)
 
 static int icmpv6_rcv(struct sk_buff **pskb, unsigned int *nhoffp);
