Return-Path: <adsharma@sc.intel.com>
Received: from fmr03.intel.com ([143.183.121.5]:22497 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263243AbUB1Boq
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Feb 2004 20:44:46 -0500
Received: from talaria.sc.intel.com (talaria.sc.intel.com [10.3.253.5])
	by hermes.sc.intel.com (8.12.9-20030918-01/8.12.9/d: major-outer.mc,v 1.14 2004/01/09 00:51:16 root Exp $) with ESMTP id i1S1gmf5005839
	for <linux-arch@vger.kernel.org>; Sat, 28 Feb 2004 01:42:48 GMT
Received: from sc.intel.com (arun-desktop.sc.intel.com [143.183.85.199])
	by talaria.sc.intel.com (8.12.9-20030918-01/8.12.9/d: major-inner.mc,v 1.7 2003/12/18 18:58:10 root Exp $) with ESMTP id i1S1l7Kq011765
	for <linux-arch@vger.kernel.org>; Sat, 28 Feb 2004 01:47:07 GMT
Date: Fri, 27 Feb 2004 17:41:28 -0800
From: Arun Sharma <arun.sharma@intel.com>
Subject: SHMLBA and compat tasks
Message-ID: <20040228014128.GA6897@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The current Linux implementation of shmat() insists on SHMLBA alignment
even when shmflg & SHM_RND == 0. This is not consistent with the man pages
and the single UNIX spec, which require only a page-aligned address.

man page:

> If shmaddr isn’t NULL and SHM_RND is asserted  in  shmflg,  the  attach
> occurs at the address equal to shmaddr rounded down to the nearest mul-
> tiple of SHMLBA.  Otherwise shmaddr must be a page-aligned  address  at
> which the attach occurs.

This is not a problem for many platforms because SHMLBA == PAGE_SIZE. It's
also not a problem for 64 bit programs running on 64 bit platforms,
because arch_get_unmapped_area() typically guarantees SHMLBA alignment,
even when SHM_RND is not asserted.

However, for 32 bit compatiblity programs, an innocuous sequence such as:

p = shmat(id, 0, shmflg)  /* shmflag & SHM_RND == 0 */
/* p is page-aligned, but may not be SHMLBA aligned */
shmdt(p)
shmat(id, p, shmflg) == -EINVAL ??

can fail. The attached patch fixes the problem for ia64. Can other arch
maintainers confirm that it doesn't break anything for you ?

	-Arun

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="shmat.patch"

--- linux/ipc/shm.c.orig	2003-04-28 11:19:24.000000000 -0700
+++ linux/ipc/shm.c	2003-05-09 13:26:13.000000000 -0700
@@ -600,7 +600,7 @@
 		if (addr & (SHMLBA-1)) {
 			if (shmflg & SHM_RND)
 				addr &= ~(SHMLBA-1);	   /* round down */
-			else
+			else if (addr & ~PAGE_MASK)
 				return -EINVAL;
 		}
 		flags = MAP_SHARED | MAP_FIXED;

--W/nzBZO5zC0uMSeA--
