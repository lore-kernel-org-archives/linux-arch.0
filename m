From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/27] score: create head files elf.h emergency-restart.h errno.h
Date: Sun, 14 Jun 2009 00:23:06 +0200
Message-ID: <200906140023.06690.arnd@arndb.de>
References: <OF33B57F6A.69479DBB-ON482575D4.00247552-482575D4.002503BB@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64962 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962AbZFMWXd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 13 Jun 2009 18:23:33 -0400
In-Reply-To: <OF33B57F6A.69479DBB-ON482575D4.00247552-482575D4.002503BB@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

On Saturday 13 June 2009, liqin.chen@sunplusct.com wrote:
> > 
> > EMAXERRNO is mips specific right now. Do you actually need it somewhere?
> > 
> 
> Yes, I used it in entry.S, maybe I could remove this define latter.
> 

Ok. Note that the maximum error number that is supposed to get sent back
to user space is 511. Most architectures check the return value of the
system call to be between -4095 and zero upon entering user space.
Checking it in the kernel gives you the chance to override the
error status from a system call with force_successful_syscall_return().

If that is your intention, you should probably leave the definition in there.
Powerpc uses _LAST_ERRNO for the same purpose, which is somewhat inconsistent
with mips and also uses a different value to compare against.

	Arnd <><
