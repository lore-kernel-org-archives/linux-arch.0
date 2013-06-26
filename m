From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] include/asm-generic/io.h: add 'UML' case just like 'no-MMU'
Date: Wed, 26 Jun 2013 10:05:26 +0200
Message-ID: <51CAA0C6.60007@nod.at>
References: <51CA8AB8.7080504@asianux.com> <51CA900E.9020407@nod.at> <51CA9E92.4000107@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from b.ns.miles-group.at ([95.130.255.144]:1661 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751731Ab3FZIFd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 Jun 2013 04:05:33 -0400
In-Reply-To: <51CA9E92.4000107@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Jeff Dike <jdike@addtoit.com>, Arnd Bergmann <arnd@arndb.de>, dhsharp@google.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Hi!

Am 26.06.2013 09:56, schrieb Chen Gang:
> On 06/26/2013 02:54 PM, Richard Weinberger wrote:
>> Hi!
>>
>> Am 26.06.2013 08:31, schrieb Chen Gang:
>>> For "User Mode Linux", it may enable 'MMU', but not need implement
>>> ioremap and iounmap, so "include/asm-generic/io.h" need notice this
>>> case to keep itself 'generic'.
>>>
>>> The related error (with allmodconfig, without pcap):
>>>
>>>     CC [M]  drivers/ptp/ptp_pch.o
>>>   drivers/ptp/ptp_pch.c: In function =EF=BF=BDpch_remove=EF=BF=BD:
>>>   drivers/ptp/ptp_pch.c:571:3: error: implicit declaration of funct=
ion =EF=BF=BDiounmap=EF=BF=BD [-Werror=3Dimplicit-function-declaration]
>>>   drivers/ptp/ptp_pch.c: In function =EF=BF=BDpch_probe=EF=BF=BD:
>>>   drivers/ptp/ptp_pch.c:621:2: error: implicit declaration of funct=
ion =EF=BF=BDioremap=EF=BF=BD [-Werror=3Dimplicit-function-declaration]
>>>   drivers/ptp/ptp_pch.c:621:13: warning: assignment makes pointer f=
rom integer without a cast [enabled by default]
>>>   cc1: some warnings being treated as errors
>>>
>>>
>>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>>> ---
>>>  arch/um/include/asm/Kbuild |    1 +
>>>  include/asm-generic/io.h   |    6 +++---
>>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuil=
d
>>> index b30f34a..a34ea5d 100644
>>> --- a/arch/um/include/asm/Kbuild
>>> +++ b/arch/um/include/asm/Kbuild
>>> @@ -3,3 +3,4 @@ generic-y +=3D hw_irq.h irq_regs.h kdebug.h percpu.=
h sections.h topology.h xor.h
>>>  generic-y +=3D ftrace.h pci.h io.h param.h delay.h mutex.h current=
=2Eh exec.h
>>>  generic-y +=3D switch_to.h clkdev.h
>>>  generic-y +=3D trace_clock.h
>>> +generic-y +=3D io.h
>>
>> We include that file already. See three lines above.
>>
>=20
> Oh, really it is, thanks.
>=20
>>> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
>>> index d5afe96..e80331d 100644
>>> --- a/include/asm-generic/io.h
>>> +++ b/include/asm-generic/io.h
>>> @@ -303,10 +303,10 @@ static inline void *phys_to_virt(unsigned lon=
g address)
>>>  /*
>>>   * Change "struct page" to physical address.
>>>   *
>>> - * This implementation is for the no-MMU case only... if you have =
an MMU
>>> + * This implementation is for the no-MMU or UML case only... if yo=
u have an MMU
>>>   * you'll need to provide your own definitions.
>>>   */
>>> -#ifndef CONFIG_MMU
>>> +#if !CONFIG_MMU || CONFIG_UML
>>>  static inline void __iomem *ioremap(phys_addr_t offset, unsigned l=
ong size)
>>>  {
>>>  	return (void __iomem*) (unsigned long)offset;
>>> @@ -325,7 +325,7 @@ static inline void __iomem *ioremap(phys_addr_t=
 offset, unsigned long size)
>>>  static inline void iounmap(void __iomem *addr)
>>>  {
>>>  }
>>> -#endif /* CONFIG_MMU */
>>> +#endif /* !CONFIG_MMU || CONFIG_UML */
>>> =20
>>>  #ifdef CONFIG_HAS_IOPORT
>>>  #ifndef CONFIG_GENERIC_IOMAP
>>>
>>
>> UML has no io memory but a MMU, so I'd argue that you better fix dri=
vers/ptp/ptp_pch.c dependencies.
>> _If_ ptp_pch.c really works without real io memory, you can look wha=
t I did in my GENERIC_IO series[1]
>> to make nandsim work on UML. Maybe this helps.
>>
>=20
> But "no io memory" is not the excuse to not define the related dummy
> function.

UML has no io memory, period.
Same applies for s390, it also includes asm-generic/io.h in the !CONFIG=
_PCI
case.
UML and s390 are very special here.


> The drivers internal code has already check the related return value,
> so it is the architecture's duty to 'tell' the driver whether support
> io memory (e.g. define ioremap, but return NULL).

It does so already by setting CONFIG_HAS_IOMEM=3Dn

Thanks,
//richard
