Return-Path: <arun.sharma@intel.com>
Received: from fmr03.intel.com ([143.183.121.5]:53966 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S265184AbUETSch
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 May 2004 14:32:37 -0400
Received: from talaria.sc.intel.com (talaria.sc.intel.com [10.3.253.5])
	by hermes.sc.intel.com (8.12.9-20030918-01/8.12.9/d: major-outer.mc,v 1.15 2004/01/30 18:16:28 root Exp $) with ESMTP id i4KIWtPR011416
	for <linux-arch@vger.kernel.org>; Thu, 20 May 2004 18:32:55 GMT
Received: from unix-os.sc.intel.com (unix-os.sc.intel.com [143.183.96.244])
	by talaria.sc.intel.com (8.12.9-20030918-01/8.12.9/d: major-inner.mc,v 1.10 2004/03/01 19:21:36 root Exp $) with ESMTP id i4KIWwic017802
	for <linux-arch@vger.kernel.org>; Thu, 20 May 2004 18:32:58 GMT
Received: from intel.com (adsharma-desk.amr.corp.intel.com [143.183.130.155])
	by unix-os.sc.intel.com (8.11.6/8.11.2) with ESMTP id i4KIWNF32091
	for <linux-arch@vger.kernel.org>; Thu, 20 May 2004 11:32:26 -0700
Message-ID: <40ACF9B7.30900@intel.com>
Date: Thu, 20 May 2004 11:32:23 -0700
From: Arun Sharma <arun.sharma@intel.com>
MIME-Version: 1.0
Subject: sys_getdents64 needs compat wrapper ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Running 32 bit ls on ia64 produces kernel mode unaligned faults with the attached backtrace on 2.6.6. I'm curious why this isn't a problem for other compat archs.

	-Arun

> 
> 0xa0000001000405e0 ia64_handle_unaligned
>         args (0x805f7cc, 0xe000000105aa7bc0)
>         kernel 0xa0000001000405e0 0xa000000100040d00
> 0xa00000010000e650 ia64_prepare_handle_unaligned+0x30
>         args (0x805f7cc, 0xe000000105aa7bc0)
>         kernel 0xa00000010000e620 0xa00000010000e680
> 0xa00000010000e080 ia64_leave_kernel
>         kernel 0xa00000010000e080 0xa00000010000e2e0
> 0xa000000100142480 filldir64+0xa0
>         args (0xe000000105aa7e20, 0xe0000001fa100008, 0x1, 0x0, 0x14eb01)
>         kernel 0xa0000001001423e0 0xa000000100142680
> 0xa000000100203400 ext3_readdir+0x660
>         args (0xe0000001fae79c80, 0xe000000105aa7e20, 
> 0xa0000001006bc720, 0xa000
> 0001001423e0, 0xe0000001fa100004)
>         kernel 0xa000000100202da0 0xa000000100203660
> 0xa000000100141f20 vfs_readdir+0x160
>         args (0xe0000001fae79c80, 0xa0000001006bc720, 
> 0xe000000105aa7e20, 0xa000
> 000100920000, 0xe0000001fd3968e0)
>         kernel 0xa000000100141dc0 0xa000000100141f60
> 0xa000000100142760 sys_getdents64+0xe0
>         args (0x3, 0x805f7cc, 0x4000, 0x805f7b0, 0x4015fd98)
>         kernel 0xa000000100142680 0xa000000100142820
> 
> 
