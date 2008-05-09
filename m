From: Paul Mackerras <paulus@samba.org>
Subject: Re: =?us-ascii?Q?OF=20files?=
Date: Fri, 9 May 2008 16:11:29 +1000
Message-ID: <18467.60177.91772.136339@cargo.ozlabs.ibm.com>
References: <5257.8247-18740-1017760922-1209828638@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:58043 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759448AbYEIGLl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 May 2008 02:11:41 -0400
In-Reply-To: <5257.8247-18740-1017760922-1209828638@seznam.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Cc: =?us-ascii?Q?Arnd=20Bergmann?= <arnd@arndb.de>, =?us-ascii?Q?John=20Williams?= <john.williams@petalogix.com>, =?us-ascii?Q?Matthew=20Wilcox?= <matthew@wil.cx>, =?us-ascii?Q?Will=20Newton?= <will.newton@gmail.com>, =?us-ascii?Q?Linux=20Kernel=20list?= <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com, =?us-ascii?Q?Stephen=20Neuendorffer?= <stephen.neuendorffer@xilinx.com>, =?us-ascii?Q?John=20Linn?= <John.Linn@xilinx.com>, =?us-ascii?Q?Ulrich=20Drepper?= <drepper@redhat.com>

Michal Simek writes:

> I tested OF files changes. I sent you some patches about.
> 
> I look at headers files too. Is it possible to move prom.h,
> of_device.h and of_platform.h to asm-generic or linux folder? 

We can move stuff to drivers/of and include/linux, but we should only
move the parts that are truly architecture-independent.  We should not
have anything like #ifdef CONFIG_PPC_PSERIES in the files in those
directories.  If it needs an ifdef like that, then that part of the
file should stay under arch/powerpc.

In other words, it's OK to split files and end up with more files than
we have at present.  That's better than adding ifdefs.

Paul.
