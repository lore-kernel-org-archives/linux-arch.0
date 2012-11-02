Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:51857 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927Ab2KBKGc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 2 Nov 2012 06:06:32 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [balbi-usb:xceiv 3/3] drivers/usb/phy/rcar-phy.c:75:3: error: implicit declaration of function 'iowrite32'
References: <20121101130420.GB20982@kroah.com>
	<20121101132342.GE12489@arwen.pp.htv.fi> <87k3u5h296.fsf@nemi.mork.no>
	<20121101.110658.149879582446959580.davem@davemloft.net>
	<20121102091620.GE17938@arwen.pp.htv.fi>
Date: Fri, 02 Nov 2012 11:05:35 +0100
In-Reply-To: <20121102091620.GE17938@arwen.pp.htv.fi> (Felipe Balbi's message
	of "Fri, 2 Nov 2012 11:16:20 +0200")
Message-ID: <87liekz5e8.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: balbi@ti.com
Cc: David Miller <davem@davemloft.net>, gregkh@linuxfoundation.org, linux-arch@vger.kernel.org, fengguang.wu@intel.com, kuninori.morimoto.gx@renesas.com, linux-usb@vger.kernel.org
Message-ID: <20121102100535.AwS3ajh6jYx_KBuYuMA2Tc7sAQ4-n1JUJJvpUxROwco@z>

Felipe Balbi <balbi@ti.com> writes:
> On Thu, Nov 01, 2012 at 11:06:58AM -0400, David Miller wrote:
>> From: Bjørn Mork <bjorn@mork.no>
>> Date: Thu, 01 Nov 2012 14:38:29 +0100
>> 
>> > Felipe Balbi <balbi@ti.com> writes:
>> > 
>> >> btw, only alpha and x86 seem to be providing all of those, but if you
>> >> look into our documentation, it's said that drivers are supposed to use
>> >> write/read{b,w,l,q} for all memory-mapped io. I'd expect all platforms
>> >> to provide those even if just to allow compilation of drivers.
>> > 
>> > Only if HAS_IOMEM is true, I believe.
>> 
>> This is correct.
>
> fair enough, then we can depend on HAS_IOMEM.
>
> Another question, if HAS_IOMEM is true, is the arch expected to provide
> *all* accessor methods ?

I'll leave this for those with more clue...

But there is a comment in arch/alpha/include/asm/io.h indicating that
writeq/readq support is tested separately, so I guess it must be
optional:

/*
 * Some mucking forons use if[n]def writeq to check if platform has it.
 * It's a bloody bad idea and we probably want ARCH_HAS_WRITEQ for them
 * to play with; for now just use cpp anti-recursion logics and make sure
 * that damn thing is defined and expands to itself.
 */

#define writeq writeq
#define readq readq


> And the last one: if the arch provides
> read/write{b,w,l,q}, should it be selecting HAS_IOMEM ??

But that one is easy: HAS_IOMEM is true by default.  The arch sets
NO_IOMEM to disable it. Similar to HAS_DMA.  So you can be pretty sure
that HAS_IOMEM is selected unless the arch has reasons not to.  From
lib/Kconfig:

config HAS_IOMEM
        boolean
        depends on !NO_IOMEM
        select GENERIC_IO
        default y



Bjørn
