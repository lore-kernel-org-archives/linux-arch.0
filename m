Return-Path: <adsharma@sc.intel.com>
Received: from fmr03.intel.com ([143.183.121.5]:49126 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262934AbUB1CA2
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Feb 2004 21:00:28 -0500
Received: from talaria.sc.intel.com (talaria.sc.intel.com [10.3.253.5])
	by hermes.sc.intel.com (8.12.9-20030918-01/8.12.9/d: major-outer.mc,v 1.14 2004/01/09 00:51:16 root Exp $) with ESMTP id i1S1wTf5011765
	for <linux-arch@vger.kernel.org>; Sat, 28 Feb 2004 01:58:29 GMT
Received: from sc.intel.com (arun-desktop.sc.intel.com [143.183.85.199])
	by talaria.sc.intel.com (8.12.9-20030918-01/8.12.9/d: major-inner.mc,v 1.7 2003/12/18 18:58:10 root Exp $) with ESMTP id i1S22mKq016867
	for <linux-arch@vger.kernel.org>; Sat, 28 Feb 2004 02:02:48 GMT
Date: Fri, 27 Feb 2004 17:57:09 -0800
From: Arun Sharma <arun.sharma@intel.com>
Subject: compat tasks and O_LARGEFILE
Message-ID: <20040228015709.GB6897@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This code sequence in linux/fs/open.c:

> asmlinkage long sys_open(const char __user * filename, int flags, int mode)
> {
> 	char * tmp;
> 	int fd, error;
> 
> #if BITS_PER_LONG != 32
> 	flags |= O_LARGEFILE;
> #endif

is problematic for compat tasks. For eg: negative seeks can result in 
~4GB files getting created.

Are there any objections to letting a task reset this flag using a fcntl?
There are some corner cases, such as what if the file pointer is already
beyond 4GB etc, but I think they're solvable.

	-Arun
