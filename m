From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arc: use little endian accesses
Date: Thu, 10 Mar 2016 20:23:59 +0100
Message-ID: <201603102023.59425.arnd@arndb.de>
References: <1457544064-16167-1-git-send-email-ltrimas@synopsys.com> <C2D7FE5348E1B147BCA15975FBA23075F4E8F1A0@us01wembx1.internal.synopsys.com> <1457636268.457.34.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:56323 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbcCJTYe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Mar 2016 14:24:34 -0500
In-Reply-To: <1457636268.457.34.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lada Trimasova <Lada.Trimasova@synopsys.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "noamc@ezchip.com" <noamc@ezchip.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>

On Thursday 10 March 2016, Lada Trimasova wrote:
> Driver is 8250, kernel is built for BE arc, nsim option in model "nsim_isa_big_endian = 1".
> 
> With current "readl" and "writel" implementation for ARC we read word from memory without any endianess manipulation. So in case of little endian architecture we get what we want: the first memory byte is the low byte in the word. But in case of big endian architecture the word endianess is swapped: the first memory byte is the high word byte.
> 
> And for example, let's see what happens when we use "readl" in  function "serial8250_early_in" in driver/tty/serial/8250.
> 
> Take a look to one line from memory dump:
> 0xf0000010: 0x0b    0x00    0x00    0x00    0x60    0x00    0x00    0x00
> 
> When kernel is built for little endian architecture, we read this data in status register in function "serial_putc" using "readl" function in driver/tty/serial/8250 as:
> r0: 0x0000006
> The low byte is 0x0b, so the condition "if ((status & BOTH_EMPTY) == BOTH_EMPTY)"  is true, as BOTH_EMPTY is some mask with low bytes set.
> 
> When kernel is built with "CPU_BIG_ENDIAN" and model nsim option is "nsim_isa_big_endian=1", we read this data as:
> r0: 0x6000000
> So as you can see the low byte is 0x00 and above mentioned condition never becomes true, we can't continue initialization.
> 

Ok, this sounds like a completely normal architecture implementation then,
and your patch looks correct.

If some other driver breaks because of this change, you should investigate
what went wrong there, and treat it as a driver specific problem.

	Arnd
