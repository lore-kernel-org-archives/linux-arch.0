Return-Path: <adsharma@sc.intel.com>
Received: from fmr03.intel.com ([143.183.121.5]:50108 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S261505AbUCFChs
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 5 Mar 2004 21:37:48 -0500
Date: Fri, 5 Mar 2004 18:37:40 -0800
From: Arun Sharma <arun.sharma@intel.com>
Subject: Re: SHMLBA and compat tasks
Message-ID: <20040306023740.GB2905@intel.com>
References: <20040228014128.GA6897@intel.com> <20040228155529.64bc0741.davem@redhat.com> <20040229021105.GA6964@intel.com> <20040229215752.3a6f0ce7.davem@redhat.com> <20040301193308.GA13305@intel.com> <16451.37325.109790.457348@napali.hpl.hp.com> <20040301201613.GA13349@intel.com> <20040301205510.GF25779@parcelfarce.linux.theplanet.co.uk> <20040302194302.GA17408@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20040302194302.GA17408@intel.com>
To: Matthew Wilcox <willy@debian.org>, davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 02, 2004 at 11:43:02AM -0800, Arun Sharma wrote:
> 
> I'm concerned that we'll have to duplicate/inline much of sys_shmat() in
> ipc/compat.c and it might become a maintenance problem. Perhaps there is 
> a way to do it in a better way, but I don't see it.
> 
> An ifdef in sys_shmat() that distinugishes between architectures that enforce 
> SHMLBA in all cases and the ones which don't would be ideal for my purposes.
> 

Since nobody objected to this approach, I'd like to propose this patch. 

	-Arun


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="shmat.patch"

Index: linux-2.6-cvs/include/asm-mips/shmparam.h
===================================================================
RCS file: /home/adsharma/disk2/cvs/linux-2.5/include/asm-mips/shmparam.h,v
retrieving revision 1.3
diff -d -u -r1.3 shmparam.h
--- linux-2.6-cvs/include/asm-mips/shmparam.h	23 Jun 2003 19:07:17 -0000	1.3
+++ linux-2.6-cvs/include/asm-mips/shmparam.h	3 Mar 2004 22:06:48 -0000
@@ -6,6 +6,8 @@
 #ifndef _ASM_SHMPARAM_H
 #define _ASM_SHMPARAM_H
 
+#define __ARCH_FORCE_SHMLBA	1
+
 #define	SHMLBA 0x40000			/* attach addr a multiple of this */
 
 #endif /* _ASM_SHMPARAM_H */
Index: linux-2.6-cvs/include/asm-parisc/shmparam.h
===================================================================
RCS file: /home/adsharma/disk2/cvs/linux-2.5/include/asm-parisc/shmparam.h,v
retrieving revision 1.3
diff -d -u -r1.3 shmparam.h
--- linux-2.6-cvs/include/asm-parisc/shmparam.h	30 Oct 2002 23:00:20 -0000	1.3
+++ linux-2.6-cvs/include/asm-parisc/shmparam.h	3 Mar 2004 22:06:55 -0000
@@ -1,6 +1,8 @@
 #ifndef _ASMPARISC_SHMPARAM_H
 #define _ASMPARISC_SHMPARAM_H
 
+#define __ARCH_FORCE_SHMLBA 	1
+
 #define SHMLBA 0x00400000   /* attach addr needs to be 4 Mb aligned */
 
 #endif /* _ASMPARISC_SHMPARAM_H */
Index: linux-2.6-cvs/include/asm-sparc/shmparam.h
===================================================================
RCS file: /home/adsharma/disk2/cvs/linux-2.5/include/asm-sparc/shmparam.h,v
retrieving revision 1.2
diff -d -u -r1.2 shmparam.h
--- linux-2.6-cvs/include/asm-sparc/shmparam.h	5 Feb 2002 17:40:40 -0000	1.2
+++ linux-2.6-cvs/include/asm-sparc/shmparam.h	3 Mar 2004 22:07:08 -0000
@@ -2,6 +2,8 @@
 #ifndef _ASMSPARC_SHMPARAM_H
 #define _ASMSPARC_SHMPARAM_H
 
+#define __ARCH_FORCE_SHMLBA 	1
+
 extern int vac_cache_size;
 #define SHMLBA (vac_cache_size ? vac_cache_size : \
 		(sparc_cpu_model == sun4c ? (64 * 1024) : \
Index: linux-2.6-cvs/include/asm-sparc64/shmparam.h
===================================================================
RCS file: /home/adsharma/disk2/cvs/linux-2.5/include/asm-sparc64/shmparam.h,v
retrieving revision 1.3
diff -d -u -r1.3 shmparam.h
--- linux-2.6-cvs/include/asm-sparc64/shmparam.h	5 Feb 2002 20:20:15 -0000	1.3
+++ linux-2.6-cvs/include/asm-sparc64/shmparam.h	3 Mar 2004 22:07:01 -0000
@@ -4,6 +4,7 @@
 
 #include <asm/spitfire.h>
 
+#define __ARCH_FORCE_SHMLBA	1
 /* attach addr a multiple of this */
 #define	SHMLBA	((PAGE_SIZE > L1DCACHE_SIZE) ? PAGE_SIZE : L1DCACHE_SIZE)
 
Index: linux-2.6-cvs/ipc/shm.c
===================================================================
RCS file: /home/adsharma/disk2/cvs/linux-2.5/ipc/shm.c,v
retrieving revision 1.32
diff -d -u -r1.32 shm.c
--- linux-2.6-cvs/ipc/shm.c	31 Aug 2003 18:32:59 -0000	1.32
+++ linux-2.6-cvs/ipc/shm.c	3 Mar 2004 22:04:43 -0000
@@ -655,8 +655,11 @@
 		if (addr & (SHMLBA-1)) {
 			if (shmflg & SHM_RND)
 				addr &= ~(SHMLBA-1);	   /* round down */
-			else
-				return -EINVAL;
+			else 
+#ifndef __ARCH_FORCE_SHMLBA
+				if (addr & ~PAGE_MASK)
+#endif
+					return -EINVAL;
 		}
 		flags = MAP_SHARED | MAP_FIXED;
 	} else {

--OXfL5xGRrasGEqWY--
