Return-Path: <sky@de.ibm.com>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:64927 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S264789AbUEERp0
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 5 May 2004 13:45:26 -0400
Date: Wed, 5 May 2004 19:42:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: static DEFINE_PER_CPU vs. modules
Message-ID: <20040505174222.GA1927@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: rth@twiddle.net
Cc: akpm@osdl.org, davidm@hpl.hp.com, arnd@arndb.de, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

> I would think it should be possible to work around the amd64
> compiler memory model thing by using inline assembly to access
> the movabsq instruction and thense the 64-bit relocation.

Ok, I'll bite. How about the following patch:

[PATCH] s390: fix per cpu for 64-bit modules.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Force the use of a 64 bit relocation to access the
per_cpu__##var variables and fix a problem in the
module loader regarding GOTENT and GOTPLTENT relocs.

diff -urN linux-2.6/arch/s390/kernel/module.c linux-2.6-s390/arch/s390/kernel/module.c
--- linux-2.6/arch/s390/kernel/module.c	Sun Apr  4 05:38:13 2004
+++ linux-2.6-s390/arch/s390/kernel/module.c	Wed May  5 19:40:22 2004
@@ -277,7 +277,8 @@
 			*(unsigned int *) loc = val;
 		else if (r_type == R_390_GOTENT ||
 			 r_type == R_390_GOTPLTENT)
-			*(unsigned int *) loc = val >> 1;
+			*(unsigned int *) loc =
+				(val + (Elf_Addr) me->module_core - loc) >> 1;
 		else if (r_type == R_390_GOT64 ||
 			 r_type == R_390_GOTPLT64)
 			*(unsigned long *) loc = val;
diff -urN linux-2.6/include/asm-s390/percpu.h linux-2.6-s390/include/asm-s390/percpu.h
--- linux-2.6/include/asm-s390/percpu.h	Sun Apr  4 05:38:20 2004
+++ linux-2.6-s390/include/asm-s390/percpu.h	Wed May  5 19:40:22 2004
@@ -5,10 +5,26 @@
 #include <asm/lowcore.h>
 
 /*
- * s390 uses the generic implementation for per cpu data, with the exception that
- * the offset of the cpu local data area is cached in the cpu's lowcore memory
+ * For builtin kernel code s390 uses the generic implementation for
+ * per cpu data, with the exception that the offset of the cpu local
+ * data area is cached in the cpu's lowcore memory
+ * For 64 bit module code s390 forces the use of a GOT slot for the
+ * address of the per cpu variable. This is needed because the module
+ * may be more than 4G above the per cpu area.
  */
+#if defined(__s390x__) && defined(MODULE)
+#define __get_got_cpu_var(var,offset) \
+  (*({ unsigned long *__ptr; \
+       asm ( "larl %0,per_cpu__"#var"@GOTENT" : "=a" (__ptr) ); \
+       ((typeof(&per_cpu__##var))((*__ptr) + offset)); \
+    }))
+#undef __get_cpu_var
+#define __get_cpu_var(var) __get_got_cpu_var(var,S390_lowcore.percpu_offset)
+#undef per_cpu
+#define per_cpu(var,cpu) __get_got_cpu_var(var,__per_cpu_offset[cpu])
+#else
 #undef __get_cpu_var
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, S390_lowcore.percpu_offset))
+#endif
 
 #endif /* __ARCH_S390_PERCPU__ */
