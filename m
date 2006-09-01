Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:4287 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751057AbWIATIH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2006 15:08:07 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k81J86po031563
	for <linux-arch@vger.kernel.org>; Fri, 1 Sep 2006 15:08:06 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k81J86SN374000
	for <linux-arch@vger.kernel.org>; Fri, 1 Sep 2006 13:08:06 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k81J86gn031242
	for <linux-arch@vger.kernel.org>; Fri, 1 Sep 2006 13:08:06 -0600
Subject: [PATCH 0/9] generic PAGE_SIZE infrastructure (v5)
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 01 Sep 2006 12:08:05 -0700
Message-Id: <20060901190805.C906A21A@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Dave Hansen <haveblue@us.ibm.com>
List-ID: <linux-arch.vger.kernel.org>

I went through a couple of rounds with these on linux-mm, and
linux-ia64, so I thought I'd give them one more round on linux-arch
before I send them into -mm.

Changes from v4:
- much improved help text (thanks to Christoph Lameter)

Changes from v3:
- fixed spurious delete of PTE_MASK in sh arch
- replaced ALIGN() macro with one which only evaluates the
  address a single time.  (Thanks Nikita)
- replaced ppc _ALIGN* definitions with include of align.h

Changes from v2:
- included get_order() code to make it safe to include
  generic/page.h everywhere (using ARCH_HAS_GET_ORDER)
- updated mm/Kconfig text to make it more fitting for ia64
- added patch to consolidate _ALIGN with kernel.h's ALIGN()
  The assembly one has been left alone, but I guess we could
  put it here.  However, the meaning of the two is quite different.

---

All architectures currently explicitly define their page size.  In some
cases (ppc, parisc, ia64, sparc64, mips) this size is somewhat
configurable.

There several reimplementations of ways to make sure that PAGE_SIZE
is usable in assembly code, yet still somewhat type safe for use in
C code (as a UL type).  These are all very similar.  There are also a
number of macros based off of PAGE_SIZE/SHIFT which are duplicated
across architectures.

This patch unifies all of those definitions.  It defines PAGE_SIZE in
a single header which gets its definitions from Kconfig.  The new
Kconfig options mirror what used to be done with #ifdefs and
arch-specific Kconfig options.  The new Kconfig menu eliminates
the need for parisc, ia64, and sparc64 to have their own "choice"
menus for selecting page size.  The help text has been adapted from
these three architectures, but is now more generic.

Why am I doing this?  The OpenVZ beancounter patch hooks into the
alloc_thread_info() path, but only in two architectures.  It is silly
to patch each and every architecture when they all just do the same
thing.  This is the first step to have a single place in which to
do alloc_thread_info().  Oh, and this series removes about 300 lines
of code.

  59 files changed, 217 insertions(+), 502 deletions(-)
