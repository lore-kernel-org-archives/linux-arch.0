Return-Path: <arnd@arndb.de>
Received: from natnoddy.rzone.de ([81.169.145.166]:13819 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S263932AbUEEIWz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 5 May 2004 04:22:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: static DEFINE_PER_CPU vs. modules
Date: Wed, 5 May 2004 10:21:12 +0200
References: <200405031741.52504.arnd@arndb.de> <20040504122352.2b554573.akpm@osdl.org> <16535.62156.173458.969241@napali.hpl.hp.com>
In-Reply-To: <16535.62156.173458.969241@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405051021.13944.arnd@arndb.de>
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, davidm@napali.hpl.hp.com, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 04 May 2004 21:45, David Mosberger wrote:
>   Andrew> But then things will work OK on x86 but there's a risk that
>   Andrew> s390 will see duplicated symbols at link-time.  Admittedly
>   Andrew> the risk is pretty low, but in that case the risk is also
>   Andrew> low on other architectures, so they can live with making the
>   Andrew> symbols global.
> 
>   Andrew> What's the concern?  Just the tidiness thing?
> 
> It's wrong to change the kernel just because it happens to be the easy
> way out.
> 
> Arnd said that using a "model(small)" attribute would lead to less
> efficient code, but wouldn't the same be true on s390x when dropping
> the "static"?

If we have a STATIC_DEFINE_PER_CPU, that could still be static even
on s390x for almost every per-cpu variable, except those (currently
two) in modules. That guarantees that there are no surprises with
duplicate symbols and still generate the best correct code on s390x.

However, I'm still not convinced that this is an s390x specific problem.
In theory, it can hit on every architecture that supports pc-relative
relocations (i.e. most of them). It's hard to trigger because you need SMP,
a certain (large) amount of RAM, and use the scsi or ipv6 as modules.
In the worst case it's almost impossible to debug (silent corruption of
a single word in memory).

I have verified that x86_64 with gcc-3.3 does not have the same problem
as s390x, but have no explanation why.

The patch below still changes the common, i.e. non-ia64/x86_64, per-cpu
implementation so that STATIC_DEFINE_PER_CPU is not static for modules
and static DEFINE_PER_CPU is forbidden for modules.
If desired, I could make a larger patch that also changes all non-module
instances of static DEFINE_PER_CPU to STATIC_DEFINE_PER_CPU so we get
more consistant here.

	Arnd <><

===== drivers/scsi/scsi.c 1.142 vs edited =====
--- 1.142/drivers/scsi/scsi.c	Sun Apr  4 17:01:05 2004
+++ edited/drivers/scsi/scsi.c	Wed May  5 09:48:58 2004
@@ -672,7 +672,7 @@
 /*
  * Per-CPU I/O completion queue.
  */
-static DEFINE_PER_CPU(struct list_head, scsi_done_q);
+STATIC_DEFINE_PER_CPU(struct list_head, scsi_done_q);
 
 /**
  * scsi_done - Enqueue the finished SCSI command into the done queue.
===== include/asm-generic/percpu.h 1.10 vs edited =====
--- 1.10/include/asm-generic/percpu.h	Mon Jan 19 07:28:34 2004
+++ edited/include/asm-generic/percpu.h	Wed May  5 09:58:30 2004
@@ -8,7 +8,7 @@
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
 /* Separate out the type, so (int[3], foo) works. */
-#define DEFINE_PER_CPU(type, name) \
+#define __DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
 
 /* var is in discarded region: offset to particular copy we want */
@@ -26,7 +26,7 @@
 } while (0)
 #else /* ! SMP */
 
-#define DEFINE_PER_CPU(type, name) \
+#define __DEFINE_PER_CPU(type, name) \
     __typeof__(type) per_cpu__##name
 
 #define per_cpu(var, cpu)			(*((void)cpu, &per_cpu__##var))
@@ -35,6 +35,16 @@
 #endif	/* SMP */
 
 #define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
+
+/* "static DEFINE_PER_CPU" breaks the module loader on some architectures,
+ * so use STATIC_DEFINE_PER_CPU instead if the code can be used in a module. */
+#ifndef MODULE
+#define DEFINE_PER_CPU(type, name) __DEFINE_PER_CPU(type, name)
+#define STATIC_DEFINE_PER_CPU(type, name) static __DEFINE_PER_CPU(type, name)
+#else
+#define DEFINE_PER_CPU(type, name) DECLARE_PER_CPU(type, name); __DEFINE_PER_CPU(type, name)
+#define STATIC_DEFINE_PER_CPU(type, name) __DEFINE_PER_CPU(type, name)
+#endif
 
 #define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
 #define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
===== include/asm-ia64/percpu.h 1.14 vs edited =====
--- 1.14/include/asm-ia64/percpu.h	Wed Feb 11 03:59:28 2004
+++ edited/include/asm-ia64/percpu.h	Wed May  5 10:08:21 2004
@@ -30,6 +30,8 @@
 	__attribute__((__section__(".data.percpu")))		\
 	__SMALL_ADDR_AREA __typeof__(type) per_cpu__##name
 
+#define STATIC_DEFINE_PER_CPU(type, name) static DEFINE_PER_CPU(type, name)
+
 /*
  * Pretty much a literal copy of asm-generic/percpu.h, except that percpu_modcopy() is an
  * external routine, to avoid include-hell.
===== include/asm-x86_64/percpu.h 1.10 vs edited =====
--- 1.10/include/asm-x86_64/percpu.h	Sat Aug 23 14:29:54 2003
+++ edited/include/asm-x86_64/percpu.h	Wed May  5 10:07:13 2004
@@ -18,6 +18,8 @@
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
 
+#define STATIC_DEFINE_PER_CPU(type, name) static DEFINE_PER_CPU(type, name)
+
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset(cpu)))
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
===== net/ipv6/icmp.c 1.49 vs edited =====
--- 1.49/net/ipv6/icmp.c	Fri Apr 16 22:54:44 2004
+++ edited/net/ipv6/icmp.c	Wed May  5 09:49:14 2004
@@ -76,7 +76,7 @@
  *
  *	On SMP we have one ICMP socket per-cpu.
  */
-static DEFINE_PER_CPU(struct socket *, __icmpv6_socket) = NULL;
+STATIC_DEFINE_PER_CPU(struct socket *, __icmpv6_socket) = NULL;
 #define icmpv6_socket	__get_cpu_var(__icmpv6_socket)
 
 static int icmpv6_rcv(struct sk_buff **pskb, unsigned int *nhoffp);
