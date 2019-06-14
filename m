Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:32980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfFNMYn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Jun 2019 08:24:43 -0400
Subject: Re: [PATCH v6 03/19] kernel: Unify update_vsyscall implementation
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-4-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906141307430.1722@nanos.tec.linutronix.de>
 <a69e48a2-575d-255c-2653-d3e99b7ba760@arm.com>
 <alpine.DEB.2.21.1906141416100.1722@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9371eabc-ed74-3db8-794c-44c37ada2163@arm.com>
Date: Fri, 14 Jun 2019 13:25:21 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906141416100.1722@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>
Message-ID: <20190614122521.Ua87kbLwJG-CbQGcQEap0YFGLPhI8NhurFsYYZpNKGQ@z>

On 6/14/19 1:19 PM, Thomas Gleixner wrote:
> On Fri, 14 Jun 2019, Vincenzo Frascino wrote:
>> On 6/14/19 12:10 PM, Thomas Gleixner wrote:
>>> On Thu, 30 May 2019, Vincenzo Frascino wrote:
>>>> +
>>>> +	if (__arch_use_vsyscall(vdata)) {
>>>> +		vdata[CS_HRES_COARSE].cycle_last	=
>>>> +						tk->tkr_mono.cycle_last;
>>>> +		vdata[CS_HRES_COARSE].mask		=
>>>> +						tk->tkr_mono.mask;
>>>> +		vdata[CS_HRES_COARSE].mult		=
>>>> +						tk->tkr_mono.mult;
>>>
>>> These line breaks make it really hard to read. Can you fold in the patch
>>> below please?
>>>
>>
>> Thanks for this. I will do it in v7.
> 
> Talking about v7. I'd like to get this into 5.3. That means you'd have to
> rebase it on
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
> 
> to avoid the hyperv conflict. I'll sort this out with the hyperv folks how
> I can get these bits as a base for a tip branch which holds all the vdso
> pieces.
>

Ok, I will rebase and test the patches against the hyperv-next branch. Could you
please let me know when all the bits are sorted?

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo
