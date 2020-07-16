From: Tulio Magno Quites Machado Filho <tuliom@linux.ibm.com>
Subject: Re: [PATCH v8 5/8] powerpc/vdso: Prepare for switching VDSO to generic C implementation.
Date: Thu, 16 Jul 2020 20:18:32 -0300
Message-ID: <87ft9rdp6f.fsf@linux.ibm.com>
References: <cover.1588079622.git.christophe.leroy@c-s.fr> <2a67c333893454868bbfda773ba4b01c20272a5d.1588079622.git.christophe.leroy@c-s.fr> <878sflvbad.fsf@mpe.ellerman.id.au> <20200715204725.Horde.5GZvsEv4ZkdzFHL76HZiFg8@messagerie.si.c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726846AbgGPXTV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jul 2020 19:19:21 -0400
In-Reply-To: <20200715204725.Horde.5GZvsEv4ZkdzFHL76HZiFg8@messagerie.si.c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-arch@vger.kernel.org, nathanl@linux.ibm.com, arnd@arndb.de, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Christophe Leroy <christophe.leroy@c-s.fr>, luto@kernel.org, tglx@linutronix.de, vincenzo.frascino@arm.com, linuxppc-dev@lists.ozlabs.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Michael Ellerman <mpe@ellerman.id.au> a écrit :
>
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> Prepare for switching VDSO to generic C implementation in following
>>> patch. Here, we:
>>> - Modify __get_datapage() to take an offset
>>> - Prepare the helpers to call the C VDSO functions
>>> - Prepare the required callbacks for the C VDSO functions
>>> - Prepare the clocksource.h files to define VDSO_ARCH_CLOCKMODES
>>> - Add the C trampolines to the generic C VDSO functions
>>>
>>> powerpc is a bit special for VDSO as well as system calls in the
>>> way that it requires setting CR SO bit which cannot be done in C.
>>> Therefore, entry/exit needs to be performed in ASM.
>>>
>>> Implementing __arch_get_vdso_data() would clobber the link register,
>>> requiring the caller to save it. As the ASM calling function already
>>> has to set a stack frame and saves the link register before calling
>>> the C vdso function, retriving the vdso data pointer there is lighter.
>> ...
>>
>>> diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h  
>>> b/arch/powerpc/include/asm/vdso/gettimeofday.h
>>> new file mode 100644
>>> index 000000000000..4452897f9bd8
>>> --- /dev/null
>>> +++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
>>> @@ -0,0 +1,175 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef __ASM_VDSO_GETTIMEOFDAY_H
>>> +#define __ASM_VDSO_GETTIMEOFDAY_H
>>> +
>>> +#include <asm/ptrace.h>
>>> +
>>> +#ifdef __ASSEMBLY__
>>> +
>>> +.macro cvdso_call funct
>>> +  .cfi_startproc
>>> +	PPC_STLU	r1, -STACK_FRAME_OVERHEAD(r1)
>>> +	mflr		r0
>>> +  .cfi_register lr, r0
>>> +	PPC_STL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)
>>
>> This doesn't work for me on ppc64(le) with glibc.
>>
>> glibc doesn't create a stack frame before making the VDSO call, so the
>> store of r0 (LR) goes into the caller's frame, corrupting the saved LR,
>> leading to an infinite loop.
>
> Where should it be saved if it can't be saved in the standard location ?

As Michael pointed out, userspace doesn't treat the VDSO as a normal function
call.  In order to keep compatibility with existent software, LR would need to
be saved on another stack frame.

-- 
Tulio Magno
