From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 17/40] metag: IRQ handling
Date: Tue, 18 Dec 2012 13:25:03 +0000
Message-ID: <50D06EAF.4050200@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211091412.58733.arnd@arndb.de> <50ABAAE8.6070108@imgtec.com> <201211201615.30481.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:51591 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754354Ab2LRNZS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 18 Dec 2012 08:25:18 -0500
In-Reply-To: <201211201615.30481.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Grant <grant.likely@secretlab.ca>

On 20/11/12 16:15, Arnd Bergmann wrote:
> On Tuesday 20 November 2012, James Hogan wrote:
>> On 09/11/12 14:12, Arnd Bergmann wrote:
>>> On Wednesday 31 October 2012, James Hogan wrote:
>>>
>>>> diff --git a/arch/metag/include/asm/irq.h b/arch/metag/include/asm/irq.h
>>>> new file mode 100644
>>>> index 0000000..da24886
>>>> --- /dev/null
>>>> +++ b/arch/metag/include/asm/irq.h
>>>> +#ifndef HW_IRQS
>>>> +#define HW_IRQS  (HWSTATMETA_OFFSET_MAX + HWSTATEXT_OFFSET_MAX + \
>>>> +		HWSTATEXT2_OFFSET_MAX + HWSTATEXT4_OFFSET_MAX + \
>>>> +		HWSTATEXT6_OFFSET_MAX)
>>>> +#endif
>>>> +
>>>> +#define META_IRQS 32
>>>> +
>>>> +#define NR_IRQS (META_IRQS + HW_IRQS)
>>>
>>> I think you should use sparse IRQs right from the start and avoid
>>> hardcoding interrupt numbers from the start.
>>
>> I presume core irq numbers need hard coding (e.g. those required by core
>> code like cross-hardware-thread irqs and perf counters)? Or would the
>> recommended way be to have a function which is given the core hw irq
>> number and converts/maps a virtual irq for it using the irq domain?
> 
> Anything that is probed as a platform device can get the interrupt numbers
> using the device resources that are filled in by the device tree probe.
> 
> If you need something earlier, you can call irq_of_parse_and_map()
> manually.

So does that leave any way for a non-GPL driver to simply get an IRQ
number? Reading the code I can't find a way other than using legacy irq
domains (are they acceptable for new architecture ports?).
* I think the usual way is to specify an IRQ in a module parameter, but
that no longer makes any sense as it would need mapping.
irq_create_mapping could have worked (maybe taking advantage of the
irq_default_domain), but it's EXPORT_SYMBOL_GPL.
* Using a platform driver isn't possible because
platform_driver_register and friends are EXPORT_SYMBOL_GPL.
* Similarly irq_of_parse_and_map is EXPORT_SYMBOL_GPL (except for sparc
curiously enough).

So what would be the expected way to do that with linear irq domains?

Disclaimer: I don't maintain or work on such drivers, but like other
architectures in the kernel the ability needs to be supported one way or
another.

Thanks
James
