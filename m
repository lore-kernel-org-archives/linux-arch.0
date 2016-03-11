From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] arc: use little endian accesses
Date: Fri, 11 Mar 2016 12:44:28 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E8F790@us01wembx1.internal.synopsys.com>
References: <1457544064-16167-1-git-send-email-ltrimas@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E8F1A0@us01wembx1.internal.synopsys.com>
 <1457636268.457.34.camel@synopsys.com> <201603102023.59425.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:41354 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbcCKMoc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Mar 2016 07:44:32 -0500
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Lada Trimasova <Lada.Trimasova@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "noamc@ezchip.com" <noamc@ezchip.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>

On Friday 11 March 2016 12:54 AM, Arnd Bergmann wrote:
> On Thursday 10 March 2016, Lada Trimasova wrote:
>> Driver is 8250, kernel is built for BE arc, nsim option in model "nsim_isa_big_endian = 1".
>>
>> With current "readl" and "writel" implementation for ARC we read word from memory without any endianess manipulation. So in case of little endian architecture we get what we want: the first memory byte is the low byte in the word. But in case of big endian architecture the word endianess is swapped: the first memory byte is the high word byte.
>>
>> And for example, let's see what happens when we use "readl" in  function "serial8250_early_in" in driver/tty/serial/8250.
>>
>> Take a look to one line from memory dump:
>> 0xf0000010: 0x0b    0x00    0x00    0x00    0x60    0x00    0x00    0x00
>>
>> When kernel is built for little endian architecture, we read this data in status register in function "serial_putc" using "readl" function in driver/tty/serial/8250 as:
>> r0: 0x0000006
>> The low byte is 0x0b, so the condition "if ((status & BOTH_EMPTY) == BOTH_EMPTY)"  is true, as BOTH_EMPTY is some mask with low bytes set.
>>
>> When kernel is built with "CPU_BIG_ENDIAN" and model nsim option is "nsim_isa_big_endian=1", we read this data as:
>> r0: 0x6000000
>> So as you can see the low byte is 0x00 and above mentioned condition never becomes true, we can't continue initialization.
>>
> Ok, this sounds like a completely normal architecture implementation then,
> and your patch looks correct.
>
> If some other driver breaks because of this change, you should investigate
> what went wrong there, and treat it as a driver specific problem.

Although I believe Arnd the most, I was not convinced abt this (see below why) so
did a bit of investigation and looks like this patch is indeed correct and Arnd as
always is right :-)

The current upstream kernel doesn't boot on BE configured AXS103 is stuck
similarly in uart. With this patch it comes up fine. My trouble was I'd seen BE
work (w/o this patch) in our internal 3.18 branch. Turns out that in 3.18, ARC
io.h used the asm-generic version of readX(). My patch b8a033023994 ("ARCv2:
barriers") to upstream introduced the io barriers for ARCHS and in the process
introduced our own readX() accessors, which were not the same as correct
asm-generic ver. Thus I inadvertently introduced this bug.

@Lada I will fix up the changelog to add some of the background behind this
change, and mark this for stable backport as well.

Thx,
-Vineet

>
> 	Arnd
>
