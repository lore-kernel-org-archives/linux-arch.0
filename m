From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 00/40] Meta Linux Kernel Port
Date: Fri, 9 Nov 2012 23:28:58 +0000
Message-ID: <509D91BA.7030309@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211091558.48022.arnd@arndb.de> <509D2D4F.20304@imgtec.com> <201211092155.36726.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56753 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779Ab2KIXaV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Nov 2012 18:30:21 -0500
In-Reply-To: <201211092155.36726.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>

On 09/11/12 21:55, Arnd Bergmann wrote:
> On Friday 09 November 2012, James Hogan wrote:
>> On 09/11/12 15:58, Arnd Bergmann wrote:
>>> On Friday 09 November 2012, James Hogan wrote:
>>>> On 09/11/12 15:06, Arnd Bergmann wrote:
>>>>>> +#define DM3_BASE (LINSYSDIRECT_BASE + (MMCU_DIRECTMAPn_ADDR_SCALE * 3))
>>>>>
>>>>> Again, don't hardcode MMIO addresses like this, but instead get them
>>>>> from the device tree to make the code more portable to future systems.
>>>>
>>>> Even if the addresses are part of the core architecture? I guess DT
>>>> could provide the blocks of registers, but it seems like unnecessary
>>>> overhead for something that will never change.
>>>
>>> The physical addresses might be part of the architecture, but it
>>> looks like you are hardcoding the virtual address here, which is
>>> the result of an ioremap operation or something similar (I have
>>> not looked at this example). It's probably fine to put it into
>>> fixmap if that provides a real advantage.
>>
>> Ah right, I see what you're getting at. Meta's virtual address space is
>> a little non-conventional, which I think makes our approach valid:
>>
>> 0x00000000-0x07ffffff and 0x80000000-0x87ffffff
>> non-mmuable, always directly maps to physical addresses. These contains
>> core registers, the io bus where SoC peripherals tend to go (so for
>> generic peripherals in this region we do use ioremap), and core memories
>> (same latency as L1 cache).
>>
>> 0x08000000-0x7fffffff and 0x88000000-0xffffffff
>> mmuable memory (but can't map the non-mmuable region)
> 
> Ah, interesting design. Do the two address ranges refer to the same
> registers, or are these two distinct areas?

No, the lower ones are the core/SoC registers, and the upper ones
contain core code and data memories (3 cycle latency, around 64KB of
each usually), and on some SoCs the boot ROM is included in there too.

> 
>> Therefore our ioremap() returns the input address for the non-mmuable
>> regions, and creates an MMU mapping otherwise. So we could ioremap these
>> addresses, but for such metag specific code it's faster and less
>> complicated not to bother.
>>
>> Unfortunately this is also part of the reason we have a prevalence of
>> readl/writel warnings when we remove the cast in io.h.
> 
> On ARM, we have a (purely software) way to create static mappings using
> huge pages for some of the I/O areas, which in effect comes down to
> something similar to what you have: If some driver calls ioremap,
> we just compute the right virtual address but don't install any new
> page table entries for any devices that were already mapped at boot
> time.

Interesting, sounds sort of similar.

> For any devices that may be used on other architectures, I would
> ask you to do the same and still call ioremap in the device driver.

Agreed.

> For stuff that is purely meta specifc and also mapped to a fixed location,
> it may be better to define your own I/O accessors, such as
> meta_in32()/meta_out32 that follow the semantics and calling
> conventions you need, rather than mixing them with the regular
> readl/writel accessors, even if they share a common implementation.

Yeh, that sounds like a good idea. Thanks.

Cheers
James
