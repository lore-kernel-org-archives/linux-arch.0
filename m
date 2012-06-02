From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/27] smpboot: Provide a generic method to boot	secondary
 processors
Date: Sat, 02 Jun 2012 21:04:29 +0530
Message-ID: <4FCA3285.8070804@linux.vnet.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com> <20120601091008.31979.93586.stgit@srivatsabhat.in.ibm.com> <20120601165322.GB18870@merkur.ravnborg.org> <4FC94518.4010908@linux.vnet.ibm.com> <20120602151602.GB17409@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:42980 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782Ab2FBPf1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 2 Jun 2012 11:35:27 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Sat, 2 Jun 2012 15:26:32 +1000
In-Reply-To: <20120602151602.GB17409@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, Suresh Siddha <suresh.b.siddha@intel.com>, Venkatesh Pallipadi <venki@google.com>

On 06/02/2012 08:46 PM, Sam Ravnborg wrote:

> On Sat, Jun 02, 2012 at 04:11:28AM +0530, Srivatsa S. Bhat wrote:
>> On 06/01/2012 10:23 PM, Sam Ravnborg wrote:
>>
>>>> +
>>>> +
>>>> +/* Implement the following functions in your architecture, as appropriate. */
>>>> +
>>>> +/**
>>>> + * __cpu_pre_starting()
>>>> + *
>>>> + * Implement whatever you need to do before the CPU_STARTING notifiers are
>>>> + * invoked. Note that the CPU_STARTING callbacks run *on* the cpu that is
>>>> + * coming up. So that cpu better be prepared! IOW, implement all the early
>>>> + * boot/init code for the cpu here. And do NOT enable interrupts.
>>>> + */
>>>> +#ifndef __cpu_pre_starting
>>>> +void __weak __cpu_pre_starting(void *arg) {}
>>>> +#endif
>>>
>>> I miss the prototype for this in a header?
>>
>>
>> Prototype is not really necessary for this. Hence not added.
> There is a simple rule:
> 1) If a function is declared => not static
> 2) If function not declared => static
> 
> With respect to this simple rule your functions shall be defined as static.
> And that would not work.
> 


Fair enough. Will add prototypes in include/linux/smpboot.h

Thanks you!

Regards,
Srivatsa S. Bhat
