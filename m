Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <429AFDB4.5090706@yahoo.com.au>
Date: Mon, 30 May 2005 21:49:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Lots of possible arch breakage in cpu_idle!!
References: <OFB45EDFAC.AFFB6ECD-ONC1257011.003ED09F-C1257011.003F9081@de.ibm.com>
In-Reply-To: <OFB45EDFAC.AFFB6ECD-ONC1257011.003ED09F-C1257011.003F9081@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Zankel <czankel@tensilica.com>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
List-ID: <linux-arch.vger.kernel.org>

Martin Schwidefsky wrote:
>>>Well, currently there seems to be only the pfault interrupt that can
>>>set TIF_NEED_RESCHED and pfault interrupts can't happen for idle. So
>>>it should work. But if there is any chance that an interrupt will ever
>>>set TIF_NEED_RESCHED we have to disable the interrupts before doing
>>>the resched check.
>>
>>But other processors can set your TIF_NEED_RESCHED too,
>>so simply disabling local interrupts does not give any
>>synchronisation of TIF_NEED_RESCHED.
> 
> 
> But these other processors need to send the idle cpu an IPI to make it
> aware of the TIF_NEED_RESCHED bit. The order of events is important
> here. While the interrupts are disabled the IPI is pending, only after
> the enabled-wait psw has been loaded the IPI interrupts comes in.
> 

Yep.

> After you threw in set_bit(TIF_NEED_RESCHED) from another processor
> I realized that without the local_irq_disable() the code would even be
> wrong. We can loose a reschedule without it, consider the following:
> cpu-a checks for reschedule, cpu-b sets TIF_NEED_RESCHED, cpu-b sends
> IPI, cpu-a receives IPI as external interrupt, cpu-a continues in
> default_idle() after the reschedule check. With the NO_IDLE_HZ option
> the cpu-a can now wait for a very long time until the next interrupt
> wakes it up again.
> 

OK, thanks. I'll restore s390's behaviour in the next rev.

Send instant messages to your online friends http://au.messenger.yahoo.com 
