Return-Path: <arnd@arndb.de>
Received: from natsmtp00.rzone.de ([81.169.145.165]:55977 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S264379AbUEDOSS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 May 2004 10:18:18 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: static DEFINE_PER_CPU vs. modules
Date: Tue, 4 May 2004 16:17:29 +0200
References: <200405031741.52504.arnd@arndb.de> <20040503193835.72c62ad8.akpm@osdl.org>
In-Reply-To: <20040503193835.72c62ad8.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405041617.37371.arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 04 May 2004 04:38, Andrew Morton wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > The idea I had for preventing the same bug from happening
> >  in the future is to provoke a compile error for modules using
> >  'static DEFINE_PER_CPU', see patch below.
> 
> It's not a big success with CONFIG_SMP=n.
> 
> kernel/fork.c:55: warning: return-type defaults to `int'
> kernel/fork.c: In function `__PER_CPU_NOSTATIC':

Sorry about that, I accidentally defined __PER_CPU_NOSTATIC
inside '#ifdef CONFIG_SMP'. This now builds with and without
SMP.

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
+++ edited/include/asm-generic/percpu.h	Tue May  4 15:59:18 2004
@@ -3,12 +3,23 @@
 #include <linux/compiler.h>
 
 #define __GENERIC_PER_CPU
+
+/* modules must not use "static DEFINE_PER_CPU", so add an
+ * extern declaration that causes a compile error if somebody
+ * attempts */
+#ifndef MODULE
+#define __PER_CPU_NOSTATIC(decl)
+#else
+#define __PER_CPU_NOSTATIC(decl) extern decl;
+#endif
+
 #ifdef CONFIG_SMP
 
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
 /* Separate out the type, so (int[3], foo) works. */
 #define DEFINE_PER_CPU(type, name) \
+    __PER_CPU_NOSTATIC(__typeof__(type) per_cpu__##name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
 
 /* var is in discarded region: offset to particular copy we want */
@@ -27,6 +38,7 @@
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
