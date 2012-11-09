From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 00/40] Meta Linux Kernel Port
Date: Fri, 9 Nov 2012 16:20:31 +0000
Message-ID: <509D2D4F.20304@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211091506.14940.arnd@arndb.de> <509D1F8C.4040501@imgtec.com> <201211091558.48022.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56868 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab2KIQUg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Nov 2012 11:20:36 -0500
In-Reply-To: <201211091558.48022.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>

On 09/11/12 15:58, Arnd Bergmann wrote:
> On Friday 09 November 2012, James Hogan wrote:
>> On 09/11/12 15:06, Arnd Bergmann wrote:
>>> On Wednesday 31 October 2012, James Hogan wrote:
> 
>>>> + * Despite being a 32bit architecture, Meta can do 64bit memory accesses
>>>> + * (assuming the bus supports it).
>>>> + */
>>>> +
>>>> +static inline u64 __raw_readq(const volatile void __iomem *addr)
>>>> +{
>>>> +	return *(const volatile u64 __force *) addr;
>>>> +}
>>>> +#define readq(addr) __raw_readq(addr)
>>>> +
>>>> +static inline void __raw_writeq(u64 b, volatile void __iomem *addr)
>>>> +{
>>>> +	*(volatile u64 __force *) addr = b;
>>>> +}
>>>> +#define writeq(b, addr) __raw_writeq(b, addr)
>>>
>>> These should be using an inline assembly to guarantee that it gets
>>> turned into an atomic access, at least of the architecture has
>>> an atomic 64-bit load/store from memory operation.
>>
>> Is there a particular case you have in mind where the compiler could be
>> expected not to generate an atomic memory op (I presume you mean e.g. 2
>> 32bit memory ops)? These are implemented the same as asm-generic/io.h
>> which only omits these ones because metag is 32bit.
>>
>> tbh I don't think the 64 bit accesses are ever actually used, so we
>> could probably drop these ones.
> 
> There is nothing forcing a compiler to turn a dereferece of a volatile
> pointer into a single load or store. We've had issues in the past
> where a such an access got turned into a series of byte accesses
> when an mmio data structure gets marked as '__packed', but it could
> happen in other occasions as well.

Okay fair enough. We'll use inline asm here instead.

>>>> +#define DM3_BASE (LINSYSDIRECT_BASE + (MMCU_DIRECTMAPn_ADDR_SCALE * 3))
>>>
>>> Again, don't hardcode MMIO addresses like this, but instead get them
>>> from the device tree to make the code more portable to future systems.
>>
>> Even if the addresses are part of the core architecture? I guess DT
>> could provide the blocks of registers, but it seems like unnecessary
>> overhead for something that will never change.
> 
> The physical addresses might be part of the architecture, but it
> looks like you are hardcoding the virtual address here, which is
> the result of an ioremap operation or something similar (I have
> not looked at this example). It's probably fine to put it into
> fixmap if that provides a real advantage.

Ah right, I see what you're getting at. Meta's virtual address space is
a little non-conventional, which I think makes our approach valid:

0x00000000-0x07ffffff and 0x80000000-0x87ffffff
non-mmuable, always directly maps to physical addresses. These contains
core registers, the io bus where SoC peripherals tend to go (so for
generic peripherals in this region we do use ioremap), and core memories
(same latency as L1 cache).

0x08000000-0x7fffffff and 0x88000000-0xffffffff
mmuable memory (but can't map the non-mmuable region)

Therefore our ioremap() returns the input address for the non-mmuable
regions, and creates an MMU mapping otherwise. So we could ioremap these
addresses, but for such metag specific code it's faster and less
complicated not to bother.

Unfortunately this is also part of the reason we have a prevalence of
readl/writel warnings when we remove the cast in io.h.

Thanks
James
