Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:36823 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751350AbXFYMEy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Jun 2007 08:04:54 -0400
In-Reply-To: <20070625114742.GG22063@parisc-linux.org>
References: <1182761357.12109.14.camel@pmac.infradead.org> <20070625021145.b84ea186.akpm@linux-foundation.org> <20070625103535.GF22063@parisc-linux.org> <20070625110907.GA23438@flint.arm.linux.org.uk> <1182771454.12109.71.camel@pmac.infradead.org> <20070625114742.GG22063@parisc-linux.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2fc3aacccf036072f1b959e7b9ec3629@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on PowerPC and ARM
Date: Mon, 25 Jun 2007 14:04:19 +0200
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: David Woodhouse <dwmw2@infradead.org>, Russell King <rmk@arm.linux.org.uk>, torvalds@linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, drepper@redhat.com, paulus@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>> - Some architectures must align 64-bit integers into an aligned
>>   pair of registers. A slot may be wasted for padding.
>> - S390 may not have a 64-bit integer in slots 5/6.
>
> Uhm, doesn't sys_sync_file_range2 break that?
>
> +asmlinkage long compat_sys_sync_file_range2(int fd, unsigned int 
> flags,
> +                                  unsigned offset_hi, unsigned 
> offset_lo,
> +                                  unsigned nbytes_hi, unsigned 
> nbytes_lo)

I don't see any 64-bit integers here.

> Also, you might want to put something in the syscall file about signed
> vs unsigned arguments and how they behave with 32-on-64 systems.

"Both work / unsigned is better / use unsigned whenever
possible" -- but that's true for all C coding.  Wouldn't
hurt to repeat it though :-)


Segher

