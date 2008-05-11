From: Michal Simek <monstr@seznam.cz>
Subject: Re: OF files
Date: Sun, 11 May 2008 15:59:20 +0200
Message-ID: <4826FBB8.7060107@seznam.cz>
References: <5257.8247-18740-1017760922-1209828638@seznam.cz> <18467.60177.91772.136339@cargo.ozlabs.ibm.com>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:56362 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756696AbYEKN6N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 11 May 2008 09:58:13 -0400
In-Reply-To: <18467.60177.91772.136339@cargo.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Arnd Bergmann <arnd@arndb.de>, John Williams <john.williams@petalogix.com>, Matthew Wilcox <matthew@wil.cx>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, John Linn <John.Linn@xilinx.com>, Ulrich Drepper <drepper@redhat.com>

Hi All,

I move prom_parse.c to drivers/of.
of_platform.c was completely moved to drivers/of/platform.c
Functions from of_device.c was moved to drivers/of/device.c except
of_device_make_bus_id.
Prom.c file was cleaned - I remove all PPC specific code.

You can check it in my git tree (git.monstr.eu) or wait for next set of patches.

Michal

> Michal Simek writes:
> 
>> I tested OF files changes. I sent you some patches about.
>>
>> I look at headers files too. Is it possible to move prom.h,
>> of_device.h and of_platform.h to asm-generic or linux folder? 
> 
> We can move stuff to drivers/of and include/linux, but we should only
> move the parts that are truly architecture-independent.  We should not
> have anything like #ifdef CONFIG_PPC_PSERIES in the files in those
> directories.  If it needs an ifdef like that, then that part of the
> file should stay under arch/powerpc.
> 
> In other words, it's OK to split files and end up with more files than
> we have at present.  That's better than adding ifdefs.
> 
> Paul.
> 
